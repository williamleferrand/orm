(*
 * Bug2 (huge join in sql_update)
 *)

open Printf 

let db_file = "bug2.db" 

type t = 
    {
      mutable publication_authors_fpggist : int list ;
    } with orm


let rec genl acc = function 
  | 0 -> acc
  | n -> genl (n::acc) (n-1) 

let _ = 
  printf "@@@ Curious bug2\n"; 
  
  let db = t_init db_file in 
  for i = 0 to 300 do 
    printf "Step %d\n" i ; flush stdout ; 
    let v = {
      publication_authors_fpggist = [ i ] ;
    } in
    t_save ~db v false 
  done 
