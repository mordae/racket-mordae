#lang typed/racket/base
;
; Additional Match Expanders
;

(require racket/match
         racket/function)

(require
  (for-syntax racket/base
              syntax/parse))

(provide hash-lookup
         regexp-parts)


(define-match-expander hash-lookup
  (syntax-parser
    ((_ (k v) ...)
     #`(and (? hash?)
            (and #,@#'((app (λ (ht) (hash-ref ht k #f))
                            (and (? identity) v)) ...))))))


(define-match-expander regexp-parts
  (syntax-parser
    ((_ rx (part ...))
     #`(regexp rx (list (? values part) ...)))))


; vim:set ts=2 sw=2 et:
