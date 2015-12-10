;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname invaders-v2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An invaders is (make-invaders a m b) where
; a is a posn (position of the alien)
; m is a (listof posn) (the missile positions)
; b is a number (x position of the base)
(define-struct invaders [alien missiles base])


; Speed of the missiles
(define MISSILE_VEL 3)

; Speed of the base
(define BASE_VEL 2)

; Downward speed of alien
(define ALIEN_VEL 1)

; The scene
(define WIDTH 300)
(define HEIGHT 900)
(define MTS (empty-scene WIDTH HEIGHT))

; Game images
(define BASEIMG (above (square 10 "solid" "green") (rectangle 90 30 "solid" "green")))
(define ALIENIMG (rotate 45 (square 30 "solid" "red")))
(define MISSLEIMG (above (triangle 5 "solid" "blue") (rectangle 5 20 "solid" "blue")))

; The y-position of the base
(define BASEY (- HEIGHT (/ (image-height BASEIMG) 2) 1))

; invaders -> invaders
; Updates the game elements in i on each tick
(define (tock i)
  (make-invaders
   (move-alien (invaders-alien i))
   (move-missiles (invaders-missiles i))
   (move-base (invaders-base i))))

(check-expect (tock (make-invaders (make-posn 150 40)
                                   (cons (make-posn 5 9)
                                         (cons (make-posn 22 153)
                                               (cons (make-posn 99 33)
                                                     empty)))
                                   200))
              (make-invaders (make-posn 150 (+ 40 ALIEN_VEL))
               (cons (make-posn 5 (- 9 MISSILE_VEL))
                    (cons (make-posn 22 (- 153 MISSILE_VEL))
                          (cons (make-posn 99 (- 33 MISSILE_VEL)) empty)))
               (+ 200 BASE_VEL)))

; (listof posn) -> (listof posn)
; Move every missle on the list
(define (move-missiles lop)
  (cond
    [(empty? lop) empty]
    [else (cons (move-missile (first lop)) (move-missiles (rest lop)))]
    ))

(check-expect (move-missiles (cons (make-posn 5 9)
                                 (cons (make-posn 22 153)
                                       (cons (make-posn 99 33)
                                             empty))))
              (cons (make-posn 5 (- 9 MISSILE_VEL))
                    (cons (make-posn 22 (- 153 MISSILE_VEL))
                          (cons (make-posn 99 (- 33 MISSILE_VEL)) empty)))
              )
(check-expect (move-missiles (cons (make-posn 102 103) empty))
              (cons (make-posn 102 (- 103 MISSILE_VEL)) empty))
(check-expect (move-missiles empty) empty)

; posn -> posn
; Move a single missle
(define (move-missile p)
  (make-posn (posn-x p) (- (posn-y p) MISSILE_VEL)))

(check-expect (move-missile (make-posn 9 22))  (make-posn 9 (- 22 MISSILE_VEL)))
(check-expect (move-missile (make-posn 103 555)) (make-posn 103 (- 555 MISSILE_VEL)))

; posn -> posn
; Moves the alien down the screen
(define (move-alien a)
  (make-posn (posn-x a) (+ (posn-y a) ALIEN_VEL)))

(check-expect (move-alien (make-posn 50 90)) (make-posn 50 (+ 90 ALIEN_VEL)))

; number -> number
; Moves the base across the screen (left to right) with wrapping
(define (move-base b)
  (modulo (+ b BASE_VEL) WIDTH))

(check-expect (move-base 80) (+ 80 BASE_VEL))
(check-expect (move-base 299) 1)

; invaders -> scene
; Draw all the game elements on an empty scene
(define (render i)
  (place-image BASEIMG (invaders-base i) BASEY
               (place-image ALIENIMG (posn-x (invaders-alien i)) (posn-y (invaders-alien i))
                            (place-missiles (invaders-missiles i) MTS))))

(check-expect 1 1)

; (listof posn) scene -> scene
; Draw all the missiles in lop
(define (place-missiles lop s)
  (cond
    [(empty? lop) s]
    [else (place-image MISSLEIMG (posn-x (first lop)) (posn-y (first lop))
                       (place-missiles (rest lop) s))]
    ))

; invaders key -> invaders
(define (keyh i ke)
  (cond
    [(key=? ke " ") (make-invaders (invaders-alien i)
                                   (cons (make-posn (invaders-base i) BASEY) (invaders-missiles i))
                                   (invaders-base i))]
    [else i]
    ))

; invaders -> invaders 
(define (main i)
  (big-bang i
   [to-draw render]
   [on-tick tock]
   [on-key keyh]))