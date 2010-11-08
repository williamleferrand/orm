open Printf 

type t = Object of string * int64 with orm

let db_file = "bug1.db" 

let _ = 
  printf "@@@ Curious bug1\n"; 
  
  let db = t_init db_file in 
(*
  let a = Object ("test", 0L) in 

  t_save ~db a 
*)

()
