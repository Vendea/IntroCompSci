;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex153) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
;number and image -> column of images
(define (col n img)
  (cond 
    [(= 1 n) img]
    [else
     (above img (col (- n 1) img))]))

(define tempimg (square 5 "outline" "black"))
(check-expect (col 4 tempimg) (above tempimg
                                     (above tempimg
                                            (above tempimg tempimg))))
  
  
  
;number and image -> row of images
(define (row n img)
  (cond 
    [(= 1 n) img]
    [else
     (beside img (row (- n 1) img))]))

(check-expect (row 4 tempimg) (beside tempimg
                                     (beside tempimg
                                            (beside tempimg tempimg))))
  

