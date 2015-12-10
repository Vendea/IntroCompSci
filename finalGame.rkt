;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname finalGame) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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
; boolean true if dragging actively happening
; false if mouse goes outside window or releases
(define-struct dragState [img x y bool])

; mouse constants
(define ONCLICK "button-down")
(define ONRELEASE "button-up")
(define DRAG "drag")
(define MOVING "move")
(define ENTRY "enter")
(define EXIT "leave")

; game constants
(define WIN (text "YOU WIN!!" 70 "orange"))
(define BIGWIDTH 1250)
(define BIGHEIGHT 650)
(define MEDSQUARE 300)
(define SMALLSQUARE (* .25 MEDSQUARE))
(define LEFTBOUND 500)
(define RIGHTBOUND 1000)
(define TEXTSIZE 24)
(define BACKCOLOR "black")

(define newGame (overlay (text "New Game" TEXTSIZE BACKCOLOR) (rectangle 150 25 "outline" BACKCOLOR)))
(define MTB (square MEDSQUARE "outline" BACKCOLOR))
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
(define side5FRONTEND (overlay (triangle/ass 90 SMALLSQUARE SMALLSQUARE "solid" BACKCOLOR) (square SMALLSQUARE "outline" BACKCOLOR)))

; number and image -> column of images
(define (col n img) (cond [(= 1 n) img] [else (above img (col (- n 1) img))]))
(define (row n img) (cond [(= 1 n) img] [else (beside img (row (- n 1) img))]))
; create blank playing board
(define grid (overlay/align "middle" "middle" 
                 (col 4 (rectangle MEDSQUARE SMALLSQUARE "outline" "black"))
                 (row 4 (rectangle SMALLSQUARE MEDSQUARE "outline" "black"))))

; pick a random square
(define (squareHandler n)
  (cond
    [(= n 0) side1]
    [(= n 1) side2]
    [(= n 2) side3]
    [(= n 3) side4]
    [(= n 4) side5]
    [(= n 5) side6]))
; generate board
(define offS (* .125 MEDSQUARE))
(define (genBoard i j)
   (cond 
     [(= i 3)
      (cond
        [(= j 3) (place-image
                  (squareHandler (random 6))
                  (+ (* i SMALLSQUARE) offS)
                  (+ (* j SMALLSQUARE) offS) MTB)]
        [else (place-image
               (squareHandler (random 6))
               (+ (* i SMALLSQUARE) offS)
               (+ (* j SMALLSQUARE) offS)
               (genBoard 0 (+ j 1)))])]
     [else (place-image
               (squareHandler (random 6))
               (+ (* i SMALLSQUARE) offS)
               (+ (* j SMALLSQUARE) offS)
               (genBoard (+ i 1) j))]))

; show the pieces available to choose from
(define offY (/ (- BIGHEIGHT (* 6 SMALLSQUARE)) 7))
(define smallRect (rectangle SMALLSQUARE offY "solid" "white"))
(define (dispOptions n)
  (above side1 smallRect side2 smallRect side3 smallRect side4FRONTEND
         smallRect side5FRONTEND smallRect side6FRONTEND))

; check to see if gameState is a win for player
(define (checkWin t)
  (image=? (gameState-board t) (gameState-played t)))

; find things at mouse pos
(define offX (* (- BIGWIDTH RIGHTBOUND SMALLSQUARE) .5))
(define (getImg x y)
  (cond
    [(and (> y offY) (< y (+ offY SMALLSQUARE))) side1]
    [(and (> y (+ (* 2 offY) SMALLSQUARE)) (< y (* 2 (+ offY SMALLSQUARE)))) side2]
    [(and (> y (+ (* 3 offY) (* 2 SMALLSQUARE))) (< y (* 3 (+ offY SMALLSQUARE)))) side3]
    [(and (> y (+ (* 4 offY) (* 3 SMALLSQUARE))) (< y (* 4 (+ offY SMALLSQUARE)))) side4FRONTEND]
    [(and (> y (+ (* 5 offY) (* 4 SMALLSQUARE))) (< y (* 5 (+ offY SMALLSQUARE)))) side5FRONTEND]
    [(and (> y (+ (* 6 offY) (* 5 SMALLSQUARE))) (< y (* 6 (+ offY SMALLSQUARE)))) side6FRONTEND]
    [else empty-image]))

