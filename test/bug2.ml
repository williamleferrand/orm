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
  | n -> genl (Random.int 1500 :: acc) (n-1) 


let _ = 
  printf "@@@ Curious bug2\n"; 
  
  let db = t_init db_file in 
  let t1 = Unix.times () in 
  for i = 0 to 3000 do 
    printf "Step %d\n" i ; flush stdout ; 
    let v = {
      publication_authors_fpggist = genl [] 10 ;
    } in
    t_save ~db v true
  done ; 
  let t2 = Unix.times () in 
  printf "Duration: %f\n" (t2.Unix.tms_utime +. t2.Unix.tms_stime -. t1.Unix.tms_utime -. t1.Unix.tms_stime)


(* 232. 14 *)
