;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname MovieTheater-20150911) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; The cost of just turning on the lights, renting the movie, etc.
(define FIXEDCOST 180)

; The variable cost per movie attendant
(define COSTPERPERSON 0.04)

; Price at which we have the base attendance
(define BASEPRICE 5)

; Attendance at base price
(define BASEATTENDANCE 120)

; The change in attendance for each change in price
(define ATTENDCHANGE 15)

; The change in price that gives us an attendance change
(define PRICECHANGE 0.10)

(define (profit price)
  (- (revenue price) (cost price))
  )

(define (revenue price)
  (* price (attendance price))
  )

(define (cost price)
  (+ FIXEDCOST (* COSTPERPERSON (attendance price)))
  )

(define (attendance price)
  (- BASEATTENDANCE (* (/ ATTENDCHANGE PRICECHANGE) (- price BASEPRICE)))
  )