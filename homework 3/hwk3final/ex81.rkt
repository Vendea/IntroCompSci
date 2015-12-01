;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex81) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
(define-struct tlw [one two three])

; two tlw (three-letter-word representations) -> another tlw
; showing where the words are the same / differ
(define (compare-word tlwone tlwtwo)
  (make-tlw
   (cond
     [(string=? (tlw-one tlwone) (tlw-one tlwtwo))
      (tlw-one tlwone)]
     [else #false])
   (cond
     [(string=? (tlw-two tlwone) (tlw-two tlwtwo))
      (tlw-two tlwone)]
     [else #false])
   (cond
     [(string=? (tlw-three tlwone) (tlw-three tlwtwo))
      (tlw-three tlwone)]
     [else #false])))