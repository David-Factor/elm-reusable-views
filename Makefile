.PHONY: start
start:
	elm-live src/Main.elm --open --hot -- --output=built/elm.js
