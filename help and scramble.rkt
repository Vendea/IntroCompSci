;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |help and scramble|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)
(require 2htdp/universe)
(define draft 25)
(define Length 80)
(define base (ellipse Length (* draft 2) "solid" "blue"))
(define boat-hull (crop 0 draft Length draft base))
(define (fall y)
  (place-image boat-hull 50 y (empty-scene 100 100)))
(define background (place-image boat-hull 50 (- 100 (/ (image-height boat-hull) 2)) (empty-scene 100 100)))
;messing around
(define Height 500)
(define Width 500)
(define (grow-circle radius) 
     (place-image 
      (circle radius "solid" "magenta") (/ Width 2) (/ Height 2) 
      (rectangle Width Height "solid" "lightseagreen")))

