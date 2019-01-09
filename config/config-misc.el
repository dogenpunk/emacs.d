(require-package 'pcache)
(setq pcache-directory (concat user-emacs-directory "pcache/"))

(require-package 'request)
(setq request-storage-directory (concat user-emacs-directory "request/"))

(require-package 'wgrep)
(when (executable-find "ag")
  (require-package 'ag)
  (setq ag-highlight-search t)
  (setq ag-ignore-list dotemacs-globally-ignored-directories)
  (add-hook 'ag-mode-hook (lambda () (toggle-truncate-lines t)))
  (require-package 'wgrep-ag))

(require-package 'popwin)
(require 'popwin)
(popwin-mode)

(require-package 'aggressive-indent)
(require 'aggressive-indent)
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'lisp-mode-hook #'aggressive-indent-mode)

(require-package 'browse-kill-ring)

(provide 'config-misc)
