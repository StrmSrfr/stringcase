;;;; stringcase.lisp

(in-package #:stringcase)

(defun normalize-clauses (clauses)
  (when clauses
    (cons (etypecase (caar clauses)
            ((or list (member t otherwise))
             (car clauses))
            (string
             (cons (list (caar clauses)) (cdar clauses))))
          (normalize-clauses (cdr clauses)))))

(defmacro estringcase (keyform &body clauses)
  (let ((clauses (normalize-clauses clauses)))
    (with-gensyms (key)
      `(let ((,key ,keyform))
         (cond
           ,@(mapcar (lambda (clause)
                       `((or ,@(mapcar (lambda (string)
                                         `(string= ,string ,key))
                                       (car clause)))
                         ,@(cdr clause)))
                     clauses)
           (t
            (error 'type-error
                   :datum ,key
                   :expected-type '(or ,@(mapcar (lambda (keys)
                                                  `(member ,@keys))
                                                clauses)))))))))
          

