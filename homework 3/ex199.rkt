;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex199) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; letter, list of words -> list of words
(define (insert-everywhere/in-all-words letter low)
  (rearrangements (get-words letter low)))

; letter, list of words -> list of words
(define (get-words lett low)
  (cond
    [(empty? low) '()]
    [else
     (cons (cons lett (first low)) (get-words lett (rest low)))]))

; list of words -> longer list of words
(define (rearrangements low)
  (cond
    [(empty? low) '()]
    [else 
     (cons (rearrange (first low)) (rearrangements (rest low)))]))

; word -> list of words      
(define (rearrange w)
  (cond
    [(= (string-length (word->string w)) 1) (list w)]
    [(= (string-length (word->string w)) 2) 
     (list (list (first w) (first (rest w))) (list (first (rest w)) (first w)))]
    [else (handle-list (get-letter-with-rest 1 (word->string w)))]))

; list of tuples of letter and strings -> list of words
(define (handle-list lolww)
  (cond
    [(empty? lolww) '()]
    [else (append 
           (add-letter-to-all 
            (first (first lolww)) 
            (rearrange (string->word (first (rest (first lolww))))))
           (handle-list (rest lolww)))]))

; letter, list of words -> list of words
(define (add-letter-to-all lett low)
  (cond
    [(empty? low) '()]
    [else (cons (cons lett (first low)) (add-letter-to-all lett (rest low)))]))
  
; string -> list of tuples of letter and string (corresponding rest of word)
(define (get-letter-with-rest n word)
  (cond
    [(= n (string-length word)) (list (list
                                 (substring word (- n 1) n)
                                 (substring word 0 (- n 1))))]
    [(= n 1) (cons (list
                    (substring word (- n 1) n)
                    (substring word n (string-length word)))
                   (get-letter-with-rest (+ n 1) word))]
    [else (cons (list 
                 (substring word (- n 1) n)
                 (string-append 
                  (substring word 0 (- n 1))
                  (substring word n (string-length word))))
                (get-letter-with-rest (+ n 1) word))]))

(check-expect (get-letter-with-rest 1 "cat") (list (list "c" "at") (list "a" "ct") (list "t" "ca")))
(check-expect (get-letter-with-rest 1 "at") (list (list "a" "t") (list "t" "a")))

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
     