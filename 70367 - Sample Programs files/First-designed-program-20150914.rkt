;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname First-designed-program) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; tempC is a number, expressing a temperature in degrees C
;; tempF is a number, expressing a temperature in degrees F

; tempF -> tempC
; f2c converts a temp in Fahrenheit (given as t) to a temp in Celcius
(define (f2c t)
  (* 5/9 (- t 32)))

(check-expect (f2c 32) 0)
(check-expect (f2c -40) -40)
(check-expect (f2c 212) 100)
(check-expect (f2c 93) 305/9)