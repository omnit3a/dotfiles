(load-file "~/.emacs.d/highlight-indent-guides.el")
(load-file "~/.emacs.d/column-enforce-mode.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruvbox-dark-medium))
 '(custom-safe-themes
   '("72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" default))
 '(highlight-indent-guides-character 124)
 '(highlight-indent-guides-method 'character)
 '(inhibit-startup-screen t)
 '(package-selected-packages '(gruvbox-theme)))

(setq line-number-mode t)
(setq show-paren-mode t)

(require 'highlight-indent-guides)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(require 'column-enforce-mode)
(global-column-enforce-mode t)
(setq column-enforce-comments nil)
(setq column-enforce-column 60)

(defun compile-search (command)
  "Traveling up the path, find a Makefile and `compile'."
  (interactive)
  (when (locate-dominating-file default-directory "Makefile")
  (with-temp-buffer
    (cd (locate-dominating-file default-directory "Makefile"))
    (compile command))))

(defun compilation-function (arg)
  (interactive "p")
  (compile-search "make -k") 
  )

(defun run-function (arg)
  (interactive "p")
  (compile-search "make run")
  )

(defun select-block (arg)
  (interactive "p")
  (mark-paragraph)
  )

(setq special-display-buffer-names
      '("*compilation*")
      )

(setq special-display-function
      (lambda (buffer &optional args)
	(switch-to-buffer buffer)
	(get-buffer-window buffer 0)
	)
      )

(defun close-binding (arg)
  (interactive "p")
  (if (get-buffer "*compilation*")
      (kill-buffer "*compilation*")
      (save-buffers-kill-emacs)
    )
    
  )

(setq c-default-style "linux")

(global-set-key (kbd "C-y") 'kill-ring-save)
(global-set-key (kbd "C-p") 'yank)
(global-set-key (kbd "C-g") 'goto-line)
(global-set-key (kbd "C-x m") 'compilation-function)
(global-set-key (kbd "C-x r") 'run-function)
(global-set-key (kbd "M-a") 'select-block)
(global-set-key (kbd "C-x C-c") 'close-binding)

(setq make-backup-files nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