; find tile at mouse click set for dragging
(define (handleClick t x y)
  (cond
    [(and (> x (+ offX RIGHTBOUND)) (< x (- BIGWIDTH offX)))
     (make-gameState (gameState-board t)
                     (gameState-played t)
                     (make-dragState (getImg x y) x y #true)
                     (gameState-timer t)
                     #false)]
    [else t]))

;get centers (to place tiles) on top of the grid
(define offW (* .5 (- LEFTBOUND (* 4 SMALLSQUARE))))
(define offH (* .5 (- BIGHEIGHT (* 4 SMALLSQUARE))))
(define (dropImg img onImg x y)
  (cond
    [(< x (+ LEFTBOUND offW SMALLSQUARE))
     (cond
       [(< y (+ offH SMALLSQUARE))
        (place-image img (* .5 SMALLSQUARE) (* .5 SMALLSQUARE) onImg)]
       [(< y (+ offH (* 2 SMALLSQUARE)))
        (place-image img (* .5 SMALLSQUARE) (* 1.5 SMALLSQUARE) onImg)]
       [(< y (+ offH (* 3 SMALLSQUARE)))
        (place-image img (* .5 SMALLSQUARE) (* 2.5 SMALLSQUARE) onImg)]
       [(< y (+ offH (* 4 SMALLSQUARE)))
        (place-image img (* .5 SMALLSQUARE) (* 3.5 SMALLSQUARE) onImg)])]
    [(< x (+ LEFTBOUND offW (* 2 SMALLSQUARE)))
     (cond
       [(< y (+ offH SMALLSQUARE))
        (place-image img (* 1.5 SMALLSQUARE) (* .5 SMALLSQUARE) onImg)]
       [(< y (+ offH (* 2 SMALLSQUARE)))
        (place-image img (* 1.5 SMALLSQUARE) (* 1.5 SMALLSQUARE) onImg)]
       [(< y (+ offH (* 3 SMALLSQUARE)))
        (place-image img (* 1.5 SMALLSQUARE) (* 2.5 SMALLSQUARE) onImg)]
       [(< y (+ offH (* 4 SMALLSQUARE)))
        (place-image img (* 1.5 SMALLSQUARE) (* 3.5 SMALLSQUARE) onImg)])]
    [(< x (+ LEFTBOUND offW (* 3 SMALLSQUARE)))
     (cond
       [(< y (+ offH SMALLSQUARE))
        (place-image img (* 2.5 SMALLSQUARE) (* .5 SMALLSQUARE) onImg)]
       [(< y (+ offH (* 2 SMALLSQUARE)))
        (place-image img (* 2.5 SMALLSQUARE) (* 1.5 SMALLSQUARE) onImg)]
       [(< y (+ offH (* 3 SMALLSQUARE)))
        (place-image img (* 2.5 SMALLSQUARE) (* 2.5 SMALLSQUARE) onImg)]
       [(< y (+ offH (* 4 SMALLSQUARE)))
        (place-image img (* 2.5 SMALLSQUARE) (* 3.5 SMALLSQUARE) onImg)])]
    [(< x (+ LEFTBOUND offW (* 4 SMALLSQUARE)))
     (cond
       [(< y (+ offH SMALLSQUARE))
        (place-image img (* 3.5 SMALLSQUARE) (* .5 SMALLSQUARE) onImg)]
       [(< y (+ offH (* 2 SMALLSQUARE)))
        (place-image img (* 3.5 SMALLSQUARE) (* 1.5 SMALLSQUARE) onImg)]
       [(< y (+ offH (* 3 SMALLSQUARE)))
        (place-image img (* 3.5 SMALLSQUARE) (* 2.5 SMALLSQUARE) onImg)]
       [(< y (+ offH (* 4 SMALLSQUARE)))
        (place-image img (* 3.5 SMALLSQUARE) (* 3.5 SMALLSQUARE) onImg)])]))

;find place to release the dragged image
(define (handleReleaseOfDrag t x y)
  (cond
    [(and (and (> x (+ LEFTBOUND offW)) (< x (- RIGHTBOUND offW)))
          (and (> y offH) (< y (- BIGHEIGHT offH))))
     (make-gameState
      (gameState-board t)
      (dropImg (cond
                 [(image=? (dragState-img (gameState-dragging t))
                           side6FRONTEND) side6]
                 [(image=? (dragState-img (gameState-dragging t))
                           side5FRONTEND) side5]
                 [(image=? (dragState-img (gameState-dragging t))
                           side4FRONTEND) side4]
                 [else (dragState-img (gameState-dragging t))])                  
               (gameState-played t) x y)
      (make-dragState empty-image 0 0 #false)
      (gameState-timer t)
      (checkWin t))]
    [else
     (make-gameState
      (gameState-board t)
      (gameState-played t)
      (make-dragState empty-image 0 0 #false)
      (gameState-timer t)
      (gameState-won t))]))
  
; render t -> image
(define (render t)
  (place-image
   (text (number->string (floor (gameState-timer t))) TEXTSIZE BACKCOLOR)
   (* .5 (+ LEFTBOUND RIGHTBOUND))
   (- BIGHEIGHT TEXTSIZE)
   (overlay
    (cond
      [(gameState-won t) WIN]
      [else empty-image])
    (place-image
     (cond
       [(dragState-bool (gameState-dragging t))
        (dragState-img (gameState-dragging t))]
       [else empty-image])
     (dragState-x (gameState-dragging t))
     (dragState-y (gameState-dragging t))
     (place-image 
      (gameState-board t) (* .5 LEFTBOUND) (* .5 BIGHEIGHT)
      (place-image 
       (overlay (gameState-played t) grid ) (* .5 (+ LEFTBOUND RIGHTBOUND)) (* .5 BIGHEIGHT)
       (place-image (dispOptions 0) (* .5 (+ RIGHTBOUND BIGWIDTH)) (* .5 BIGHEIGHT) MTS)))))))

; handle mouse events gameState->gameState
(define (mouseh t x y me)
  (cond
    [(string=? me ONCLICK) (handleClick t x y)]
    [(string=? me ONRELEASE) (handleReleaseOfDrag t x y)]
    [(string=? me DRAG)
     (make-gameState (gameState-board t)
                     (gameState-played t)
                     (make-dragState (dragState-img
                                      (gameState-dragging t))
                                     x y #true)
                     (gameState-timer t)
                     #false)]
    [(string=? me MOVING) t]
    [(string=? me ENTRY) t]
    [(string=? me EXIT) (make-gameState (gameState-board t)
                                        (gameState-played t)
                                        (make-dragState empty-scene 0 0 #false)
                                        (gameState-timer t)
                                        (gameState-won t))]))

; gameState->image
(define (tock t)
  (make-gameState (gameState-board t)
                  (gameState-played t)
                  (gameState-dragging t)
                  (cond
                    [(gameState-won t) (gameState-timer t)]
                    [else (+ (gameState-timer t) .05)])
                  (gameState-won t)))

; gameRunner gameState->gameState
(define (main t)
  (big-bang (make-gameState
             (genBoard 0 0) MTB
             (make-dragState empty-image 0 0 #false) 0 #false)
            [to-draw render]
            [on-mouse mouseh]
            [on-tick tock]))