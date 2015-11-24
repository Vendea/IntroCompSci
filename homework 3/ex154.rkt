;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex154) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
;number and image -> column of images
(define (col n img)
  (help-col n img img))

;col helper
(define (help-col n img building)
  (cond 
    [(= 1 n) building]
    [else (help-col (- n 1) img (above img building))]))

;number and image -> row of images
(define (row n img)
  (help-row n img img))

;row helper
(define (help-row n img building)
  (cond 
    [(= 1 n) building]
    [else (help-row (- n 1) img (beside img building))]))

(define unit (square 10 "outline" "black"))
(define grid (row 8 (col 18 unit)))
(define background (overlay grid (empty-scene 80 180)))

; list of posns -> image
(define balloon (circle 2 "solid" "red"))
(define (add-balloons lop img)
  (cond 
    [(empty? lop) img]
    [else (add-balloons (rest lop) 
                        (place-image balloon 
                                     (posn-x (first lop))
                                     (posn-y (first lop))
                                     img))]))