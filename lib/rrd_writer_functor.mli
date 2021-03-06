(*
 * Copyright (C) Citrix Systems Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation; version 2.1 only. with the special
 * exception on linking described in file LICENSE.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *)

module type TRANSPORT = sig
  type id_t

  type info_t

  type state_t

  val init: id_t -> info_t * state_t

  val cleanup: id_t -> info_t -> state_t -> unit

  val get_allocator: state_t -> (int -> Cstruct.t)
end

type writer = {
  write_payload: Rrd_protocol.payload -> unit;
  cleanup: unit -> unit;
}

module Make (T: TRANSPORT) : sig
  val create: T.id_t -> Rrd_protocol.protocol -> T.info_t * writer
end
