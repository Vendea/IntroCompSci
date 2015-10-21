;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex73) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; exercise 73
; Posn -> Posn
(define (posn-up-x p n) (make-posn n (posn-y p)))
(check-expect (posn-up-x (make-posn 6 4) 2) (make-posn 2 4))
(check-expect (posn-up-x (make-posn 6 4) 7) (make-posn 7 4))