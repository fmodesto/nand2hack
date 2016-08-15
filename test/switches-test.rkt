#lang racket/base

(require rackunit
         "simtest.rkt"
         "../src/simulator.rkt"
         "../src/switches.rkt")

(test-case "*** MUX ***"
  (check-table?
    (simulate mux '(1 1 1) '(1) 5)
    '(((0 0 0) (0))
      ((0 1 0) (0))
      ((1 0 0) (1))
      ((1 1 0) (1))
      ((0 0 1) (0))
      ((0 1 1) (1))
      ((1 0 1) (0))
      ((1 1 1) (1)))))

(test-case "*** DMUX ***"
  (check-table?
    (simulate dmux '(1 1) '(1 1) 5)
    '(((0 0) (0 0))
      ((1 0) (1 0))
      ((0 1) (0 0))
      ((1 1) (0 1)))))
