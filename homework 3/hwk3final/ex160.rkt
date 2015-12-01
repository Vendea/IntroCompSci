;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex160) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
(define-struct THING [points num max])

;number and image -> column of images
(define (col n img)
  (cond 
    [(= 1 n) img]
    [else
     (above img (col (- n 1) img))]))

;number and image -> row of images
(define (row n img)
  (cond 
    [(= 1 n) img]
    [else
     (beside img (row (- n 1) img))]))

(define unit (square 10 "outline" "black"))
(define grid (row 8 (col 18 unit)))
(define background (overlay grid (empty-scene 80 180)))
(define balloon (circle 2 "solid" "red"))

; list of posns -> image
(define (add-balloons lop img)
  (cond 
    [(empty? lop) img]
    [else (add-balloons (rest lop) 
                        (place-image balloon 
                                     (posn-x (first lop))
                                     (posn-y (first lop))
                                     img))]))

; THING -> list of points
(define (make-n-balloons th)
  (cond 
    [(= (floor (THING-num th)) 0) '()]
    [else 
     (cons (first (THING-points th)) 
           (make-n-balloons 
            (make-THING (rest (THING-points th)) (- (THING-num th) 1) (THING-max th))))]))

; number -> list of n points
(define (make-points n)
  (cond 
    [(= n 0) '()]
    [else
     (cons (make-posn (random 80) (random 180)) (make-points (- n 1)))]))

(define (render th)
  (add-balloons (make-n-balloons th) background))

(define (tock th)
  (cond 
    [(= (THING-num th) (THING-max th)) th]
    [else
     (make-THING (THING-points th) (+ (THING-num th) .1) (THING-max th))]))
     
(define (riot n)
  (big-bang (make-THING (make-points n) 0 n)
            [on-tick tock]
            [to-draw render]))