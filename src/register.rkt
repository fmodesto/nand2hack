#lang racket

(require "wire.rkt"
         "gates.rkt"
         "switches.rkt"
         "flipflops.rkt")

(define (bit in load clk out)
  (let ([w (make-wire)]
        [loop (make-wire)])
    (make-component
      (mux out in load w)
      (d-flip-flop in clk out))))

(provide
  bit)
