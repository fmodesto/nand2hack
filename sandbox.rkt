#lang racket

(require
  "src/simulator.rkt"
  "src/register.rkt"
  "src/utils.rkt")

(define simulation (simulate bit '(1 1 1) '(1)))

((simulation 0 0 1) 'step)
((simulation 0 0 1) 'step)
((simulation 0 0 1) 'step)
((simulation 0 0 0) 'step)
((simulation 0 0 0) 'step)
((simulation 0 0 0) 'step)
((simulation 0 0 1) 'step)
((simulation 0 0 1) 'step)
((simulation 0 0 1) 'step)
((simulation 0 0 0) 'step)
((simulation 0 0 0) 'step)
((simulation 0 0 0) 'step)
((simulation 0 0 1) 'step)
((simulation 0 0 1) 'step)
((simulation 0 0 1) 'step)

(show '........)
