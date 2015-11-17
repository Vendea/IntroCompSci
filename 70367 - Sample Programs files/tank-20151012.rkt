;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tank-20151012) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require racket/math)

; A tank is a (make-tank p d) where p is a posn (the position of the tank
; on the canvas) and d is a number (the direction, in radians, of the tank).
(define-struct tank [pos dir])

; The empty scence
(define WIDTH 500)
(define HEIGHT 500)
(define MTS (empty-scene WIDTH HEIGHT))

; Speed of motion
(define ROTATESPEED (/ pi 60))
(define MOVESPEED 10)

; The tank
(define TANK (overlay (beside (circle 20 "solid" "brown") (rectangle 20 10 "solid" "brown")) (rectangle 80 50 "solid" "olive")))

; tank -> scene
; Draws the tank on the screen
(define (render t)
  (place-image (rotate (radians->degrees (tank-dir t)) TANK) (posn-x (tank-pos t)) (posn-y (tank-pos t)) MTS)
  )

(check-expect (render (make-tank (make-posn 200 100) 0)) (place-image TANK 200 100 MTS))
(check-expect (render (make-tank (make-posn 300 300) (/ pi 2))) (place-image (rotate 90 TANK) 300 300 MTS))
(check-expect (render (make-tank (make-posn 150 400) pi)) (place-image (rotate 180 TANK) 150 400 MTS))

; tank key -> tank
; Updates t based on the key pressed (ke)
(define (keyh t ke)
  ...)

(check-expect (keyh (make-tank (make-posn 200 100) 0) "right") (make-tank (make-posn 200 100) (- ROTATESPEED)))
(check-expect (keyh (make-tank (make-posn 200 100) 0) "left") (make-tank (make-posn 200 100) ROTATESPEED))
(check-expect (keyh (make-tank (make-posn 200 100) 0) "up") (make-tank (make-posn 210 100) 0))
(check-expect (keyh (make-tank (make-posn 200 100) 0) "down") (make-tank (make-posn 190 100) 0))

(check-expect (keyh (make-tank (make-posn 300 300) (/ pi 2)) "right") (make-tank (make-posn ... ...) (- (/ pi 2) ROTATESPEED)))
(check-expect (keyh (make-tank (make-posn 300 300) (/ pi 2)) "left") (make-tank (make-posn ... ...) ...))
(check-expect (keyh (make-tank (make-posn 300 300) (/ pi 2)) "up") (make-tank (make-posn ... ...) ...))
(check-expect (keyh (make-tank (make-posn 300 300) (/ pi 2)) "down") (make-tank (make-posn ... ...) ...))

