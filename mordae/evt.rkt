#lang typed/racket/base
;
; Specialized Events
;

(require mordae/syntax
         mordae/async)

(provide
  (all-defined-out))


(: constant-evt (All (a) (-> a (Evtof a))))
(define (constant-evt value)
  (wrap-evt always-evt (λ _ value)))


(: recurring-alarm-evt (-> Real (Evtof Real)))
(define (recurring-alarm-evt interval)
  (async-task-evt
    (let* ((start (current-inexact-milliseconds))
           (next (+ start interval)))
      (async/loop
        (sync/enable-break
          (wrap-evt (alarm-evt next)
                    (λ (alarm)
                      (begin0
                        next
                        (set! next (+ next interval))))))))))


; vim:set ts=2 sw=2 et:
