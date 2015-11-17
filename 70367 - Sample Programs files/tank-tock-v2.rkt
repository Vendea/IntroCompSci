;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tank-tock-v2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require racket/math)

; A rotate is one of "cw", "ccw", or "none" (interp. tank is rotating clockwise, counter-clockwise, or not any).

; A move is one of "forward", "backward", or "none" (interp. is the tank is moving forward, backward, or not at all)

; A tank is a (make-tank p d r m) where p is a posn (the position of the tank
; on the canvas) d is a number (the direction, in radians, of the tank),
; r is a rotate, and m is a move.
(define-struct tank [pos dir rot mov])

; The empty scence
(define WIDTH 500)
(define HEIGHT 500)
(define MTS (empty-scene WIDTH HEIGHT))

; Speeds of motion
(define ROTATESPEED (/ pi 60))
(define MOVESPEED 10)

; The tank picture
(define TANK (overlay (beside (circle 20 "solid" "brown") (rectangle 20 10 "solid" "brown")) (rectangle 80 50 "solid" "olive")))

; tank -> scene
; Draws the tank on the screen
(define (render t)
  (place-image (rotate (radians->degrees (tank-dir t)) TANK) (posn-x (tank-pos t)) (posn-y (tank-pos t)) MTS)
  )
(check-expect (render (make-tank (make-posn 200 100) 0 "ccw" "none")) (place-image TANK 200 100 MTS))
(check-expect (render (make-tank (make-posn 300 300) (/ pi 2) "cw" "forward")) (place-image (rotate 90 TANK) 300 300 MTS))
(check-expect (render (make-tank (make-posn 150 400) pi "none" "none")) (place-image (rotate 180 TANK) 150 400 MTS))

; tank key -> tank
; Changes the tank state when a key is pressed
(define (keyh t ke)
  (cond
    [(key=? ke "left") (make-tank (tank-pos t) (tank-dir t) "ccw" (tank-mov t))]
    [(key=? ke "right") (make-tank (tank-pos t) (tank-dir t) "cw" (tank-mov t))]
    [(key=? ke "up") (make-tank (tank-pos t) (tank-dir t) (tank-rot t) "forward")]
    [(key=? ke "down") (make-tank (tank-pos t) (tank-dir t) (tank-rot t) "backward")]
    [else t]
    ))
(check-expect (keyh (make-tank (make-posn 200 100) 0 "none" "none") "left")
              (make-tank (make-posn 200 100) 0 "ccw" "none"))
(check-expect (keyh (make-tank (make-posn 200 100) 0 "none" "none") "right")
              (make-tank (make-posn 200 100) 0 "cw" "none"))
(check-expect (keyh (make-tank (make-posn 200 100) 0 "none" "none") "up")
              (make-tank (make-posn 200 100) 0 "none" "forward"))
(check-expect (keyh (make-tank (make-posn 200 100) 0 "none" "none") "down")
              (make-tank (make-posn 200 100) 0 "none" "backward"))
(check-expect (keyh (make-tank (make-posn 200 100) 0 "none" "none") "g")
              (make-tank (make-posn 200 100) 0 "none" "none"))

; tank key -> tank
; Changes the tank state when a key is released
(define (keyr t ke)
  (cond
    [(key=? ke "left") (make-tank (tank-pos t) (tank-dir t) "none" (tank-mov t))]
    [(key=? ke "right") (make-tank (tank-pos t) (tank-dir t) "none" (tank-mov t))]
    [(key=? ke "up") (make-tank (tank-pos t) (tank-dir t) (tank-rot t) "none")]
    [(key=? ke "down") (make-tank (tank-pos t) (tank-dir t) (tank-rot t) "none")]
    [else t]
    ))
(check-expect (keyr (make-tank (make-posn 200 100) 0 "ccw" "none") "left")
              (make-tank (make-posn 200 100) 0 "none" "none"))
(check-expect (keyr (make-tank (make-posn 200 100) 0 "cw" "none") "right")
              (make-tank (make-posn 200 100) 0 "none" "none"))
(check-expect (keyr (make-tank (make-posn 200 100) 0 "ccw" "forward") "up")
              (make-tank (make-posn 200 100) 0 "ccw" "none"))
(check-expect (keyr (make-tank (make-posn 200 100) 0 "none" "backward") "down")
              (make-tank (make-posn 200 100) 0 "none" "none"))
(check-expect (keyr (make-tank (make-posn 200 100) 0 "ccw" "forward") "g")
              (make-tank (make-posn 200 100) 0 "ccw" "forward"))

