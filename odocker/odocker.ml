open Core.Std
open Async.Std
open Docker_t

let main () = 
  let _ =
    printf "Pinging docker\n%!";
    Docker.version () 
    >>= fun str -> 
    printf "Ping OK %s\n%!" str;
    let cfg = Docker.container_with_cmd "ubuntu" ["/bin/cat"; "/proc/cpuinfo"] in
    Docker.create_container cfg
    >>= fun resp ->
    printf "Image created %s\n" resp.id;
    Docker.start_container resp.id
    >>= fun () ->
    printf "Container started.\n";
    Docker.wait_for_container resp.id
    >>= fun code ->
    printf "Container exited with code %d\n" code;
    Docker.container_logs ~stdout:true resp.id
    >>= fun log ->
    printf "%s\n%!" log;
    return () in
  ()

let _ = printf "Hello\n%!"
let _ = main ()
let _ = Scheduler.go ()