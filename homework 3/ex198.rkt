;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex198) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; a List-of-words is one of:
; '() (empty list)
; (list '()) (list of an empty word)
; (list Word Word) (list of one or more words)
; Word -> List of words
; All examples, would, naturally, be words, not strings as they currently are.
; This is a non-issue since we will initally only be processing words
; cat -> (cat, cta, act, atc, tac, tca)
; dog -> (dog, dgo, odg, ogd, god, gdo)
; bat -> (bat, bta, abt, atb, tab, tba)
(define (arrangements w)
  (cond 
    [(empty? w) '()]
    [(empty? (rest w)) (list w)
(define (2-letter-arrangements w)
  (list (list (first w) (first (rest w))) (list (first (rest w)) (first w))))

(check-expect (2-letter-arrangements (list "d" "e")) (list (list "d" "e")
                                                           (list "e" "d")))
(define (add-letter-to letter low)
  (cond 
    [(empty? (rest low)) (list (cons letter (list (first low))))]
    [else (cons (cons letter (first low)) (add-letter-to letter (rest low)))]))