; tank -> tank
; Updates the tank depending on the state it is in (rotating or moving, or both)
(define (tock t)
  (make-tank
   (cond
     [(string=? (tank-mov t) "forward") (make-posn (+ (posn-x (tank-pos t)) (* MOVESPEED (cos (tank-dir t))))
                                                   (- (posn-y (tank-pos t)) (* MOVESPEED (sin (tank-dir t)))))]
     [(string=? (tank-mov t) "backward") (make-posn (- (posn-x (tank-pos t)) (* MOVESPEED (cos (tank-dir t))))
                                                    (+ (posn-y (tank-pos t)) (* MOVESPEED (sin (tank-dir t)))))]
     [else (tank-pos t)])
   (cond
     [(string=? (tank-rot t) "ccw") (+ (tank-dir t) ROTATESPEED)]
     [(string=? (tank-rot t) "cw") (- (tank-dir t) ROTATESPEED)]
     [else (tank-dir t)])
   (tank-rot t) (tank-mov t))
  )

(check-within (tock (make-tank (make-posn 200 100) 0 "cw" "none"))
              (make-tank (make-posn 200 100) (- ROTATESPEED) "cw" "none") 0.00001)
(check-within (tock (make-tank (make-posn 200 100) 0 "ccw" "none"))
              (make-tank (make-posn 200 100) ROTATESPEED "ccw" "none") 0.00001)
(check-within (tock (make-tank (make-posn 200 100) 0 "none" "forward"))
              (make-tank (make-posn 210 100) 0 "none" "forward") 0.00001)
(check-within (tock (make-tank (make-posn 200 100) 0 "none" "backward"))
              (make-tank (make-posn 190 100) 0 "none" "backward") 0.00001)
(check-within (tock (make-tank (make-posn 200 100) 0 "ccw" "backward"))
                    (make-tank (make-posn 190 100) ROTATESPEED "ccw" "backward") 0.00001)

(check-within (tock (make-tank (make-posn 300 300) (/ pi 2) "cw" "none"))
              (make-tank (make-posn 300 300) (- (/ pi 2) ROTATESPEED) "cw" "none") 0.00001)
(check-within (tock (make-tank (make-posn 300 300) (/ pi 2) "ccw" "none"))
              (make-tank (make-posn 300 300) (+ (/ pi 2) ROTATESPEED) "ccw" "none") 0.00001)
(check-within (tock (make-tank (make-posn 300 300) (/ pi 2) "none" "forward"))
              (make-tank (make-posn 300 290) (/ pi 2) "none" "forward") 0.00001)
(check-within (tock (make-tank (make-posn 300 300) (/ pi 2) "none" "backward"))
              (make-tank (make-posn 300 310) (/ pi 2) "none" "backward") 0.00001)
(check-within (tock (make-tank (make-posn 300 300) (/ pi 2) "cw" "forward"))
                    (make-tank (make-posn 300 290) (- (/ pi 2) ROTATESPEED) "cw" "forward") 0.00001)

(check-within (tock (make-tank (make-posn 300 300) (/ pi 6) "cw" "none"))
              (make-tank (make-posn 300 300) (- (/ pi 6) ROTATESPEED) "cw" "none") 0.00001)
(check-within (tock (make-tank (make-posn 300 300) (/ pi 6) "ccw" "none"))
              (make-tank (make-posn 300 300) (+ (/ pi 6) ROTATESPEED) "ccw" "none") 0.00001)
(check-within (tock (make-tank (make-posn 300 300) (/ pi 6) "none" "forward"))
              (make-tank (make-posn (+ 300 (* 10 (cos (/ pi 6))))
                                    (- 300 (* 10 (sin (/ pi 6)))))
                         (/ pi 6) "none" "forward") 0.00001)
(check-within (tock (make-tank (make-posn 300 300) (/ pi 6) "none" "backward"))
              (make-tank (make-posn (- 300 (* 10 (cos (/ pi 6))))
                                    (+ 300 (* 10 (sin (/ pi 6)))))
                         (/ pi 6) "none" "backward") 0.00001)
(check-within (tock (make-tank (make-posn 300 300) (/ pi 6) "cw" "backward"))
              (make-tank (make-posn (- 300 (* 10 (cos (/ pi 6))))
                                    (+ 300 (* 10 (sin (/ pi 6)))))
                         (- (/ pi 6) ROTATESPEED) "cw" "backward") 0.00001)

; tank -> tank
(define (main t)
  (big-bang t
            [on-key keyh]
            [on-release keyr]
            [to-draw render]
            [on-tick tock]))