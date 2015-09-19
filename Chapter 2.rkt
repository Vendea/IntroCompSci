;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Chapter 2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;teachpacks
(require 2htdp/image)
(require 2htdp/universe)

;exercise 13
(define (Distance x y)
  (sqrt (+ (* x x) (* y y))))

;exercise 14
(define (cube-volume side) (* side side side))
(define (cube-surface side) (* side side 6))

;exercise 15
(define (string-first word) (string-ith word 0))

;exercise 16
(define (string-last word) (string-ith word (- (string-length word) 1)))

;exercise 17 
(define (bool-imply sunny friday) (if (not sunny) true (and friday true)))

;exercise 18
(define (image-area picture) (* (image-width picture) (image-height picture)))

;exercise 19
(define (classify-image picture)
  (cond [(= (image-height picture) (image-width picture)) "square"]
        [(> (image-height picture) (image-width picture)) "tall"]
        [(< (image-height picture) (image-width picture)) "wide"]))

;exercise 20
(define (string-join s1 s2) (string-append s1 "_" s2))

;exercise 21
(define (string-insert str i) (string-append (substring str 0 i) "_" (substring str i (string-length str))))

;exercise 22
(define (string-delete str i) (string-append (substring str 0 i) (substring str (+ 1 i) (string-length str))))

;exercises 23 and 24
 ;constants
(define avg-attendance 120)
(define at-cost 5)
(define people 15)
(define per-money .1)
(define y-intercept 180)
(define slope .04)
 ;functions
(define (attendance ticket-price) (- avg-attendance (* (- ticket-price at-cost) (/ people per-money))))
(define (revenue ticket-price) (* ticket-price (attendance ticket-price)))
(define (cost ticket-price) (+ y-intercept (* slope (attendance ticket-price))))
(define (profit ticket-price) (- (revenue ticket-price) (cost ticket-price)))
 ;determined profits: $1=511.2, $2=937.2, $3=1063.2, $4=889.2, $5=415.2
 ;best price: $2.90=1064.1
;alternative version
(define (other-profit price) 
  (- (* (+ 120 
           (* (/ 15 0.1) 
              (- 5.0 price))) 
        price) 
     (+ 180 
        (* 0.04 
           (+ 120 
              (* (/ 15 0.1) 
                 (- 5.0 price)))))))
