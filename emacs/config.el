;; Setup MELPA
(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Splash Screen
(defun splash-screen-hook ()
  (print command-line-args)
  (when (= 1 (length command-line-args))
    (setq initial-buffer-choice
	  "~/.emacs.d/start.org")))
(add-hook
 'after-init-hook
 'splash-screen-hook)

;; Load Packages
(require 'org-modern)
(require 'goto-line-preview)
(require 'haskell-mode)

;; Disable some GUI stuff
(setq scroll-bar-mode nil)
(setq tooltip-mode nil)
(setq menu-bar-mode nil)
(setq tool-bar-mode nil)

;; Load Theme
(load-theme 'gruvbox-dark-medium t)

;; Cursor Related Stuff
(setq shift-select-mode t)
(setq blink-cursor-mode nil)

;; Line Numbers
(add-hook
 'prog-mode-hook
 'display-line-numbers-mode)
(setq line-number-mode t)
(setq display-line-numbers-type 'relative)

(defun goto-line-relative (arg)
  (interactive "p")
  (setq line-goto (read-number "Jump to line: "))
  (if (< line-goto 0)
      (previous-line (* line-goto -1))
    (next-line line-goto)))

(global-set-key (kbd "C-g") 'goto-line-preview)
(global-set-key (kbd "C-x g") 'goto-line-relative)

;; Column Numbers
(setq column-number-mode t)

;; Parentheses Related Stuff
(setq show-paren-mode t)
(electric-pair-mode 1)

;; Org-mode
(with-eval-after-load "org"
  (define-key
    org-mode-map
    (kbd "M-a")
    #'org-open-at-point))
(setq org-support-shift-select t)

;; Compilation Functions
(defun compile-search (command)
  (interactive)
  (when (locate-dominating-file
	 default-directory
	 "Makefile")
    (with-temp-buffer
      (cd (locate-dominating-file
	   default-directory
	   "Makefile"))
      (compile command))))

(defun compilation-function (arg)
  (interactive "p")
  (compile-search "make -k"))

(setq special-display-buffer-names
      '("*compilation*"))

(setq special-display-function
      (lambda (buffer &optional args)
	(switch-to-buffer buffer)
	(get-buffer-window buffer 0)))

(defun close-binding (arg)
  (interactive "p")
  (if (get-buffer "*compilation*")
      (kill-buffer "*compilation*")
    (save-buffers-kill-emacs)))

(global-set-key (kbd "C-x m") 'compilation-function)
(global-set-key (kbd "C-x C-c") 'close-binding)

;; Prettify Symbols
(add-hook
 'prog-mode-hook
 (lambda ()
   (push '(">=" . "≥") prettify-symbols-alist)
   (push '("<=" . "≤") prettify-symbols-alist)
   (push '("!=" . "≠") prettify-symbols-alist)
   (push '("<<" . "«") prettify-symbols-alist)
   (push '(">>" . "»") prettify-symbols-alist)
   (push '("->" . "→") prettify-symbols-alist)
   (push '("<-" . "←") prettify-symbols-alist)
   (push '("::" . "∷") prettify-symbols-alist)))
(global-prettify-symbols-mode +1)

;; C Programming Stuff
(setq c-default-style "linux")

;; Keybindings
(global-set-key (kbd "C-y") 'kill-ring-save)
(global-set-key (kbd "C-p") 'yank)

;; Misc Config
(setq make-backup-files nil)
