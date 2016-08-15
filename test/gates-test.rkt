#lang racket/base

(require rackunit
         "simtest.rkt"
         "../src/simulator.rkt"
         "../src/gates.rkt")

(test-case "*** NOT ***"
  (check-table?
    (simulate not-gate '(1) '(1) 5)
    '(((0) (1))
      ((1) (0)))))

(test-case "*** AND ***"
  (check-table?
    (simulate and-gate '(1 1) '(1) 5)
    '(((0 0) (0))
      ((0 1) (0))
      ((1 0) (0))
      ((1 1) (1)))))

(test-case "*** NAND ***"
  (check-table?
    (simulate nand-gate '(1 1) '(1) 5)
    '(((0 0) (1))
      ((0 1) (1))
      ((1 0) (1))
      ((1 1) (0)))))

(test-case "*** OR ***"
  (check-table?
    (simulate or-gate '(1 1) '(1) 5)
    '(((0 0) (0))
      ((0 1) (1))
      ((1 0) (1))
      ((1 1) (1)))))

(test-case "*** NOR ***"
  (check-table?
    (simulate nor-gate '(1 1) '(1) 5)
    '(((0 0) (1))
      ((0 1) (0))
      ((1 0) (0))
      ((1 1) (0)))))

(test-case "*** XOR ***"
  (check-table?
    (simulate xor-gate '(1 1) '(1) 5)
    '(((0 0) (0))
      ((0 1) (1))
      ((1 0) (1))
      ((1 1) (0)))))

(test-case "*** XNOR ***"
  (check-table?
    (simulate xnor-gate '(1 1) '(1) 5)
    '(((0 0) (1))
      ((0 1) (0))
      ((1 0) (0))
      ((1 1) (1)))))
