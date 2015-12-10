;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lists-in-sync) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; (listof number) (listof number) -> (listof number)
(define (pay-checks l1 l2)
  (cond
    [(and (empty? l1) (empty? l2)) empty]
    [(empty? l1) (error "pay-checks: " "missing some hours")]
    [(empty? l2) (error "pay-checks: " "missing some pay rates")]
    [else (cons (* (first l1) (first l2)) (pay-checks (rest l1) (rest l2)))]
    ))

(check-expect (pay-checks (list 16 25 12 17) (list 8 9.50 12 8)) (list 128 237.50 144 136))
(check-expect (pay-checks empty empty) empty)
(check-error (pay-checks (list 16 25 12 17) empty) "pay-checks: missing some pay rates")
(check-error (pay-checks empty (list 8 9.50 12 8)) "pay-checks: missing some hours")