(require-package 'projectile)

(setq projectile-cache-file (concat user-emacs-directory "projectile.cache"))
(setq projectile-known-projects-file (concat user-emacs-directory "projectile-bookmarks.eld"))
(setq projectile-indexing-method 'alien)
(setq projectile-enable-caching t)

;;(setq projectile-completion-system 'ido)


(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(dolist (dir dotemacs-globally-ignored-directories)
  (add-to-list 'projectile-globally-ignored-directories dir))

(cond
 ((executable-find "ag")
  (setq projectile-generic-command
        (concat "ag -0 -l --nocolor"
                (mapconcat #'identity (cons "" projectile-globally-ignored-directories) " --ignore-dir="))))
 ((executable-find "ack")
  (setq projectile-generic-command
        (concat "ack -f --print0"
                (mapconcat #'identity (cons "" projectile-globally-ignored-directories) " --ignore-dir=")))))


(provide 'config-projectile)
