#lang racket

(require "wire.rkt")

(define (make-component . components)
  (apply append components))

(define (nand-gate a b out)
  (let ([result 0])
    (define (compute-value!)
      (set! result (if (and (eq? 1 (get-signal a)) (eq? 1 (get-signal b))) 0 1)))
    (define (set-value!)
      (let ([prev (get-signal out)])
        (set-signal! out result)
        (nor (eq? prev result))))
    (list (cons compute-value! set-value!))))

(define (not-gate in out)
  (make-component
   (nand-gate in in out)))

(define (buffer-gate in out)
  (let ([w (make-wire)])
    (make-component
     (not-gate in w)
     (not-gate w out))))

(define (and-gate a b out)
  (let ([w (make-wire)])
    (make-component
     (nand-gate a b w)
     (nand-gate w w out))))

(define (or-gate a b out)
  (let ([w1 (make-wire)]
        [w2 (make-wire)])
    (make-component
     (nand-gate a a w1)
     (nand-gate b b w2)
     (nand-gate w1 w2 out))))

(define (nor-gate a b out)
  (let ([w (make-wire)])
    (make-component
      (or-gate a b w)
      (not-gate w out))))

(define (xor-gate a b out [nand (make-wire)])
  (let ([w1 (make-wire)]
        [w2 (make-wire)])
    (make-component
     (nand-gate a b nand)
     (nand-gate a nand w1)
     (nand-gate b nand w2)
     (nand-gate w1 w2 out))))

(define (xnor-gate a b out)
  (let ([w (make-wire)])
    (make-component
      (xor-gate a b w)
      (not-gate w out))))

(provide
  make-component
  nand-gate
  not-gate
  buffer-gate
  and-gate
  or-gate
  nor-gate
  xor-gate
  xnor-gate)
