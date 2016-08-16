#lang racket/base

(require rackunit
         "simtest.rkt"
         "../src/wire.rkt"
         "../src/bus.rkt")

(define wire (make-wire))
(define bus (as-bus wire))

(test-equal? "Same wire" (bus 0) wire)
(test-equal? "Same wire independent of index" (bus 4) wire)
(test-equal? "Can create subpart buses" ((bus 1 4) 5) wire)
