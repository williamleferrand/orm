all: search.ml
	ocamlfind ocamlc -syntax camlp4o -package orm.syntax -linkpkg -o test $^

inter:
	camlp4orf -I /opt/godi/lib/ocaml/std-lib -I /opt/godi/lib/ocaml/pkg-lib/num -I /opt/godi/lib/ocaml/site-lib/sqlite3 -I /opt/godi/lib/ocaml/site-lib/dyntype -I /opt/godi/lib/ocaml/site-lib/dyntype -I /opt/godi/lib/ocaml/std-lib -I /opt/godi/lib/ocaml/site-lib/orm -I /opt/godi/lib/ocaml/std-lib/camlp4 -I /opt/godi/lib/ocaml/pkg-lib/type-conv -I /opt/godi/lib/ocaml/site-lib/dyntype -I /opt/godi/lib/ocaml/site-lib/orm nums.cma sqlite3.cma type.cmo value.cmo unix.cma orm.cma -parser o -parser op -printer p pa_type_conv.cmo pa_dyntype.cma pa_orm.cma search.ml > out 

clean: 
	rm -rf *.cm*
	rm -rf test
	rm -rf *~