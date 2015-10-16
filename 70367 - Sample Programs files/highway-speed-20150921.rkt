;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname highway-speed) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A highway-speed is
; [0, 45) - too slow
; [45, 70] - legal
; (70, 100) - too fast
; [100, +infinity) - felon

; highway-speed -> String
; Informs the officer what to do with the person driving at a speed of hs
(define (doWhat hs)
  (cond
    [(and (>= hs 0) (< hs 45)) "ticket"]
    [(<= 45 hs 70) "let go"]
    [(< 70 hs 100) "ticket"]
    [(>= hs 100) "arrest"])
  )

(check-expect (doWhat 65) "let go")
(check-expect (doWhat 1000) "arrest")
(check-expect (doWhat 30) "ticket")
(check-expect (doWhat 90) "ticket")
(check-expect (doWhat 45) "let go")
(check-expect (doWhat 70) "let go")
(check-expect (doWhat 100) "arrest")
