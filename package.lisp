;;;; package.lisp

(defpackage #:stringcase
  (:use #:cl)
  (:import-from #:alexandria #:with-gensyms)
  (:export #:stringcase #:cstringcase #:estringcase))

