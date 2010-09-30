open Printf

type simple = 
    {
      mutable text : string ;
    } with orm 


let db_file = "test.db" 

let _ =
  printf "@@@ Testing fts3\n"; 

  let db = simple_init db_file in 

  let v1 = { text = "ceci est un premier texte" } in 

  let results = simple_search ~db "text" Sys.argv.(1) in 
  
  

  simple_save ~db v1  ; 

  List.iter (fun s -> printf " Result --> %s\n" s.text) results 
