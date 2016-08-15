#! /bin/sh
fswatch -0 -e ".*" -i "\\-test\\.rkt$" test | xargs -0 -n 1 -I {} racket {}
