#lang racket/base

(require rackunit
         "simtest.rkt"
         "../src/flipflops.rkt")

(test-case "*** LATCH ***"
  (check-table?
    (simulate latch '(1 1) '(1 1))
    '(((0 1) (1 0))
      ((1 1) (1 0))
      ((1 0) (0 1))
      ((1 1) (0 1)))))

(test-case "*** D-FLIP-FLOP ***"
  (check-table?
    (simulate d-flip-flop '(1 1) '(1))
    '(((1 1) (?))
      ((0 0) (1))
      ((0 1) (1))
      ((1 0) (0)))))
