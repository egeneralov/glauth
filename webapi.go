package main

import (
	"net/http"
)

// RunAPI provides a basic REST API
func RunAPI(cfg *config) {
}

// webStaticHandler serves embedded static web files (js&css)
func webStaticHandler(w http.ResponseWriter, r *http.Request) {
}

type stringer string

func (s stringer) String() string { return string(s) }
