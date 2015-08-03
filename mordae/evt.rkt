#lang typed/racket/base
;
; Specialized Events
;

(provide
  (all-defined-out))


(: constant-evt (All (a) (-> a (Evtof a))))
(define (constant-evt value)
  (wrap-evt always-evt (λ _ value)))


; vim:set ts=2 sw=2 et:
