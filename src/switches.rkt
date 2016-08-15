#lang racket

(require "wire.rkt"
         "gates.rkt")

(define (mux a b sel out)
  (let ([w1 (make-wire)]
        [w2 (make-wire)]
        [w3 (make-wire)])
    (make-component
     (nand-gate sel b w1)
     (not-gate sel w2)
     (nand-gate a w2 w3)
     (nand-gate w1 w3 out))))

(define (mux-4 a-bus b-bus sel out-bus)
  (make-component
    (mux (a-bus 0) (b-bus 0) sel (out-bus 0))
    (mux (a-bus 1) (b-bus 1) sel (out-bus 1))
    (mux (a-bus 2) (b-bus 2) sel (out-bus 2))
    (mux (a-bus 3) (b-bus 3) sel (out-bus 3))))

(define (mux-16 a-bus b-bus sel out-bus)
  (make-component
    (mux-4 (a-bus 0 3) (b-bus 0 3) sel (out-bus 0 3))
    (mux-4 (a-bus 4 7) (b-bus 4 7) sel (out-bus 4 7))
    (mux-4 (a-bus 8 11) (b-bus 8 11) sel (out-bus 8 11))
    (mux-4 (a-bus 12 15) (b-bus 12 15) sel (out-bus 12 15))))

(define (dmux in sel out1 out2)
  (let ([w1 (make-wire)]
        [w2 (make-wire)]
        [w3 (make-wire)])
    (make-component
     (not-gate sel w1)
     (nand-gate in w1 w2)
     (not-gate w2 out1)
     (nand-gate sel in w3)
     (not-gate w3 out2))))

(provide
  mux
  mux-16
  dmux)
