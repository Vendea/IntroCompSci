;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |141|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; exercise 141
; list -> boolean
(define (all-true li)
  (cond
    [(empty? li) #true]
    [(not (first li)) #false]
    [else (all-true (rest li))]))

(check-expect (all-true (list #true #true #true #true)) #true)
(check-expect (all-true (list #false #true #false #false)) #false)

;list -> boolean
(define (one-true li)
  (cond 
    [(empty? li) #false]
    [(first li) #true]
    [else (one-true (rest li))]))

(check-expect (one-true (list #true #true #false #false #false)) #true)
(check-expect (one-true (cons #false (cons #true '()))) #true)

