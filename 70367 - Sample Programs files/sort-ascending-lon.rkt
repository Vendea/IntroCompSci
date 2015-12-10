;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname sort-ascending-lon) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define SAMPLE (list 6 1 2 5 9))

; (listof number) -> (listof number)
; Puts lon into ascending order
(define (sorter lon)
  (cond
    [(empty? lon) empty]
    [else (insert (first lon) (sorter (rest lon)))]
    ))

(check-satisfied (sorter SAMPLE) in-sorted-order?)
(check-satisfied (sorter empty) in-sorted-order?)

; number (listof number) -> (listof number)
; Inserts n into lon (which is in sorted order) so that the resulting list is in sorted order
(define (insert n lon)
  (cond
    [(empty? lon) (list n)]
    [(< n (first lon)) (cons n lon)]
    [else (cons (first lon) (insert n (rest lon)))]
    ))

(check-expect (insert 6 (list 1 2 5 9)) (list 1 2 5 6 9))
(check-expect (insert 5 (list 3 8 10)) (list 3 5 8 10))
(check-expect (insert 3 empty) (list 3))
(check-expect (insert 5 (list 10 15)) (list 5 10 15))
(check-expect (insert 19 (list 10 15)) (list 10 15 19))




; (listof number) -> boolean
; Returns #true if lon is sorted, #false otherwise
(define (in-sorted-order? lon)
  (cond
    [(empty? lon) #true]
    [(empty? (rest lon)) #true]
    [else (and (< (first lon) (second lon)) (in-sorted-order? (rest lon)))]
    ))

(check-expect (in-sorted-order? (list 5 3 2)) #false)
(check-expect (in-sorted-order? (list 1 2 3)) #true)
(check-expect (in-sorted-order? (list 3)) #true)
(check-expect (in-sorted-order? empty) #true)