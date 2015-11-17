;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname natural-numbers) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; N image -> image
(define (col n img)
  (cond
    [(zero? n) (square 0 "solid" "black")]
    [else (above img (col (sub1 n) img))]))

(check-expect (col 3 (circle 5 "solid" "red"))
              (above (circle 5 "solid" "red") (circle 5 "solid" "red") (circle 5 "solid" "red")))
(check-expect (col 0 (circle 5 "solid" "red")) (square 0 "solid" "black"))

; N image -> image
(define (row n img)
  (cond
    [(zero? n) (square 0 "solid" "black")]
    [else (beside img (row (sub1 n) img))]))

(check-expect (row 3 (circle 5 "solid" "red"))
              (beside (circle 5 "solid" "red") (circle 5 "solid" "red") (circle 5 "solid" "red")))
(check-expect (row 0 (circle 5 "solid" "red")) (square 0 "solid" "black"))

; N -> N
(define (fact n)
  (cond
    [(zero? n) 1]
    [else (* n (fact (sub1 n)))]
    ))

(check-expect (fact 0) 1)
(check-expect (fact 5) 120)
