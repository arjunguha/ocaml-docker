open Core.Std
open Async.Std
open Docker_t

exception NoSuchContainer of string

exception DockerException of string

val version : unit -> string Deferred.t

val container_with_cmd : image:string -> string list -> containerConfig

val container_with_entrypoint : image:string -> string list -> containerConfig

val create_container : containerConfig -> createContainerResponse Deferred.t

val start_container : ?hostConfig:hostConfig -> string -> unit Deferred.t

val wait_for_container : string -> int Deferred.t

(* For the 1.10 API, uses /attach?logs=true *)
val container_logs : ?stdout:bool 
  -> ?stderr:bool
  -> string
  -> string Deferred.t