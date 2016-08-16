#lang racket

(require rackunit
         "../src/simulator.rkt")

(define (check-table? fn table [steps 50])
  (define (check-row? row)
    (let* ([input (first row)]
           [output (second row)]
           [simulation (apply fn input)]
           [actual (simulation 'steps steps)])
      (with-check-info
        (('name "check-table?")
         ('params input)
         ('expected output)
         ('actual actual))
        (for-each (lambda (actual expected)
                    (if (eq? expected '?)
                        #t
                        (check-equal? actual expected)))
                  actual
                  output))))
  (for-each check-row? table))

(provide
  check-table?
  (all-from-out "../src/simulator.rkt"))
