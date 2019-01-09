(require-package 'ediprolog)

(setq prolog-system 'swi)
(setq prolog-electric-if-then-else-flag t)
(global-set-key (kbd "<f10>") 'ediprolog-dwim)

(provide 'config-prolog)
