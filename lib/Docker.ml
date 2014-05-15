open Core.Std
open Async.Std
open Cohttp
open Cohttp_async
open Docker_t
open Docker_j

exception NoSuchContainer of string

exception DockerException of string 

let make_exn resp =
  DockerException (Sexp.to_string_hum (Response.sexp_of_t resp))

let docker_socket = 
  Uri.with_host (Uri.of_string "unix:") (Some "/var/run/docker.sock")

let docker_uri (path : string) = Uri.with_path docker_socket path

let version () : string Deferred.t = 
  Client.get (docker_uri "/version")
  >>= fun (resp, body) ->
  if resp.Cohttp.Response.status = `OK then
    Body.to_string body
    >>= fun body ->
    return (version_of_string body).version
  else
    raise (make_exn resp)

(* Ill-formed, but used to create valid containerCfgs *)
let empty_containerCfg = { 
  image = "";
  hostname = "";
  user = "";
  memory = 0L;
  memorySwap = 0L;
  attachStdin = false;
  attachStdout = true;
  attachStderr = true;
  stdinOnce = false;
  networkDisabled = false;
  exposedPorts = [];
  volumes = [];
  openStdin = false;
  tty = false;
  env = [];
  workingDir = "";
  entryPoint = [];
  cmd = [];
}

let container_with_cmd ~(image:string) (cmd : string list) =
  { empty_containerCfg with image = image; cmd = cmd }

let container_with_entrypoint ~(image:string) (entrypoint : string list) =
  { empty_containerCfg with image = image; entryPoint = entrypoint }

let create_container (cfg : containerConfig) : 
  createContainerResponse Deferred.t =
  let body = Body.of_string (string_of_containerConfig cfg) in
  printf "Sending %s\n%!" (string_of_containerConfig cfg);
  Client.post ~body (docker_uri "/containers/create")
  >>= fun (resp, body) ->
  if resp.Cohttp.Response.status = `Created then
    Body.to_string body
    >>= fun body ->
    return (createContainerResponse_of_string body)
  else
    raise (make_exn resp)

let emptyHostCfg = { binds = [] }

let start_container ?(hostConfig = emptyHostCfg)
  (id : string) : unit Deferred.t =
  let body = Body.of_string (string_of_hostConfig hostConfig) in
  Client.post ~body (docker_uri ("/containers/" ^ id ^ "/start"))
  >>= fun (resp, body) ->
  match resp.Cohttp.Response.status with
    | `No_content -> return ()
    | `Not_found -> raise (NoSuchContainer id)
    | _ -> raise (make_exn resp)


let wait_for_container (id : string) : int Deferred.t =
  let body = Body.of_string "" in
  Client.post ~body (docker_uri ("/containers/" ^ id ^ "/wait"))
  >>= fun (resp, body) ->
  match resp.Cohttp.Response.status with
    | `OK -> 
      Body.to_string body
      >>= fun body ->
      return (waitResponse_of_string body).statusCode
    | `Not_found -> raise (NoSuchContainer id)
    | _ -> raise (make_exn resp)

let delete_container ?(volumes = false) ?(force = false) (id : string)
  : unit Deferred.t =
  let path = "/containers/" ^ id in
  let query = [ ("force", string_of_bool force);
                ("v", string_of_bool volumes) ] in
  Client.delete (Uri.with_query' (Uri.with_path docker_socket path) query)
  >>= fun (resp, _) ->
  match resp.Cohttp.Response.status with
  | `No_content -> return ()
  | `Not_found -> raise (NoSuchContainer id)
  | _ -> raise (make_exn resp)

let container_logs ?(stdout = false) ?(stderr = false) 
  (id : string) : string Deferred.t =
  let path = "/containers/" ^ id ^ "/attach" in
  let query = [ ("logs", "true");
                ("stdout", string_of_bool stdout);
                ("stderr", string_of_bool stderr) ] in
  let body = Body.of_string "" in
  Client.post (Uri.with_query' (docker_uri path) query) ~body
  >>= fun (resp, body) ->
  match resp.Cohttp.Response.status with
  | `OK -> 
    Body.to_string body
    >>= fun body ->
    return body
  | `Not_found ->
     raise (NoSuchContainer id)
  | _ -> raise (make_exn resp)

(* TODO(arjun): Does not work. *)
let copy_from_container ~(id : string) ~(path : string)
  : (string Pipe.Reader.t) Deferred.t =
  let path = "/containers/" ^ id ^ "/copy" in
  let body = Body.of_string (string_of_copyRequest { resource = path; hostPath = "." }) in
  Client.post ~body (Uri.with_path docker_socket path)
  >>= fun (resp, body) ->
  match resp.Cohttp.Response.status with
  | `OK -> return (Body.to_pipe body)
  | `Not_found -> raise (NoSuchContainer id)
  | _ -> raise (make_exn resp)
