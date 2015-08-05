#lang typed/racket/base
;
; Asynchronous Tasks
;

(require mordae/syntax)

(provide
  (all-defined-out))


(struct (a) async-task
  ((thread : Thread)
   (evt    : (Evtof a))))


(: make-async-task (All (a) (-> (-> a) (async-task a))))
(define (make-async-task proc)
  (let* ((channel ((inst make-channel a)))
         (thread  (thread (λ ()
                            (channel-put channel (proc))))))
    (async-task thread channel)))

(: make-async-task/loop (All (a) (-> (-> a) (async-task a))))
(define (make-async-task/loop proc)
  (let* ((channel ((inst make-channel a)))
         (thread  (thread (λ ()
                            (loop
                              (channel-put channel (proc)))))))
    (async-task thread channel)))


(define-syntax async
  (syntax-rules (:)
    ((_ : type body ...)
     ((inst make-async-task type) (λ () : type body ...)))

    ((_ body ...)
     (make-async-task (λ () body ...)))))

(define-syntax async/loop
  (syntax-rules (:)
    ((_ : type body ...)
     ((inst make-async-task/loop type) (λ () : type body ...)))

    ((_ body ...)
     (make-async-task/loop (λ () body ...)))))


; vim:set ts=2 sw=2 et:
