#! /bin/sh
fswatch -0 sandbox.rkt src/ test/ | xargs -0 -n 1 -I {} racket sandbox.rkt
