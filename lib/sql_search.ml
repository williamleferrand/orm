(*
 * Copyright (c) 2009 Anil Madhavapeddy <anil@recoil.org>
 * Copyright (c) 2009 Thomas Gazagnaire <thomas@gazagnaire.com>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

open Printf
open Sqlite3
open Sql_backend

module T = Type
module V = Value

exception Sql_process_error of T.t * Data.t * string

let process_error v d s =
  Printf.printf "ERROR(%s): %s - %s\n%!" s (T.to_string v) (string_of_data d);
  raise (Sql_process_error (v, d, s))

let exec_sql ~env ~db = exec_sql ~db ~env ~tag:"search"

let process ~env ~db name field query fn = 
  let sql = sprintf "SELECT docid, * FROM %s_fts WHERE %s MATCH '%s';" name field query in
  exec_sql ~env ~db sql [] (fun stmt -> step_map db stmt fn) 

let search_values ~env ~db ?id field query t =
  let value_of_row name s row =
    let id = match row.(0) with Data.INT i -> i | _ -> failwith "TODO:4; have you removed the docid somewhere?" in
    id
      
(*
    match Sql_get.get_values ~env ~db ~id:id t with 
	v::_ -> v 
      | _ -> failwith (Printf.sprintf "database is desynchronized (%Ld)" id) in
*) in    
 
  let value_of_stmt name s stmt =
    value_of_row name s (row_data stmt) in
  
  
  match t with
    | T.Rec (n, s) | T.Ext (n, s) ->
      let res = process ~env ~db n field query (value_of_stmt n s) in
      res
    | _ -> failwith "TODO"  
      
