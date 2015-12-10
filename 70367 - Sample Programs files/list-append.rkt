;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname list-append) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; (listof any) (listof any) -> (listof any)
(define (list-append l1 l2)
  (cond
    [(empty? l1) l2]
    [(empty? l2) l1]
    [else (cons (first l1) (list-append (rest l1) l2))]
    ))

(check-expect (list-append (list 4 9 6) (list 1 2 3)) (list 4 9 6 1 2 3))
(check-expect (list-append empty empty) empty)
(check-expect (list-append (list 4 9 6) empty) (list 4 9 6))
(check-expect (list-append empty (list 1 2 3)) (list 1 2 3))
