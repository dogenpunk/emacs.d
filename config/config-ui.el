(line-number-mode t)
(column-number-mode t)
(display-time-mode t)
(size-indication-mode t)

(require-package 'origami)
(global-origami-mode)

(require-package 'diminish)
(diminish 'visual-line-mode)
(after 'aggressive-indent (diminish 'aggressive-indent-mode))
(after 'autorevert (diminish #'auto-revert-mode))
(after 'company (diminish 'company-mode))
(after 'counsel (diminish #'counsel-mode))
(after 'eldoc (diminish 'eldoc-mode))
(after 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(after 'flycheck (diminish 'flycheck-mode))
(after 'ivy (diminish 'ivy-mode))
(after 'smartparens (diminish 'smartparens-mode))
(after 'which-key (diminish 'which-key-mode))
(after 'highlight-symbol (diminish 'highlight-symbol-mode))

(require-package 'smart-mode-line)
(sml/setup)

(when (and (display-graphic-p)
           (font-info "all-the-icons"))
  (setq all-the-icons-scale-factor 0.7)
  (setq inhibit-compacting-font-caches t)

  (after 'dired
    (require-package 'all-the-icons-dired)
    (add-hook 'dired-mode-hook #'all-the-icons-dired-mode))

  (after 'ivy
    (require-package 'all-the-icons-ivy)
    (all-the-icons-ivy-setup)))

(add-hook 'find-file-hook #'hl-line-mode)

(winner-mode t)
(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(require-package 'highlight-symbol)
(setq highlight-symbol-idle-delay 0.3)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)

(require-package 'highlight-quoted)
(add-hook 'prog-mode-hook 'highlight-quoted-mode)

;; Themes
;; https://www.greghendershott.com/2017/02/emacs-themes.html
(defvar /config/theme-hooks nil
  "((theme-id . function) ...)")

(defun /config/add-theme-hook (theme-id hook-fn)
  (add-to-list '/config/theme-hooks (cons theme-id hook-fn)))

(defun /config/disable-themes ()
  (interactive)
  (mapc #'disable-theme custom-enabled-themes))

(defun /config/load-theme-advice (f theme-id &optional no-confirm no-enable &rest args)
  "Enhances `load-theme' in two ways:
1. Disables enabled themes for a clean slate.
2. Calls functions registered using `/config/add-theme-hook'."
  (unless no-enable
    (/config/disable-themes))
  (prog1
      (apply f theme-id no-confirm no-enable args)
    (unless no-enable
      (pcase (assq theme-id /config/theme-hooks)
        (`(,_ . ,f) (funcall f))))))

(advice-add 'load-theme
            :around
            #'/config/load-theme-advice)

(load-theme 'gruvbox-dark-hard)
;;
(require-package 'beacon)
(setq beacon-blink-when-buffer-changes t)
(setq beacon-blink-when-window-scrolls t)
(setq beacon-blink-when-window-changes t)
(setq beacon-blink-when-focused t)

(setq beacon-blink-duration 0.3)
(setq beacon-blink-delay 0.3)
(setq beacon-size 20)
(setq beacon-color "yellow")

(add-to-list 'beacon-dont-blink-major-modes 'term-mode)
(beacon-mode 1)

;; Dashboard
(require-package 'dashboard)
(require 'dashboard)
(dashboard-setup-startup-hook)

(setq dashboard-iems '((recents . 5)
                       (bookmarks . 5)
                       (projects . 5)
                       (agenda . 5)
                       (registers . 5)))

(provide 'config-ui)
