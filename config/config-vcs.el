(setq vc-make-backup-files t)

(when (executable-find "git")
  (require-package 'magit)
  (require-package 'forge)

  (defun /vcs/magit-post-display-buffer-hook ()
    (if (string-match "*magit:" (buffer-name))
        (delete-other-windows)))
  (add-hook 'magit-post-display-buffer-hook #'/vcs/magit-post-display-buffer-hook)

  (setq magit-section-show-child-count t)
  (setq magit-diff-arguments '("--histogram"))
  (setq magit-ediff-dwim-show-on-hunks t)
  (setq magit-display-buffer-function #'magit-display-buffer-fullcolumn-most-v1)

  (after 'eshell
    (require-package 'pcmpl-git)
    (require 'pcmpl-git))

  (if (display-graphic-p)
      (progn
        (require-package 'git-gutter-fringe+)
        (require 'git-gutter-fringe+))
    (require-package 'git-gutter+))
  (global-git-gutter+-mode))

(require-package 'diff-hl)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)
(unless (display-graphic-p)
  (diff-hl-margin-mode))
(if (package-installed-p 'magit)
    (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

(require-package 'with-editor)
(autoload 'with-editor-export-editor "with-editor")
(defun /vcs/with-editor-export ()
  (unless (equal (buffer-name) "*fzf*")
    (with-editor-export-editor)
    (message "")))
(add-hook 'shell-mode-hook #'/vcs/with-editor-export)
(add-hook 'term-exec-hook #'/vcs/with-editor-export)
(add-hook 'eshell-mode-hook #'/vcs/with-editor-export)

(/boot/lazy-major-mode "^\\.gitignore$" gitignore-mode)
(/boot/lazy-major-mode "^\\.gitattributes$" gitattributes-mode)

(provide 'config-vcs)  
