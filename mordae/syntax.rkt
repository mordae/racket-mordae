#lang typed/racket/base
;
; General-Purpose Syntax Extensions
;

(require racket/match)

(provide
  (all-defined-out))


(define-syntax-rule (recursive (name ...) body ...)
  (let ()
    (define-values (name ...)
      body ...)
    (values name ...)))


(define-syntax-rule (loop body ...)
  (let loop : Nothing ()
    (begin body ...)
    (loop)))


(define-syntax-rule (with-semaphore sema body ...)
  (call-with-semaphore sema (λ _ body ...)))


(define-syntax-rule (spawn-thread body ...)
  (thread (λ () body ...)))


(define-syntax-rule (spawn-thread-server (bind ...) body ...)
  (spawn-thread
    (let (bind ...)
      (loop
        (match (thread-receive)
          body ...)))))


; vim:set ts=2 sw=2 et:
