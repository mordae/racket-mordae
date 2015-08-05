#lang typed/racket/base
;
; Additional Match Expanders
;

(require racket/match
         racket/function)

(require
  (for-syntax racket/base
              syntax/parse))

(provide hash-lookup)


(define-match-expander hash-lookup
  (syntax-parser
    ((_ (k v) ...)
     #`(and (? hash?)
            (and #,@#'((app (λ (ht) (hash-ref ht k #f))
                            (and (? identity) v)) ...))))))


; vim:set ts=2 sw=2 et:
