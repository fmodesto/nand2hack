#lang racket

(define (make-wire)
  (let ([signal 0])
    (define (set-signal! value)
      (set! signal value))
    (define (get-signal)
      signal)
    (define (dispatch message)
      (cond [(eq? message 'set) set-signal!]
            [(eq? message 'get) get-signal]
            [else (error "Unknown message:" message)]))
    dispatch))

(define (make-read-wire signal)
  (define (dispatch message)
    (cond [(eq? message 'set) (error "Read-only wire" signal)]
          [(eq? message 'get) (lambda () signal)]
          [else (error "Unknown message:" message)]))
  dispatch)

(define (get-signal wire)
  ((wire 'get)))

(define (set-signal! wire signal)
  ((wire 'set) signal))

(define zeros (make-read-wire 0))
(define ones (make-read-wire 1))

(provide
  make-wire
  get-signal
  set-signal!
  zeros
  ones)
