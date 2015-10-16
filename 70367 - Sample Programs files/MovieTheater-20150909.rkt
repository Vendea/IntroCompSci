;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname MovieTheater-20150909) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define (profit price)
  (- (revenue price) (cost price))
  )

(define (revenue price)
  (* price (attendance price))
  )

(define (cost price)
  (+ 100 (* 0.08 (attendance price)))
  )

(define (attendance price)
  (- 120 (* (/ 15 0.10) (- price 5)))
  )