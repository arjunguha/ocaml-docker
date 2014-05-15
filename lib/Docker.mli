open Core.Std
open Async.Std

type hostConfig = Docker_t.hostConfig = {
  binds: string list;
  containerIDFile: string;
  lxcConf: string list;
  privileged: bool;
  publishAllPorts: bool;
  portBindings: (string * string) list;
  links : Yojson.Safe.json
}

type containerConfig = Docker_j.containerConfig = {
  image: string;
  hostname: string;
  user: string;
  memory: Int64.t;
  memorySwap: Int64.t;
  attachStdin: bool;
  attachStdout: bool;
  attachStderr: bool;
  stdinOnce: bool;
  networkDisabled: bool;
  env: string list;
  workingDir: string;
  entryPoint: string list;
  cmd: string list;
  tty: bool;
  openStdin: bool;
  volumes: (string * Yojson.Safe.json) list;
  volumesFrom : string;
  exposedPorts: (string * string) list
}

type createContainerResponse = Docker_j.createContainerResponse = {
  id: string; 
  warnings: (string list) option
}

exception NoSuchContainer of string

exception DockerException of string

val version : unit -> string Deferred.t

val simpleHostConfig : hostConfig

val container_with_cmd : image:string -> string list -> containerConfig

val container_with_entrypoint : image:string -> string list -> containerConfig

val create_container : containerConfig -> createContainerResponse Deferred.t

val start_container : ?hostConfig:hostConfig -> string -> unit Deferred.t

val wait_for_container : string -> int Deferred.t

val delete_container : ?volumes:bool
  -> ?force:bool
  -> string 
  -> unit Deferred.t

(* For the 0.9 API, uses /attach?logs=true *)
val container_logs : ?stdout:bool 
  -> ?stderr:bool
  -> string
  -> string Deferred.t

(* TODO(arjun): This does not work. Getting HTTP 500 errors. *)
val copy_from_container : id:string
  -> path:string
  -> (string Pipe.Reader.t) Deferred.t