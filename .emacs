(custom-set-variables
;;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruvbox-dark-medium))
 '(custom-safe-themes
   '("72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" default))
 '(inhibit-startup-screen t)
 '(package-selected-packages '(gruvbox-theme)))
65;7006;1c
(column-number-mode 1)
(show-paren-mode 1)

(defun compilation-functions (arg)
  (interactive "p")
  (compile "make -k") 
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
(global-set-key (kbd "C-x m") 'compilation-functions)
(global-set-key (kbd "M-a") 'select-block)
(global-set-key (kbd "C-x C-c") 'close-binding)
