open Core.Std
open Async.Std
open Docker_t

let version () : unit Deferred.t =
  Docker.version ()
  >>= fun ver ->
  printf "%s\n%!" ver;
  shutdown 0;
  never ()

let logs (id : string) : unit Deferred.t =
  Docker.container_logs ~stdout:true id
  >>= fun log ->
  printf "%s\n%!" log;
  shutdown 0;
  never ()

let rm (id : string) : unit Deferred.t =
  Docker.delete_container ~volumes:true id
  >>= fun () ->
  shutdown 0;
  never ()

let cp ~(id : string) ~(src : string) ~(dst : string) : unit Deferred.t =
  Docker.copy_from_container id src
  >>= fun r ->
  Writer.with_file dst (fun w ->
    Pipe.transfer_id r (Writer.pipe w))
  >>= fun () ->
  shutdown 0;
  never ()

let _ = match Array.to_list Sys.argv with
  | [ _; "version" ] -> version ()
  | [ _; "logs"; id ] -> logs id
  | [ _; "rm"; id ] -> rm id
  | [ _; "cp"; id; src; dst] -> cp ~id ~src ~dst
  | _ -> begin
      printf "Invalid arguments, read the source code.\n%!"; 
      shutdown 1; 
      return ()
    end

let _ = Scheduler.go ()