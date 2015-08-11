#lang typed/racket/base
;
; Additional Match Expanders
;

(require racket/match)

(require
  (for-syntax racket/base
              syntax/parse))

(provide hash-lookup
         regexp-parts)


(define-match-expander hash-lookup
  (syntax-parser
    ((_ (k v) ...)
     #`(and (? hash?)
            (and #,@#'((app (λ (ht)
                              (and (hash-has-key? ht k)
                                   (box (hash-ref ht k))))
                            (? values (app unbox v))) ...))))))


(define-match-expander regexp-parts
  (syntax-parser
    ((_ rx (part ...))
     #`(regexp rx (list (? values part) ...)))))


; vim:set ts=2 sw=2 et:
