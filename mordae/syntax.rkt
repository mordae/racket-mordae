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


(define-syntax when*
  (syntax-rules ()
    ((_ ((name value) rest ...) body ...)
     (let ((name value))
       (when name
         (when* (rest ...)
           body ...))))

    ((_ ((name : type value) rest ...) body ...)
     (let ((name : type value))
       (when name
         (when* (rest ...)
           body ...))))

    ((_ () : type body ...)
     (ann (begin body ...) type))

    ((_ () body ...)
     (begin body ...))))


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
