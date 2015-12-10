;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname finalGame) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
(require 2htdp/image)
(require 2htdp/universe)

; final project
; worldstate
; board is the image the player is trying to match
; played is the image of the board the player has constructed so far
; dragging is the maybe-image the player is click & dragging
; options is probably unnecessary, we will see
; timer is definitely not a timer
; color optional if player wants to pick his own color
; won boolean telling whether the player has won yet
(define-struct gameState [board played dragging timer won])
; image being dragged
; mouse pos
(define-struct dragState [img xPos yPos bool])

; mouse constants
(define ONCLICK "button-down")
(define ONRELEASE "button-up")
(define DRAG "drag")
(define MOVING "move")
(define ENTRY "enter")
(define EXIT "leave")

; game constants
(define BIGWIDTH 1250)
(define BIGHEIGHT 650)
(define MEDSQUARE 300)
(define SMALLSQUARE (* .25 MEDSQUARE))
(define LEFTBOUND 500)
(define RIGHTBOUND 1000)
(define TEXTSIZE 24)
(define BACKCOLOR "black")
(define MTS (overlay/align "left" "middle" 
   (beside/align "middle"
    (overlay/align "middle" "top"
     (text "match this board" TEXTSIZE BACKCOLOR)
     (rectangle LEFTBOUND BIGHEIGHT "outline" "black"))
    (overlay/align "middle" "top"
     (text "place your pieces here" TEXTSIZE BACKCOLOR)
     (rectangle LEFTBOUND BIGHEIGHT "outline" "black")))
   (empty-scene BIGWIDTH BIGHEIGHT)))

; 6 sides of the cubes
(define side1 (overlay (circle (* .5 .75 SMALLSQUARE) "solid" "white") (square SMALLSQUARE "solid" BACKCOLOR)))
(define side6 (overlay (circle (* .5 .75 SMALLSQUARE) "solid" BACKCOLOR) (square SMALLSQUARE "solid" "white")))
(define side6FRONTEND (overlay (circle (* .5 .75 SMALLSQUARE) "solid" BACKCOLOR) (square SMALLSQUARE "outline" BACKCOLOR)))
(define side3 (square SMALLSQUARE "solid" BACKCOLOR))
(define side4 (square SMALLSQUARE "solid" "white"))
(define side4FRONTEND (square SMALLSQUARE "outline" BACKCOLOR))
(define side2 (overlay (triangle/ass 90 SMALLSQUARE SMALLSQUARE  "solid" "white") (square SMALLSQUARE "solid" BACKCOLOR)))
(define side5 (overlay (triangle/ass 90 SMALLSQUARE SMALLSQUARE "solid" BACKCOLOR) (square SMALLSQUARE "solid" "white")))

;helper functions
;number and image -> column of images
(define (col n img) (cond [(= 1 n) img] [else (above img (col (- n 1) img))]))
(define (row n img) (cond [(= 1 n) img] [else (beside img (row (- n 1) img))]))
; generate board
(define (genBoard n)
  (overlay
   (cond 
     [(= n 3) (genCol 0)]
     [else
      (beside (genCol 0) (genBoard (+ n 1)))])
   (square MEDSQUARE "outline" BACKCOLOR)))
; generate a column of the board
(define (genCol n)
  (cond 
    [(= n 3) (squareHandler (+ (random 6) 1))]
    [else
     (above (squareHandler (+ (random 6) 1)) (genCol (+ n 1)))]))
; pick a random square
(define (squareHandler n)
  (cond
    [(= n 1) side1]
    [(= n 2) side2]
    [(= n 3) side3]
    [(= n 4) side4]
    [(= n 5) side5]
    [(= n 6) side6]))
; blank playing board
(define grid
  (overlay/align "middle" "middle" 
                 (col 4 (rectangle MEDSQUARE SMALLSQUARE "outline" "black"))
                 (row 4 (rectangle SMALLSQUARE MEDSQUARE "outline" "black"))))
; t-> image generates players position of play
(define (playBoard t)
  grid)
(define smallRect (rectangle SMALLSQUARE (/ (- BIGHEIGHT (* 6 SMALLSQUARE)) 7) 
                             "solid" "white"))
(define (dispOptions n)
  (above side1 smallRect side2 smallRect side3 smallRect side4FRONTEND
         smallRect side5 smallRect side6FRONTEND))
  

; render t -> image
(define (render t)
  (place-image 
   (genBoard 0) (* .5 LEFTBOUND) (* .5 BIGHEIGHT)
   (place-image 
    (playBoard t) (* .5 (+ LEFTBOUND RIGHTBOUND)) (* .5 BIGHEIGHT)
    (place-image (dispOptions 0) (* .5 (+ RIGHTBOUND BIGWIDTH)) (* .5 BIGHEIGHT)
    MTS))))

;(define (mouseh t a b c) 1)

(define (tock t) 2)

; gameRunner
(define (main t)
  (big-bang t
            [to-draw render]))
            ;[on-mouse mouseh]
            ;[on-tick tock]))