#lang racket

(require "wire.rkt"
         "bus.rkt"
         "gates.rkt")

(define (inc in cin out cout)
  (let ([w (make-wire)])
    (make-component
     (xor-gate in cin out w)
     (not-gate w cout))))

(define (inc-4 in-bus cin out-bus cout)
  (let ([carry (make-bus 3)])
    (make-component
     (inc (in-bus 0) cin (out-bus 0) (carry 0))
     (inc (in-bus 1) (carry 0) (out-bus 1) (carry 1))
     (inc (in-bus 2) (carry 1) (out-bus 2) (carry 2))
     (inc (in-bus 3) (carry 2) (out-bus 3) cout))))

(define (inc-16 in-bus enable out-bus)
  (let ([carry (make-bus 4)])
    (make-component
     (inc-4 (in-bus 0 3) enable (out-bus 0 3) (carry 0))
     (inc-4 (in-bus 4 7) (carry 0) (out-bus 4 7) (carry 1))
     (inc-4 (in-bus 8 11) (carry 1) (out-bus 8 11) (carry 2))
     (inc-4 (in-bus 12 15) (carry 2) (out-bus 12 15) (carry 3)))))

(define (full-adder a b cin out cout [nand (make-wire)])
  (let ([w1 (make-wire)]
        [w2 (make-wire)])
    (make-component
     (xor-gate a b w1 nand)
     (xor-gate w1 cin out w2)
     (nand-gate nand w2 cout))))

(provide
  inc
  inc-4
  inc-16
  full-adder)
