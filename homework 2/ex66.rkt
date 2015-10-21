;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex66) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; exercise 66
; Posn -> distance
; order doesn't matter because anagrams
; Dr. Hochberg would be proud of me
(define (manhattan given-posn) (+ (sqrt (sqr (posn-x given-posn))) (sqrt (sqr (posn-y given-posn)))))
(check-expect (manhattan (make-posn 0 0)) 0)
(check-expect (manhattan (make-posn 1 1)) 2)
(check-expect (manhattan (make-posn -1 5)) 6)