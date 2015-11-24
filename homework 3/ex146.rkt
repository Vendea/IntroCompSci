;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex146) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; list of numbers -> boolean
(define (sorted>? li)
  (cond
    [(empty? (rest li)) #true]
    [(not (> (first li) (first (rest li)))) #false]
    [else (sorted>? (rest li))]))

(check-expect (sorted>? (list 5 4 3 2 1 0)) #true)
(check-expect (sorted>? (list 0 1 2 3 4 5)) #false)