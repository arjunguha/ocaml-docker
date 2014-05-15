ocaml-docker
============

An OCaml interface to the Docker API, tested on Docker that comes with
Ubuntu 14.04.

To build this library, you'll need to manually install these versions of 
conduit and cohttp:

- https://github.com/arjunguha/ocaml-conduit
- https://github.com/arjunguha/ocaml-cohttp

I've extended these libraries to support Unix domain sockets. Once they make it to
OPAM, this step won't be needed.
