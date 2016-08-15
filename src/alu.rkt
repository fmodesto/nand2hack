#lang racket

(require "wire.rkt"
         "bus.rkt"
         "gates.rkt"
         "arithmetic.rkt")

(define (alu-function-bit f x y cin out cout)
  (let ([s (make-wire)]
        [no-ab (make-wire)]
        [w1 (make-wire)]
        [w2 (make-wire)])
    (make-component
     (full-adder x y cin s cout no-ab)
     (nand-gate f s w1)
     (or-gate f no-ab w2)
     (nand-gate w1 w2 out))))

(define (alu-function-4bit f x-bus y-bus cin out-bus cout)
  (let ([carry (make-bus 3)])
    (make-component
     (alu-function-bit f (x-bus 0) (y-bus 0) cin (out-bus 0) (carry 0))
     (alu-function-bit f (x-bus 1) (y-bus 1) (carry 0) (out-bus 1) (carry 1))
     (alu-function-bit f (x-bus 2) (y-bus 2) (carry 1) (out-bus 2) (carry 2))
     (alu-function-bit f (x-bus 3) (y-bus 3) (carry 2) (out-bus 3) cout))))

(provide
  alu-function-bit
  alu-function-4bit)
