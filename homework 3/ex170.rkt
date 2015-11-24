;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex170) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; a Phone is three numbers, area code, city code, and 4 digit number
(define-struct Phone [area city four])

; list of Phones -> list of Phones
(define (replace liop)
  (cond 
    [(= 713 (Phone-area (first liop)))
        (helper (rest liop) (list (make-Phone 281 
                                       (Phone-city (first liop))
                                       (Phone-four (first liop)))))]
    [else (helper (rest liop) (list (first liop)))]))

; phone replace helper function
(define (helper liop building)
  (cond
    [(empty? liop) building]
    [else (helper (rest liop) (cons (cond
                                      [(= (Phone-area (first liop)) 713)
                                       (make-Phone 281 
                                                   (Phone-city (first liop))
                                                   (Phone-four (first liop)))]
                                      [else (first liop)])
                                    building))]))

(check-expect (replace (list (make-Phone 713 123 1244) 
                             (make-Phone 111 111 1111)))
              (list (make-Phone 111 111 1111)
                    (make-Phone 281 123 1244)))