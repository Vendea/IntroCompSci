;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname list-of-list-of-strings) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; (listof (listof strings)) -> number
(define (how-many-ands llos)
  (cond
    [(empty? llos) 0]
    [else (+ (count-ands-on-list (first llos)) (how-many-ands (rest llos)))]))

(check-expect (how-many-ands (cons (cons "Hello" (cons "and" (cons "goodbye" empty)))
                                   (cons (cons "are" (cons "good" (cons "words" empty))) empty))) 1)
(check-expect (how-many-ands (cons (cons "Hello" (cons "or" (cons "goodbye" empty)))
                                   (cons (cons "are" (cons "good" (cons "words" empty))) empty))) 0)
(check-expect (how-many-ands (cons (cons "Hello" (cons "and" (cons "goodbye" empty)))
                                   (cons (cons "and" (cons "good" (cons "words" empty))) empty))) 2)
(check-expect (how-many-ands empty) 0)


;; (listof string) -> number
(define (count-ands-on-list los)
  (cond
    [(empty? los) 0]
    [(string=? (first los) "and") (+ 1 (count-ands-on-list (rest los)))]
    [else (count-ands-on-list (rest los))]
    ))

(check-expect (count-ands-on-list (cons "How" (cons "and" (cons "mike" empty)))) 1)
(check-expect (count-ands-on-list (cons "Alex" (cons "Bravo" (cons "Charlie" empty)))) 0)
(check-expect (count-ands-on-list empty) 0)
