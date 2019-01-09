(require-package 'company)

(setq company-idle-delay 0.3)
(setq company-minimum-prefix-length 1)
(setq company-show-numbers t)
(setq company-tooltip-limit 20)

(setq company-dabbrev-downcase nil)
(setq company-dabbrev-ignore-case t)

(setq company-dabbrev-code-everywhere t)
(setq company-dabbrev-code-ignore-case t)

(setq company-etags-ignore-case t)

(setq company-global-modes
      '(not
        eshell-mode comint-mode text-mode erc-mode))

(global-company-mode)

(unless (face-attribute 'company-tooltip :background)
    (set-face-attribute 'company-tooltip nil :background "black" :foreground "gray40")
    (set-face-attribute 'company-tooltip-selection nil :inherit 'company-tooltip :background "gray15")
    (set-face-attribute 'company-preview nil :background "black")
    (set-face-attribute 'company-preview-common nil :inherit 'company-preview :foreground "gray40")
    (set-face-attribute 'company-scrollbar-bg nil :inherit 'company-tooltip :background "gray20")
    (set-face-attribute 'company-scrollbar-fg nil :background "gray40"))

(provide 'config-company)
