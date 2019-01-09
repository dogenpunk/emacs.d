(load-file (expand-file-name "./elisp/robot-mode.el" user-emacs-directory))
(add-to-list 'auto-mode-alist '("\\.robot\\'" . robot-mode))

(provide 'config-robot)
