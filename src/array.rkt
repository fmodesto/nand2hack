#lang racket

(require "wire.rkt"
         "bus.rkt"
         "gates.rkt")

(define (make-array size component . buses)
  (apply
    make-component
    (map
      (lambda (i) (apply component (map (lambda (bus) (bus i)) buses)))
      (range size))))

(define (not-16 in-bus out-bus)
  (make-array 16 not-gate in-bus out-bus))

(define (and-16 a-bus b-bus out-bus)
  (make-array 16 and-gate a-bus b-bus out-bus))

(define (nand-16 a-bus b-bus out-bus)
  (make-array 16 nand-gate a-bus b-bus out-bus))

(define (or-16 a-bus b-bus out-bus)
  (make-array 16 or-gate a-bus b-bus out-bus))

(define (nor-16 a-bus b-bus out-bus)
  (make-array 16 nor-gate a-bus b-bus out-bus))

(define (xor-16 a-bus b-bus out-bus)
  (make-array 16 xor-gate a-bus b-bus out-bus))

(define (xnor-16 a-bus b-bus out-bus)
  (make-array 16 xnor-gate a-bus b-bus out-bus))

(define (or8-gate in-bus out)
  (let ([w1 (make-wire)]
        [w2 (make-wire)]
        [w3 (make-wire)]
        [w4 (make-wire)]
        [w5 (make-wire)]
        [w6 (make-wire)])
    (make-component
      (or-gate (in-bus 0) (in-bus 1) w1)
      (or-gate (in-bus 2) (in-bus 3) w2)
      (or-gate (in-bus 4) (in-bus 5) w3)
      (or-gate (in-bus 6) (in-bus 7) w4)
      (or-gate w1 w2 w5)
      (or-gate w3 w4 w6)
      (or-gate w5 w6 out))))

(define (nor16-gate in-bus out)
  (let ([w1 (make-wire)]
        [w2 (make-wire)])
    (make-component
      (or8-gate (in-bus 0 7) w1)
      (or8-gate (in-bus 8 15) w2)
      (nor-gate w1 w2 out))))

(provide
  make-array
  not-16
  and-16
  nand-16
  or-16
  nor-16
  xor-16
  xnor-16
  or8-gate
  nor16-gate)
