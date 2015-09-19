;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname house) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
;teachpacks
(require 2htdp/image)
(require 2htdp/universe)

;house definitions and drawing
(define width 100)
(define height 100)
(define base (square width "solid" "gray"))
(define roof (isosceles-triangle (* width 1.414 0.5) 90 "solid" "red"))
(define door (overlay/align "left" "center"
                            (circle(/ width 20) "solid" "black")
                            (rectangle (/ width 4) (/ height 0.75 2) "outline" "black")))

(define house
  (overlay/align "center" "bottom" door
  (above/align "center" roof base)))
house