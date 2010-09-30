open Printf

(************************************************************)
(* A simple type for some little tests                      *)
(************************************************************)

type simple = 
    {
      mutable text : string ;
      counter : int ;
    } with orm 


let db_file = "test.db" 

(************************************************************)
(* Random dataset for bencharks                             *)
(************************************************************)

let random_char () = 
  char_of_int (97 + Random.int 25)

let random_word () = 
  let s = String.create 8 in 
  for i = 0 to 7 do 
    s.[i] <- random_char () 
  done ; s 
  
let rec random_text acc = 
  function 
    | 0 -> acc 
    | n -> random_text (acc ^ " " ^ random_word ()) (n-1)
  
  
let rec populate db =
  function 
    | 0 -> () 
    | n -> 
      let rtxt = random_text "" 100 in 
      let v = { text = rtxt; counter = 0 } in 
      simple_save ~db v ;
      populate db (n-1)
	   
  

(**********************)
(* Here we go         *)
(**********************)  
  
let _ =
  printf "@@@ Testing fts3 support\n"; 

  let db = simple_init db_file in 

  populate db (int_of_string Sys.argv.(1)) ; 

  let st = Unix.gettimeofday () in 
  let results = simple_search ~db "text" Sys.argv.(2) in 
  let et = Unix.gettimeofday () in 
  
  List.iter (fun s -> printf " Result --> %s\n" s.text) results ; 
  printf "Et tout ça en %f secondes!\n" (et -. st)
