;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |final project start|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)
(require 2htdp/universe)


(define WIDTH 500)
(define HEIGHT 500)
(define small (* .25 .8 WIDTH))
(define chooseColor "red")
;6 sides of the cubes
(define side1 (overlay (circle (* .5 .75 small) "solid" "white") (square small "solid" "black")))
(define side6 (overlay (circle (* .5 .75 small) "solid" "black") (square small "solid" "white")))
(define side3 (square small "solid" "black"))
(define side4 (square small "outline" "black"))
(define side2 (overlay (triangle/ass 90 small small  "solid" "white") (square small "solid" "black")))
(define side5 (overlay (triangle/ass 90 small small "solid" "black") (square small "solid" "white")))
(define side7 (rotate 90 side2))
(define side8 (rotate 90 side5))

; playing board
(define grid
  (overlay/align "right" "middle"
                 (beside
                  (rectangle small (* .8 HEIGHT) "outline" "black")
                  (rectangle small (* .8 HEIGHT) "outline" "black"))
  (overlay/align "left" "middle"
                 (rectangle small (* .8 HEIGHT) "outline" "black")
  (overlay/align "middle" "bottom"
                 (above
                  (rectangle (* .8 WIDTH) small "outline" "black")
                  (rectangle (* .8 WIDTH) small "outline" "black"))
  (overlay/align "middle" "top" 
                 (rectangle (* .8 WIDTH) small "outline" "black")
                 (rectangle (* .8 WIDTH) (* .8 HEIGHT) "outline" "black"))))))
(define playBoard (overlay/align "middle" "middle" grid (empty-scene WIDTH HEIGHT)))

; location of centers
(define centersi (list 