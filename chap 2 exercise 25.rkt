;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |chap 2 exercise 25|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;exercises 23 and 24
 ;constants
(define avg-attendance 120)
(define at-cost 5)
(define people 15)
(define per-money .1)
(define slope 1.5)
 ;functions
(define (attendance ticket-price) (- avg-attendance (* (- ticket-price at-cost) (/ people per-money))))
(define (revenue ticket-price) (* ticket-price (attendance ticket-price)))
(define (cost ticket-price) (* slope (attendance ticket-price)))
(define (profit ticket-price) (- (revenue ticket-price) (cost ticket-price)))
 ;determined profits: $1=-360, $2=285, $3=630, $4=675, $5=420
 ;best price: $3.65=693.38
;alternative version
(define (other-profit price) 
  (- (* (+ 120 
           (* (/ 15 0.1) 
              (- 5.0 price))) 
        price)  
        (* 1.5 
           (+ 120 
              (* (/ 15 0.1) 
                 (- 5.0 price))))))
;exercise 26
(define PER-PERSON (/ 15 10))