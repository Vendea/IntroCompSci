;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Chapter 3|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
;teachpacks
(require 2htdp/image)
(require 2htdp/universe)

;exercise 36

;use strings to return a character from a given string
;String --> character
;returns first character given a nonempty string
;given: "alpha" expect: "a"
;given: "bravo" expect: "b"
;given: "charlie" expect: "c"
;(define (string-first str) "a")
;(define (string-first str)
;  (...str...))
(define (string-first str)
  (substring str 0 1))

;exercise 40

;strings represent strings
;String --> String
;removes the last character from a given string
;given: alpha, expect: alph
;given: bravo, expect: brav
;given: charlie, expect: charli
;(define (string-remove-last str) "st")
;(define (string-remove-last str)
;  (...substring...string-length))
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))
