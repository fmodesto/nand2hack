#lang racket

(require rackunit)

(define (check-table? fn table)
  (define (check-row? row)
    (let* ([input (first row)]
           [output (second row)]
           [actual (apply fn input)])
      (with-check-info
        (('name "check-table?")
         ('params input)
         ('expected output)
         ('actual actual))
        (check-equal? actual output))))
  (for-each check-row? table))

(provide
  check-table?)
