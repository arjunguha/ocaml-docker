(* Auto-generated from "Docker.atd" *)


type waitResponse = { statusCode: int }

type version = { version: string; gitCommit: int; goVersion: string }

type hostConfig = { binds: string list }

type createContainerResponse = { id: string; warnings: (string list) option }

type containerConfig = {
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
  volumes: (string * string) list;
  exposedPorts: (string * string) list
}
