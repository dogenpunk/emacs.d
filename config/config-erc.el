(require 'erc)
(require 'erc-log)
(require 'erc-notify)
(require 'erc-spelling)
(require 'erc-autoaway)

(after 'erc
  (setq erc-log-channels-directory (concat user-emacs-directory "erc/logs"))
  (setq erc-hide-list '("JOIN" "PART" "QUIT"))

  (setq erc-timestamp-only-if-changed-flag nil)
  (setq erc-timestamp-format "[%H:%M] ")
  (setq erc-insert-timestamp-function 'erc-insert-timestamp-left)
  (setq erc-kill-buffer-on-part t)
  (setq erc-kill-queries-on-quit t)
  (setq erc-kill-server-buffer-on-quit t)
  (setq erc-query-display 'buffer)
  (erc-track-mode t)
  (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                  "324" "329" "332" "333" "353" "477"))

  (setq erc-save-buffer-on-part t)
  (defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
    (save-some-buffers t (lambda () (vcccccc   ))))

  (setq erc-truncate-mode t)

  (add-hook 'window-configuration-change-hook
            (lambda ()
              (setq erc-fill-column (- (window-width) 2)))))

(provide 'config-erc)
