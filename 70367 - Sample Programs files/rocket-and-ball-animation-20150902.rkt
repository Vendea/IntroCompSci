;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Rocket and Ball Animation 2015-09-02|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define ROCKET (above (triangle 30 "solid" "blue") (rectangle 20 40 "outline" "black")))

(define HOUSE (above (triangle 40 "solid" "black") (rectangle 40 25 "solid" "red")))

(define MTS (empty-scene 300 500))

(define (paint tick)
  (cond
    [(< tick 250) (place-image HOUSE 250 469 (place-image ROCKET tick (y-pos tick) MTS))]
    [(>= tick 250) (place-image (radial-star 30 30 80 "solid" "red") 250 469 MTS)]
  ))

(define (y-pos tick)
  (+ (* 460/15625 (sqr tick)) (* -184/25 tick) 470))

(define (ball x)
  (place-image (circle 30 "solid" "blue") (remainder x 300) (remainder x 500) MTS))
