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

(provide
  not-16
  and-16
  nand-16
  or-16
  nor-16
  xor-16
  xnor-16)
