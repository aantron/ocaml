(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*                 Jeremie Dimino, Jane Street Europe                  *)
(*                                                                     *)
(*  Copyright 2015 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

external ( + ) : (int64 [@unboxed]) -> (int64 [@unboxed]) -> (int64 [@unboxed])
  = "" "noalloc" "test_int64_add"
external ( - ) : (int64 [@unboxed]) -> (int64 [@unboxed]) -> (int64 [@unboxed])
  = "" "noalloc" "test_int64_sub"
external ( * ) : (int64 [@unboxed]) -> (int64 [@unboxed]) -> (int64 [@unboxed])
  = "" "noalloc" "test_int64_mul"

external ignore_int64 : (int64 [@unboxed]) -> unit = "" "noalloc" "test_ignore_int64"

let f () =
  let r = ref 1L in
  for i = 0 to 100000 do
    let n = !r + !r in
    r := n * n
  done;
  ignore_int64 !r

let () =
  let a0 = Gc.allocated_bytes () in
  let a1 = Gc.allocated_bytes () in
  let _x = f () in
  let a2 = Gc.allocated_bytes () in
  let alloc = (a2 -. 2. *. a1 +. a0) in
  assert(alloc = 0.)