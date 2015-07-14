;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Maybe this time|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; libraries
(require 2htdp/image)
(require 2htdp/universe)
; constants
(define pic (overlay (circle 10 "solid" "green") (rectangle 40 4 "solid" "green")))
(define Height 400)
(define Width 200)
(define Canvas (empty-scene Width Height))
(define BLUE (place-image 
     (rectangle Width Height "solid" "blue") 
   (/ Width 2) (/ Height 2) Canvas)) 
(define background
  (place-image  
    (rectangle Width 10 "solid" "gray") (/ Width 2) (- Height 5) BLUE))
(define pic-stop (- (- Height (/ (image-height pic) 2)) 10))
(define Scenery (rectangle Width Height "solid" "blue"))
; functions
(define (fly-object height)
  (cond
    [(<= height pic-stop)
     (place-image pic (/ Width 2) height background)]
    [(> height pic-stop)
     (place-image pic (/ Width 2) pic-stop background)]))
(animate fly-object)