#lang racket

(require "wire.rkt"
         "gates.rkt")

(define (flip-flop s r q i)
  (make-component
    (nand-gate s i q)
    (nand-gate q r i)))

(define (edge-flip-flop data clk q)
  (let ([!data (make-wire)]
        [!clk (make-wire)]
        [!q (make-wire)]
        [w1 (make-wire)]
        [w2 (make-wire)]
        [w3 (make-wire)]
        [w4 (make-wire)]
        [w5 (make-wire)]
        [w6 (make-wire)])
    (make-component
     (not-gate data !data)
     (not-gate clk !clk)
     (nand-gate data clk w1)
     (nand-gate !data clk w2)
     (flip-flop w1 w2 w3 w4)
     (nand-gate w3 !clk w5)
     (nand-gate w4 !clk w6)
     (flip-flop w5 w6 q !q))))

(provide
  flip-flop
  edge-flip-flop)