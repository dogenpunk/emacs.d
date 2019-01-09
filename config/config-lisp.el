(require-package 'elisp-slime-nav)
(after 'elisp-slime-nav
  (defadvice elisp-slime-nav-find-elisp-thing-at-point (after dotemacs activate)
    (recenter)))

(require-package 'paredit)

(defun /lisp/major-mode-hook ()
  (progn
    (elisp-slime-nav-mode)
    (eldoc-mode)
    (paredit-mode t)))

(add-hook 'emacs-lisp-mode-hook #'/lisp/major-mode-hook)
(add-hook 'lisp-interaction-mode-hook #'/lisp/major-mode-hook)
(add-hook 'ielm-mode-hook #'/lisp/major-mode-hook)

(provide 'config-lisp)
