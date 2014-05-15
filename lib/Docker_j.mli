(* Auto-generated from "Docker.atd" *)


type waitResponse = Docker_t.waitResponse = { statusCode: int }

type version = Docker_t.version = {
  version: string;
  gitCommit: int;
  goVersion: string
}

type dyn = Yojson.Safe.json

type hostConfig = Docker_t.hostConfig = {
  binds: string list;
  containerIDFile: string;
  lxcConf: string list;
  privileged: bool;
  publishAllPorts: bool;
  portBindings: (string * string) list;
  links: dyn
}

type createContainerResponse = Docker_t.createContainerResponse = {
  id: string;
  warnings: (string list) option
}

type copyRequest = Docker_t.copyRequest = {
  resource: string;
  hostPath: string
}

type containerConfig = Docker_t.containerConfig = {
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
  volumes: (string * dyn) list;
  volumesFrom: string;
  exposedPorts: (string * string) list
}

val write_waitResponse :
  Bi_outbuf.t -> waitResponse -> unit
  (** Output a JSON value of type {!waitResponse}. *)

val string_of_waitResponse :
  ?len:int -> waitResponse -> string
  (** Serialize a value of type {!waitResponse}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_waitResponse :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> waitResponse
  (** Input JSON data of type {!waitResponse}. *)

val waitResponse_of_string :
  string -> waitResponse
  (** Deserialize JSON data of type {!waitResponse}. *)

val write_version :
  Bi_outbuf.t -> version -> unit
  (** Output a JSON value of type {!version}. *)

val string_of_version :
  ?len:int -> version -> string
  (** Serialize a value of type {!version}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_version :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> version
  (** Input JSON data of type {!version}. *)

val version_of_string :
  string -> version
  (** Deserialize JSON data of type {!version}. *)

val write_dyn :
  Bi_outbuf.t -> dyn -> unit
  (** Output a JSON value of type {!dyn}. *)

val string_of_dyn :
  ?len:int -> dyn -> string
  (** Serialize a value of type {!dyn}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_dyn :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> dyn
  (** Input JSON data of type {!dyn}. *)

val dyn_of_string :
  string -> dyn
  (** Deserialize JSON data of type {!dyn}. *)

val write_hostConfig :
  Bi_outbuf.t -> hostConfig -> unit
  (** Output a JSON value of type {!hostConfig}. *)

val string_of_hostConfig :
  ?len:int -> hostConfig -> string
  (** Serialize a value of type {!hostConfig}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_hostConfig :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> hostConfig
  (** Input JSON data of type {!hostConfig}. *)

val hostConfig_of_string :
  string -> hostConfig
  (** Deserialize JSON data of type {!hostConfig}. *)

val write_createContainerResponse :
  Bi_outbuf.t -> createContainerResponse -> unit
  (** Output a JSON value of type {!createContainerResponse}. *)

val string_of_createContainerResponse :
  ?len:int -> createContainerResponse -> string
  (** Serialize a value of type {!createContainerResponse}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_createContainerResponse :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> createContainerResponse
  (** Input JSON data of type {!createContainerResponse}. *)

val createContainerResponse_of_string :
  string -> createContainerResponse
  (** Deserialize JSON data of type {!createContainerResponse}. *)

val write_copyRequest :
  Bi_outbuf.t -> copyRequest -> unit
  (** Output a JSON value of type {!copyRequest}. *)

val string_of_copyRequest :
  ?len:int -> copyRequest -> string
  (** Serialize a value of type {!copyRequest}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_copyRequest :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> copyRequest
  (** Input JSON data of type {!copyRequest}. *)

val copyRequest_of_string :
  string -> copyRequest
  (** Deserialize JSON data of type {!copyRequest}. *)

val write_containerConfig :
  Bi_outbuf.t -> containerConfig -> unit
  (** Output a JSON value of type {!containerConfig}. *)

val string_of_containerConfig :
  ?len:int -> containerConfig -> string
  (** Serialize a value of type {!containerConfig}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_containerConfig :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> containerConfig
  (** Input JSON data of type {!containerConfig}. *)

val containerConfig_of_string :
  string -> containerConfig
  (** Deserialize JSON data of type {!containerConfig}. *)

