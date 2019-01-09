(require 'server)
(unless (server-running-p)
  (server-start))

(require 'recentf)
(setq recentf-save-file (concat user-emacs-directory "recentf"))
(setq recentf-max-saved-items 1000)
(setq recentf-max-menu-items 500)
(setq recentf-auto-cleanup 300)
(add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")
(add-to-list 'recentf-exclude ".*elpa.*autoloads\.el$")
(recentf-mode t)
(run-with-idle-timer 600 t #'recentf-save-list)

;; GC
(defun /core/minibuffer-setup-hook () (setq gc-cons-threshold most-positive-fixnum))
(defun /core/minibuffer-exit-hook () (setq gc-cons-threshold (* 64 1024 1024)))
(add-hook 'minibuffer-setup-hook #'/core/minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'/core/minibuffer-exit-hook)

;; pcomplete
(setq pcomplete-ignore-case t)

;; imenu
(setq-default imenu-auto-rescan t)

;; narrowing
(put 'narrow-to-region 'disabled nil)

;; dired
(after 'dired
  (require 'dired-x))

(setq insert-directory-program "gls")
(setq dired-use-ls-dired t)

;; comint
(after 'comint
  (defun /core/toggle-comint-scroll-to-bottom-on-output ()
    (interactive)
    (if comint-scroll-to-bottom-on-output
	(setq comint-scroll-to-bottom-on-output nil)
      (setq comint-scroll-to-bottom-on-output t))))

;; compile
(setq compilation-always-kill t)
(setq compilation-ask-about-save nil)
(add-hook 'compilation-filter-hook
	  (lambda ()
	    (when (eq major-mode 'compilation-mode)
	      (require 'ansi-color)
	      (let ((inhibit-read-only t))
		(ansi-color-apply-on-region (point-min) (point-max))))))

;; bookmarks
(setq bookmark-default-file (concat user-emacs-directory "bookmarks"))
(setq bookmark-save-flag 1)

;; ediff
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; re-builder
(setq reb-re-syntax 'string)

;; clean up old buffers periodically
(midnight-mode)
(midnight-delay-set 'midnight-delay 0)

;; ibuffer
(setq ibuffer-expert nil)
(setq ibuffer-show-empty-filter-groups t)
(add-hook 'ibuffer-mode-hook #'ibuffer-auto-mode)

;; auto-save
(let ((dir (expand-file-name (concat user-emacs-directory "auto-save/"))))
  (setq auto-save-list-file-prefix (concat dir "saves-"))
  (setq auto-save-file-name-transforms `((".*" ,(concat dir "save-") t))))

;; backups
(setq backup-directory-alist `((".*" . ,(expand-file-name (concat user-emacs-directory "backups/")))))
(setq backup-by-copying t)
(setq version-control t)
(setq kept-old-versions 1000)
(setq kept-new-versions 50)
(setq delete-old-versions t)

;; scrolling
(setq scroll-conservatively 9999
      scroll-perserve-screen-position t
      scroll-margin 3)

;; unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/"
      uniquify-ignore-buffers-re "^\\*"
      uniquify-after-fill-buffer-p t)

(defun /core/do-not-kill-scratch-buffer ()
  (if (member (buffer-name (current-buffer))
	      '("*scratch*" "*Messages*" "*Require Times*"))
      (progn
	(bury-buffer)
	nil)
    t))
(add-hook 'kill-buffer-query-functions '/core/do-not-kill-scratch-buffer)

(defalias 'yes-or-no-p 'y-or-n-p)

(let ((coding 'utf-8-unix))
  (setq locale-coding-system coding)
  (set-selection-coding-system coding)
  (set-default-coding-systems coding)
  (prefer-coding-system coding)
  (setq-default buffer-file-coding-system coding))
(set-language-environment "UTF-8")

(setq sentence-end-double-space nil)
(setq delete-by-moving-to-trash t)
(setq ring-bell-function 'ignore)
(setq mark-ring-max 64)
(setq global-mark-ring-max 128)
(setq save-interprogram-paste-before-kill t)
(setq create-lockfiles nil)
(setq echo-keystrokes 0.01)
(setq initial-majore-mode 'emacs-lisp-mode)
(setq eval-expression-print-level nil)
(setq-default indent-tabs-mode nil)

(setq inhibit-spash-screen t)
(setq inhibit-startup-echo-area-message t)

(global-visual-line-mode)
(which-function-mode t)
(blink-cursor-mode -1)
(global-auto-revert-mode t)
(electric-indent-mode t)
(transient-mark-mode t)
(delete-selection-mode t)
(random t)

(defun /core/find-file-hook ()
  (when (string-match "\\.min\\." (buffer-file-name))
    (fundamental-mode)))
(add-hook 'find-file-hook #'/core/find-file-hook)

(require 'elisp-demos)
(advice-add 'describe-function-1 :after #'elisp-demos-advice-describe-function-1)

(provide 'config-core)
