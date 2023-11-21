
(define-generic-mode presley-mode
  (list ?#)
  (list "def-func" "let" "lambda")
  '(("true" . 'font-lock-constant-face)
    ("false" . 'font-lock-constant-face))
  (list "\\.pre$")
  nil
  "Major mode for presley source files.")
