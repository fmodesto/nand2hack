#lang racket

(require "wire.rkt"
         "bus.rkt"
         "gates.rkt")

(define (inc in cin out cout)
  (let ([w (make-wire)])
    (make-component
     (xor-gate in cin out w)
     (not-gate w cout))))

(define (inc4 in-bus cin out-bus cout)
  (let ([carry (make-bus 3)])
    (make-component
     (inc (in-bus 0) cin (out-bus 0) (carry 0))
     (inc (in-bus 1) (carry 0) (out-bus 1) (carry 1))
     (inc (in-bus 2) (carry 1) (out-bus 2) (carry 2))
     (inc (in-bus 3) (carry 2) (out-bus 3) cout))))

(define (inc16 in-bus enable out-bus)
  (let ([carry (make-bus 4)])
    (make-component
     (inc4 (in-bus 0 3) enable (out-bus 0 3) (carry 0))
     (inc4 (in-bus 4 7) (carry 0) (out-bus 4 7) (carry 1))
     (inc4 (in-bus 8 11) (carry 1) (out-bus 8 11) (carry 2))
     (inc4 (in-bus 12 15) (carry 2) (out-bus 12 15) (carry 3)))))

(define (full-adder a b cin out cout [nand (make-wire)])
  (let ([w1 (make-wire)]
        [w2 (make-wire)])
    (make-component
     (xor-gate a b w1 nand)
     (xor-gate w1 cin out w2)
     (nand-gate nand w2 cout))))

(define (add4 a-bus b-bus cin out-bus cout [nand-bus (make-bus 4)])
  (let ([carry (make-bus 3)])
    (make-component
     (full-adder (a-bus 0) (b-bus 0) cin (out-bus 0) (carry 0) (nand-bus 0))
     (full-adder (a-bus 1) (b-bus 1) (carry 0) (out-bus 1) (carry 1) (nand-bus 1))
     (full-adder (a-bus 2) (b-bus 2) (carry 1) (out-bus 2) (carry 2) (nand-bus 2))
     (full-adder (a-bus 3) (b-bus 3) (carry 2) (out-bus 3) cout (nand-bus 3)))))

(define (add16 a-bus b-bus out-bus [nand-bus (make-bus 16)])
  (let ([carry (make-bus 4)])
    (make-component
     (add4 (a-bus 0 3) (b-bus 0 3) zeros (out-bus 0 3) (carry 0) (nand-bus 0 3))
     (add4 (a-bus 4 7) (b-bus 4 7) (carry 0) (out-bus 4 7) (carry 1) (nand-bus 4 7))
     (add4 (a-bus 8 11) (b-bus 8 11) (carry 1) (out-bus 8 11) (carry 2) (nand-bus 8 11))
     (add4 (a-bus 12 15) (b-bus 12 15) (carry 2) (out-bus 12 15) (carry 3) (nand-bus 12 15)))))

(provide
  inc
  inc4
  inc16
  full-adder
  add4
  add16)
