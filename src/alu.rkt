#lang racket

(require "wire.rkt"
         "bus.rkt"
         "gates.rkt"
         "array.rkt"
         "arithmetic.rkt")

(define (alu-part f s no-ab out)
  (let ([w1 (make-wire)]
        [w2 (make-wire)])
    (make-component
     (nand-gate f s w1)
     (or-gate f no-ab w2)
     (nand-gate w1 w2 out))))

(define (alu-part-16 f s-bus nand-bus out-bus)
  (make-array 16 alu-part (as-bus f) s-bus nand-bus out-bus))

(define (alu-fn16 f a-bus b-bus out-bus)
  (let ([s-bus (make-bus 16)]
        [nand-bus (make-bus 16)])
    (make-component
      (add16 a-bus b-bus s-bus nand-bus)
      (alu-part-16 f s-bus nand-bus out-bus))))

(define (alu x-bus y-bus zx nx zy ny f no out-bus zr ng)
  (let ([nzx (make-wire)]
        [nnx (make-wire)]
        [nzy (make-wire)]
        [nny (make-wire)]
        [x1-bus (make-bus 16)]
        [x2-bus (make-bus 16)]
        [y1-bus (make-bus 16)]
        [y2-bus (make-bus 16)]
        [o-bus (make-bus 16)])
    (make-component
      (not-gate zx nzx)
      (not-gate nx nnx)
      (not-gate zy nzy)
      (not-gate ny nny)
      (nand-16 (as-bus nzx) x-bus x1-bus)
      (xor-16 (as-bus nnx) x1-bus x2-bus)
      (nand-16 (as-bus nzy) y-bus y1-bus)
      (xor-16 (as-bus nny) y1-bus y2-bus)
      (alu-fn16 f x2-bus y2-bus o-bus)
      (xor-16 (as-bus no) o-bus out-bus)
      (buffer-gate (out-bus 15) ng)
      (nor16-gate out-bus zr))))

(provide
  alu-part
  alu-fn16
  alu)
