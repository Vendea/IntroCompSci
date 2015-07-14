;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |final project start|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)
(require 2htdp/universe)
(define side1 (overlay (circle 15 "solid" "white") (square 50 "solid" "black")))
(define side6 (overlay (circle 15 "solid" "black") (square 50 "solid" "white")))
(define side2 (overlay (triangle/ass 90 50 50 "solid" "white") (square 50 "solid" "black")))
(define side5 (overlay (triangle/ass 90 50 50 "solid" "black") (square 50 "solid" "white")))
(define side3 (square 50 "solid" "black"))
(define side4 (square 50 "solid" "white"))

