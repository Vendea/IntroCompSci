;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex195) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
;String -> Word
(define (string->word s)
  (helpersw s '()))
             
(define (helpersw s built)
  (cond
    [(= 1 (string-length s)) 
     (cons (substring s 0 1) built)]
    [else (helpersw
           (substring s 0 (- (string-length s) 1))
           (cons (substring s 
                            (- (string-length s) 1) 
                            (string-length s)) built))]))

(check-expect (string->word "abc") (list "a" "b" "c"))

;Word -> String
(define (word->string w)
  (helperws w ""))

(define (helperws w built)
  (cond
    [(empty? (rest w))
     (string-append built (first w))]
    [else (helperws (rest w) (string-append
                            built (first w)))]))

(check-expect (word->string (list "a" "b" "c")) "abc")