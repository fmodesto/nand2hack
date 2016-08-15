#lang racket

(require "wire.rkt"
         "bus.rkt"
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

(define (mux4-16 a-bus b-bus c-bus d-bus sel-bus out-bus)
  (let ([b1 (make-bus 16)]
        [b2 (make-bus 16)])
    (make-component
      (mux-16 a-bus b-bus (sel-bus 0) b1)
      (mux-16 c-bus d-bus (sel-bus 0) b2)
      (mux-16 b1 b2 (sel-bus 1) out-bus))))

(define (mux8-16 a-bus b-bus c-bus d-bus e-bus f-bus g-bus h-bus sel-bus out-bus)
  (let ([b1 (make-bus 16)]
        [b2 (make-bus 16)])
    (make-component
      (mux4-16 a-bus b-bus c-bus d-bus (sel-bus 0 1) b1)
      (mux4-16 e-bus f-bus g-bus h-bus (sel-bus 0 1) b2)
      (mux-16 b1 b2 (sel-bus 2) out-bus))))

(define (dmux in sel a b)
  (let ([w1 (make-wire)]
        [w2 (make-wire)]
        [w3 (make-wire)])
    (make-component
      (not-gate sel w1)
      (nand-gate in w1 w2)
      (not-gate w2 a)
      (nand-gate sel in w3)
      (not-gate w3 b))))

(define (dmux4 in sel-bus a b c d)
  (let ([w1 (make-wire)]
        [w2 (make-wire)])
    (make-component
      (dmux in (sel-bus 1) w1 w2)
      (dmux w1 (sel-bus 0) a b)
      (dmux w2 (sel-bus 0) c d))))

(define (dmux8 in sel-bus a b c d e f g h)
  (let ([w1 (make-wire)]
        [w2 (make-wire)])
    (make-component
      (dmux in (sel-bus 2) w1 w2)
      (dmux4 w1 (sel-bus 0 1) a b c d)
      (dmux4 w2 (sel-bus 0 1) e f g h))))

(provide
  mux
  mux-4
  mux-16
  mux4-16
  mux8-16
  dmux
  dmux4
  dmux8)
