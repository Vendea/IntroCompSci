;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Ex.154) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
; n img -> img

(define (col n img)
 (help-col n img img))

;col helper

(define (help-col n img built)
  (cond
    [(= 1 n) built]
    [else (help-col (- n 1) img (above img built))]
    ))

(define (row n img)
 (help-row n img img)
  )

; row helper

(define (help-row n img built)
  (cond
    [(= 1 n) built]
    [else (help-row (- n 1) img (beside img built))]
    ))



; Add-baloons consumes a listof-posn and returns an image showing the posns.

