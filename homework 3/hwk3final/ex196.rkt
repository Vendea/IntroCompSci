;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex196) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
;String -> Word
(define (string->word s)
  (cond
    [(= (string-length s) 1) (list s)]
    [else (cons (substring s 0 1) (string->word 
                                   (substring s 1 (string-length s))))]))

(check-expect (string->word "abc") (list "a" "b" "c"))

;Word -> String
(define (word->string w)
  (cond
    [(empty? w) ""]
    [(empty? (rest w)) (first w)]
    [else
     (string-append (first w) (word->string (rest w)))]))

(check-expect (word->string (list "a" "b" "c")) "abc")

;list of words -> list of strings
(define (words->strings low)
  (cond
    [(empty? low) '()]
    [(empty? (rest low)) (list (word->string (first low)))]
    [else 
     (cons (word->string (first low)) (words->strings (rest low)))]))

(check-expect (words->strings (list (list "a" "b" "c") (list "d" "e" "f")))
              (list "abc" "def"))

; list of strings -> list of words
(define (strings->words los)
  (cond
    [(empty? los) '()]
    [(empty? (rest los)) (list (string->word (first los)))]
    [else 
     (cons (string->word (first los)) (strings->words (rest los)))]))

(check-expect (strings->words (list "abc" "def"))
                              (list (list "a" "b" "c") (list "d" "e" "f")))

