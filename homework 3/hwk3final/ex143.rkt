;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex143) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; list of images and an integer -> image or #false
(define (ill-sized? loi n)
  (cond
    [(empty? loi) #false]
    [(= (image-width (first loi)) n) (cond
                                 [(= (image-height (first loi)) n) #true]
                                 [else #false])]
    [else (ill-sized? (rest loi) n)]))

(check-expect (ill-sized? (list (square 10 "solid" "black") 
                                (rectangle 10 20 "solid" "black")) 10) #true)
(check-expect (ill-sized? (list (rectangle 10 20 "solid" "black")
                                (square 10 "solid" "black")) 4) #false)