;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname invaders) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

; invaders -> invaders
; Updates the game elements in i on each tick
(define (tock i)
  (make-invaders... (invaders-alien i) ... (move-missiles (invaders-missiles i)) ... (invaders-base i) ...))

(check-expect (tock (make-invaders (make-posn 150 40)
                                   (cons (make-posn 5 9)
                                         (cons (make-posn 22 153)
                                               (cons (make-posn 99 33)
                                                     empty)))
                                   300))
              (make-invaders (make-posn 150 (+ 40 ALIEN_VEL))
               (cons (make-posn 5 (- 9 MISSILE_VEL))
                    (cons (make-posn 22 (- 153 MISSILE_VEL))
                          (cons (make-posn 99 (- 33 MISSILE_VEL)) empty)))
               (+ 300 BASE_VEL)))

; (listof posn) -> (listof posn)
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
(define (move-missile p)
  (make-posn (posn-x p) (- (posn-y p) MISSILE_VEL)))

(check-expect (move-missile (make-posn 9 22))  (make-posn 9 (- 22 MISSILE_VEL)))
(check-expect (move-missile (make-posn 103 555)) (make-posn 103 (- 555 MISSILE_VEL)))