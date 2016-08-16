#lang racket

(require racket/vector
         "wire.rkt")

(define (make-bus n)
  (define (make bus)
    (define (get from [to from])
      (if (eq? from to)
          (vector-ref bus from)
          (make (vector-copy bus from (+ 1 to)))))
    get)
  (make (build-vector n (lambda (x) (make-wire)))))

(define (read-bus bus size)
  (define (loop iteration value)
    (if (< iteration 0)
        value
        (loop (- iteration 1) (+ (* 2 value) (get-signal (bus iteration))))))
  (loop (- size 1) 0))

(define (write-bus! bus size value)
  (define (loop iteration value)
    (if (>= iteration size)
        (void)
        (begin
          (set-signal! (bus iteration) (remainder value 2))
          (loop (+ iteration 1) (quotient value 2)))))
  (loop 0 value))

(define (as-bus wire)
  (lambda (from [to from]) (if (eq? from to) wire (as-bus wire))))

(provide
  make-bus
  read-bus
  write-bus!
  as-bus)
