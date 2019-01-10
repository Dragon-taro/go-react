package main

import (
	"html/template"
	"net/http"

	"github.com/gorilla/mux"
)

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		tmpl := template.Must(template.New("index").ParseFiles("templates/index.html"))
		err := tmpl.Execute(w, nil)
		if err != nil {
			panic(err)
		}
	}).Methods("GET")

	http.Handle("/", r)
	http.Handle("/static/", http.StripPrefix("/static/", http.FileServer(http.Dir("./frontend/static/"))))
	http.ListenAndServe(":8000", nil)
}
