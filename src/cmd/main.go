package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	tmpl := `
	<html>
		<head><title>Hello</title></head>
		<body>
			<h1>Hello, World!</h1>
		</body>
	</html>
	`

	w.Header().Set("Content-Type", "text/html")
	fmt.Fprint(w, tmpl)
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Starting server on :8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		fmt.Println("Error starting server:", err)
	}
}
