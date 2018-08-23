
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence low high stride)
  (if (> low high)
  null
  (cons low (sequence (+ low stride) high stride))))

(define (string-append-map xs suffix)
  (map (lambda(i) (string-append i suffix)) xs))

(define (list-nth-mod xs n)
  (cond
    [(< n 0) (error "list-nth-mod: negative number")]
    [(null? xs) (error "list-nth-mod: empty list")]
    [else (let ([i (remainder n (length xs))])
          (list-ref xs i))]))

(define (stream-for-n-steps s n)
  (if (= n 0)
  null
  (cons (car(s)) (stream-for-n-steps (cdr (s)) (- n 1))))) 

(define funny-number-stream
  (letrec ([f (lambda (x) (cons (if (= (modulo x 5) 0)
                                    (- x)
                                    x)
                           (lambda() (f (+ x 1)))))])
    (lambda() (f 1))))

(define dan-then-dog
  (letrec ([f (lambda (x) (cons (if (= (modulo x 2) 0)
                                    "dog.jpg"
                                    "dan.jpg")
                           (lambda() (f (+ x 1)))))])
    (lambda() (f 1))))

(define (stream-add-zero s)
  (letrec ([f (lambda (x) (cons (cons 0 (car (x)))
                                (lambda() (f (cdr (x))))))])
    (lambda() (f s))))

(define (cycle-lists xs ys)
  (letrec ([f (lambda (n) (cons
                           (cons (list-nth-mod xs n) (list-nth-mod ys n))
                           (lambda() (f (+ n 1)))))])
    (lambda() (f 0))))

(define (vector-assoc v vec)
  (letrec ([length (vector-length vec)]
        [f (lambda (i) (cond [(equal? length 0) #f]
                             [(and (pair? (vector-ref vec i)) (equal? (car (vector-ref vec i)) v)) (vector-ref vec i)]
                             [(equal? length (+ i 1)) #f]
                             [#t (f (+ i 1))]))])
    (f 0)))
                           
(define (cached-assoc xs n)
  ( let ([cache (make-vector n #f)]
           [cache-position 0])
            (lambda (v)  ( let ([cache-search (lambda() (vector-assoc v cache))])
                           (cond [(equal? cache-search #f) (cache-search)]
                                [#t (let ([result (lambda() (assoc v xs))])
                                      (vector-set! cache cache-position (result))
                                      (set! cache-position (modulo (+ cache-position 1) (vector-length cache)))
                                      (result))])))
                                   
                          
    ))

(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (let ([exp1 e1])
      (letrec ([loop (lambda () (if (> exp1 e2)
                                     (loop)
                                     #t))])
       (loop)))]))
       