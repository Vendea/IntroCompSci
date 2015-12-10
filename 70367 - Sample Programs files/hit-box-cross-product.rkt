;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname hit-box-cross-product) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Hit box size
(define HBWIDTH 20)
(define HBHEIGHT 20)

; posn posn number number -> boolean
; Determines if obj1 hits obj2's hit-box (box size determined by boxw & bowh)
(define (box-hit? obj1 obj2 boxw boxh)
  (and
   (< (- (posn-x obj2) (/ boxw 2)) (posn-x obj1) (+ (posn-x obj2) (/ boxw 2)))
   (< (- (posn-y obj2) (/ boxh 2)) (posn-y obj1) (+ (posn-y obj2) (/ boxh 2)))))

(check-expect (box-hit? (make-posn 60 40) (make-posn 50 30) 20 20) #false)
(check-expect (box-hit? (make-posn 60 40) (make-posn 50 30) 20 20) #false)
(check-expect (box-hit? (make-posn 50 30) (make-posn 50 30) 20 20) #true)
(check-expect (box-hit? (make-posn 59 39) (make-posn 50 30) 20 20) #true)

; (listof posn) (listof posn) -> boolean
(define (any-hit? missiles aliens)
  (cond
    [(empty? missiles) #false]
    [(empty? aliens) #false]
    [else (or (hit-one? (first missiles) aliens) (any-hit? (rest missiles) aliens))]))

(check-expect (any-hit? (list (make-posn 60 40) (make-posn 50 30))
                        (list (make-posn 50 30) (make-posn 100 150))) #true)
(check-expect (any-hit? (list (make-posn 60 40) (make-posn 50 30))
                        (list (make-posn 80 40) (make-posn 100 150))) #false)
(check-expect (any-hit? empty empty) #false)
(check-expect (any-hit? empty (list (make-posn 80 40) (make-posn 100 150))) #false)
(check-expect (any-hit? (list (make-posn 60 40) (make-posn 50 30)) empty) #false)


; posn (listof posn) -> boolean
(define (hit-one? missile aliens)
  (cond
    [(empty? aliens) #false]
    [else (or (box-hit? missile (first aliens) HBWIDTH HBHEIGHT) (hit-one? missile (rest aliens)))]))

(check-expect (hit-one? (make-posn 60 40) (list (make-posn 80 40) (make-posn 100 150))) #false)
(check-expect (hit-one? (make-posn 59 39) (list (make-posn 50 30) (make-posn 100 150))) #true)
(check-expect (hit-one? (make-posn 60 20) empty) #false)
