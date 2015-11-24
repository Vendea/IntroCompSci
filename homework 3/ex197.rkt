;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex197) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
(require 2htdp/batch-io)
(define DICT-LOC "words.txt")

(define DICT-AS-LIST (read-lines DICT-LOC))

(define (in-dictionary los)
  (helper-in-dict los '()))
(check-expect (in-dictionary (list "cat" "good" "bad" "mjfel"))
              (list "bad" "good" "cat"))

(define (helper-in-dict los building)
  (cond
    [(empty? los) building]
    [else 
     (cond
       [(is-in-list (first los) DICT-AS-LIST)
        (helper-in-dict (rest los) 
         (cons (first los) building))]
       [else (helper-in-dict (rest los) building)])]))
  
(define (is-in-list str dict)
  (cond
    [(empty? dict) #false]
    [(string=? str (first dict)) #true]
    [else (is-in-list str (rest dict))]))
(check-expect (is-in-list "cat" DICT-AS-LIST) #true)