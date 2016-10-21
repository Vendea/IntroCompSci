(define (pow x p)
  (cond
    [(= p 1) x]
    [else (* x (pow x (- p 1)))]))
(define (horizcircles k rad)
  (cond
    [(= 1 k) (circle rad 'solid 'black)]
    [else (overlay (circle (* rad(pow 2 (- k 1))) 'outline (if (even? k) 'red 'blue))
                   (beside (horizcircles (- k 1) rad)
                           (horizcircles (- k 1) rad)))]))
(define (crosscircles k rad)
  (cond
    [(= k 1) (circle rad 'outline 'blue)]
    [else (overlay (circle (* rad (pow 3 (- k 1))) 'outline (if (even? k) 'red 'blue))
                   (above
                    (crosscircles (- k 1) rad)
                    (beside (crosscircles (- k 1) rad)
                            (crosscircles (- k 1) rad)
                            (crosscircles (- k 1) rad))
                    (crosscircles (- k 1) rad)))]))
