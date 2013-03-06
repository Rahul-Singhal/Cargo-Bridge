#lang racket
(require racket/include)
(require graphics/graphics)
;(require racket/gui/base)
;(require graphics/graphics)
(open-graphics)
(include "cargo-bridge-project-graphics-improved.rkt")
(include "eqnsolve.rkt")
(include "temppro.rkt")
(include "row-echolon.rkt")

(define v1 (open-viewport "Cargo Bridge" 1200 700))

(define (1-screen)
  (lambda (x)
    (begin (((draw-pixmap-posn "start_screen_final.jpg") x)
            (make-posn 0 0)
            "black")
           (define m (mouse-click-posn (get-mouse-click x)))
           (define (n m) (cond [(and (> 712 (posn-x m))
                                     (< 477 (posn-x m))
                                     (> 228 (posn-y m))
                                     (< 158 (posn-y m)))
                                ((select-level-screen) x)]
                               [(and (> 712 (posn-x m))
                                     (< 477 (posn-x m))
                                     (> 308 (posn-y m))
                                     (< 239 (posn-y m)))
                                ((instruction-screen) x)]
                               [(and (> 712 (posn-x m))
                                     (< 477 (posn-x m))
                                     (> 387 (posn-y m))
                                     (< 317 (posn-y m)))
                                ((credit-screen) x)]
                               [(and (> 712 (posn-x m))
                                     (< 477 (posn-x m))
                                     (> 466 (posn-y m))
                                     (< 395 (posn-y m)))
                                (close-viewport x) ]
                               
                               [else (n (mouse-click-posn (get-mouse-click x)))]))
           (n m))))

(define (select-level-screen)
  (lambda (x)
    (begin (((draw-pixmap-posn "level.png") x)
            (make-posn 0 0)
            "black")
           (define m (mouse-click-posn (get-mouse-click x)))
           (define (n m) (cond [(and (> 133 (posn-x m))
                                     (< 9 (posn-x m))
                                     (> 691 (posn-y m))
                                     (< 646 (posn-y m))) 
                                ((1-screen) x)]
                               [(and (> 411 (posn-x m))
                                     (< 331 (posn-x m))
                                     (> 229 (posn-y m))
                                     (< 151 (posn-y m)))
                                (begin
                                  (close-viewport x)
                                  (new Bridge% [p1 (cons 444 389)] [p2 (cons 711 389)] [stage "stage1.jpg"] [stage-num 1]) )]
                               [(and (> 660 (posn-x m))
                                     (< 580 (posn-x m))
                                     (> 229 (posn-y m))
                                     (< 151 (posn-y m)))
                                (begin
                                  (close-viewport x)
                                  (new Bridge% [p1 (cons 405 389)] [p2 (cons 683 389)] [stage "stage2.jpg"] [stage-num 2]))]
                               [(and (> 892 (posn-x m))
                                     (< 813 (posn-x m))
                                     (> 229 (posn-y m))
                                     (< 151 (posn-y m)))
                                (begin
                                  (close-viewport x)
                                  (new Bridge% [p1 (cons 365 459)] [p2 (cons 698 524)] [stage "stage3.jpg"] [stage-num 3]))]
                               [else (n (mouse-click-posn (get-mouse-click x)))]))
           (n m))))

(define (danger)
  (lambda(x)
    (begin (((draw-pixmap-posn "Danger.jpg") x)
            (make-posn 0 0)
            "black")
           (define m (mouse-click-posn (get-mouse-click x)))
           (define (n m) (cond [(and (> 288 (posn-x m))
                                     (< 130 (posn-x m))
                                     (> 422 (posn-y m))
                                     (< 385 (posn-y m)))
                                (begin 
                                  (close-viewport x) #t) ]
                               [else (n (mouse-click-posn (get-mouse-click x)))]))
           (n m))))

(define (unstable-bridge v1)
  (lambda(x)
    (begin (((draw-pixmap-posn "unbalanced-bridge.jpg") x)
            (make-posn 0 0)
            "black")
           (define m (mouse-click-posn (get-mouse-click x)))
           (define (n m) (cond [(and (> 288 (posn-x m))
                                     (< 130 (posn-x m))
                                     (> 422 (posn-y m))
                                     (< 385 (posn-y m)))
                                (begin 
                                  (close-viewport x) ((select-level-screen)v1)#t) ]
                               [else (n (mouse-click-posn (get-mouse-click x)))]))
           (n m))))

(define (congrats v1)
  (lambda(x)
    (begin (((draw-pixmap-posn "congratulations.jpg") x)
            (make-posn 0 0)
            "black")
           (define m (mouse-click-posn (get-mouse-click x)))
           (define (n m) (cond [(and (> 325 (posn-x m))
                                     (< 123 (posn-x m))
                                     (> 404 (posn-y m))
                                     (< 364 (posn-y m)))
                                (begin 
                                  (close-viewport x) ((select-level-screen) v1) #t) ]
                               [else (n (mouse-click-posn (get-mouse-click x)))]))
           (n m))))

(define (midway_fall v1)
  (lambda(x)
    (begin (((draw-pixmap-posn "fell_on_the_way.jpg") x)
            (make-posn 0 0)
            "black")
           (define m (mouse-click-posn (get-mouse-click x)))
           (define (n m) (cond [(and (> 288 (posn-x m))
                                     (< 130 (posn-x m))
                                     (> 422 (posn-y m))
                                     (< 385 (posn-y m)))
                                (begin 
                                  (close-viewport x) ((select-level-screen) v1) #t) ]
                               [else (n (mouse-click-posn (get-mouse-click x)))]))
           (n m))))




(define (credit-screen)
  (lambda (x)
    (begin (((draw-pixmap-posn "credits.png") x) 
            (make-posn 0 0)
            "black")
           (define m (mouse-click-posn (get-mouse-click x)))
           (define (n m) (cond [(and (> 133 (posn-x m))
                                     (< 9 (posn-x m))
                                     (> 691 (posn-y m))
                                     (< 646 (posn-y m)))
                                ((1-screen) x)]
                               [else (n (mouse-click-posn (get-mouse-click x)))]))
           (n m))))

(define (instruction-screen)
  (lambda (x)
    (begin (((draw-pixmap-posn "instructions.png") x)
            (make-posn 0 0)
            "black")
           (define m (mouse-click-posn (get-mouse-click x)))
           (define (n m) (cond [(and (> 133 (posn-x m))
                                     (< 9 (posn-x m))
                                     (> 691 (posn-y m))
                                     (< 646 (posn-y m)))
                                ((1-screen) x)]
                               [else (n (mouse-click-posn (get-mouse-click x)))]))
           (n m))))


((1-screen) v1) 
