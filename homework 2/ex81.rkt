;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex81) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; exercise 81
; time -> seconds
; first define the time struct
(define-struct time [hours minutes seconds])
(define (time-to-seconds t) (+ (* (time-hours t) 3600) (* (time-minutes t) 60) (time-seconds t)))
(check-expect (time-to-seconds (make-time 1 1 1)) 3661)
(check-expect (time-to-seconds (make-time 1 20 40)) 4840)45002
(check-expect (time-to-seconds (make-time 12 30 2)) 45002)