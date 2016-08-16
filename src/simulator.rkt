#lang racket

(require "wire.rkt"
         "bus.rkt"
         "utils.rkt")

(define (simulator components)
  (define (read-step)
    (for-each (lambda (c) ((car c))) components))
  (define (write-step)
    (foldl (lambda (c has-change) (or ((cdr c)) has-change)) #f components))
  (define (step)
    (read-step)
    (write-step))
  (define (run max)
    (define (loop it)
      (if (and (step) (< it max))
          (loop (+ it 1))
          it))
    (loop 1))
  run)

(define (make-connections format)
  (map (lambda (x) (if (= x 1) (make-wire) (make-bus x))) format))

(define (set-values! wires format values)
  (define (set-value! wire size value)
    (if (= size 1)
        (set-signal! wire value)
        (write-bus! wire size value)))
  (for-each set-value! wires format values))

(define (get-values wires format)
  (define (get-value wire size)
    (if (= size 1)
        (get-signal wire)
        (read-bus wire size)))
  (map get-value wires format))

(define (simulate component in out)
  (let* ([input (make-connections in)]
         [output (make-connections out)]
         [comp (apply component (append input output))]
         [simulation (simulator comp)])
    (define (steps num)
      (simulation num)
      (get-values output out))
    (define (dispatch . values)
      (set-values! input in values)
      (lambda (fn . args)
        (cond [(eq? fn 'steps) (apply steps args)]
              [(eq? fn 'run) (apply steps args)]
              [else (error "Unknown option" fn)])))
    dispatch))

#|
(define (truth-table simulated-component size)
  (define (loop iteration value list)
    (if (>= iteration size)
        list
        (loop (+ iteration 1) (quotient value 2) (cons (remainder value 2) list))))
  (define (test value)
    (let ([input (loop 0 value empty)])
      (list input (apply simulated-component input))))
  (define (test-values)
    (map test (range (expt 2 size))))
  (test-values))
|#

(provide
  simulator
  simulate)
