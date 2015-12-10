;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname distance-to-enemies-for-each-friend) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; posn -> (posn -> number)
(define (dist-to-factory q)
  (lambda (p) (sqrt (+ (sqr (- (posn-x p) (posn-x q))) (sqr (- (posn-y p) (posn-y q))))))  )

(check-expect ((dist-to-factory (make-posn 0 0)) (make-posn 9 12)) 15)
(check-within ((dist-to-factory (make-posn 0 0)) (make-posn 1 2)) (sqrt 5) 0)
(check-expect ((dist-to-factory (make-posn 19 27)) (make-posn 22 31)) 5)

(define ENEMIES (list (make-posn 9 12) (make-posn 4 15) (make-posn 104 205)))
(define FRIENDS (list (make-posn 202 11) (make-posn 932 113) (make-posn 149 55)))

(define FF (lambda (f) (map (dist-to-factory f) ENEMIES)))

; Find distance of closest enemy for each friend
(map (lambda (ll) (foldl min 99999 ll)) (map (lambda (f) (map (dist-to-factory f) ENEMIES)) FRIENDS))
