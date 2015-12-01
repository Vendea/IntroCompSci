;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex173) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
(require 2htdp/batch-io)
; text file -> text file

(define (remove-articles n)
  (write-file (string-append "no-articles-" n)
              (collapse (read-words/line n))))

(define (collapse n)
  (cond
    [(empty? n) '()]
    [else
     (cond
       [(string=? (first (first n)) "the") (collapse (rest n))]
       [(string=? (first (first n)) "a") (collapse (rest n))]
       [(string=? (first (first n)) "an") (collapse (rest n))]
       [else
        (cond
          [(empty? (first (first n))) (collapse (rest n))]
          [else
           (string-append (first (first n)) (collapse (rest n)))])])]))