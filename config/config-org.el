(after 'org
  (unless (file-exists-p org-directory)
    (make-directory org-directory))

  (setq org-default-notes-file (expand-file-name (concat org-directory "/inbox.org")))
  (setq org-log-done t)
  (setq org-log-into-drawer t)

  (setq org-startup-indented t)
  (setq org-src-fontify-natively t)

  (setq org-agenda-files `(,org-directory))
  (setq org-use-fast-todo-selection t)
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)

  (setq org-refile-targets '((nil :maxlevel . 9)
                             (org-agenda-files :maxlevel . 9)))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)

  (when (boundp 'org-plantuml-jar-path)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((plantuml . t))))

  (add-hook 'org-babel-after-execute-hook #'org-redisplay-inline-images)

  (defun /org/org-mode-hook ()
    (toggle-truncate-lines t)
    (setq show-trailing-whitespace t))
  (add-hook 'org-mode-hook #'/org/org-mode-hook)

  (require-package 'ob-async)
  (require 'ob-async)

  (require-package 'org-bullets)
  (add-hook 'org-mode-hook #'org-bullets-mode))

(provide 'config-org)
