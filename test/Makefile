all: search.ml
	ocamlfind ocamlc -syntax camlp4o -package orm.syntax -linkpkg -o test $^

clean: 
	rm -rf *.cm*
	rm -rf test
	rm -rf *~