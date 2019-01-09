(require-package 'clojure-mode)

(add-hook 'clojure-mode-hook
          (lambda ()
            (require-package 'cider)
            (cider-mode t)
            (local-set-key (kbd "RET") 'newline-and-indent)))

(after [cider]
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-repl-mode-hook #'enable-paredit-mode)
  (add-hook 'cider-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'enable-paredit-mode))

(global-set-key [f9] 'cider-jack-in)
