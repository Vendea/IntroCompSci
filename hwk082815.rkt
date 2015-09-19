;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hwk082815) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
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

;spaceship definitions and drawing
(define body 
  (overlay/align "center" "top" (text "U" (/ height 2) "black")
                 (overlay/align "center" "center" (text "S" (/ height 2) "black")
                                (overlay/align "center" "bottom" (text "A" (/ height 2) "black")
                                               (rectangle (/ width 2) (* height 2) "outline" "black")))))
(define nose-cone (isosceles-triangle (* width 0.5) 60 "solid" "black"))
(define t1 (triangle/aas 100 60 (/ width 4) "solid" "orange"))
(define t2 (flip-horizontal t1))
(define t3 (triangle/aas 70 70 (/ width 2) "solid" "yellow"))
(define flames
  (overlay/align "center" "top"
                 (beside/align "top" t1 t2)
                 t3))

(define rocket-ship
  (above/align "center"
               (above/align "center" nose-cone body)
               flames))
rocket-ship