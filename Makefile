jar:
	clojure -Spom
	clojure -Sdeps '{:deps {seancorfield/depstar {:mvn/version "1.0.94"}}}' \
		-m hf.depstar.jar target/dummy.jar -v
