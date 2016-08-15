#lang racket

(define ... (lambda args ...))

(define show (lambda vars
  (if (empty? vars)
      (display #\newline)
      (begin
        (display (car vars))
        (display #\space)
        (apply show (cdr vars))))))

(provide
  ...
  show)
