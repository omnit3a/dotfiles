
(define-generic-mode presley-mode
  nil
  (list "def-func" "let" "lambda")
  '(("true" . 'font-lock-constant-face)
    ("false" . 'font-lock-constant-face))
  (list "\\.pre$")
  nil
  "Major mode for presley source files.")