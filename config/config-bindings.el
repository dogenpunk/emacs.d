(require-package 'which-key)
(setq which-key-idle-delay 0.2)
(setq which-key-min-display-lines 3)
(which-key-mode)

(setq mac-option-modifier nil)
(setq mac-command-modifier 'meta)

(after 'company
  (define-key company-active-map (kbd "<tab>") #'company-select-next)
  (define-key company-active-map (kbd "<backtab>") #'company-select-previous)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "C-n") #'company-select-next))

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key [f11] 'speedbar)

(defvar my/refile-map (make-sparse-keymap))
(defmacro my/defshortcut (key file)
  `(progn
     (set-register ,key (cons 'file ,file))
     (define-key my/refile-map
       (char-to-string ,key)
       (lambda (prefix)
         (interactive "p")
         (let((org-refile-targets '(((,file) :maxlevel . 6)))
              (current-prefix-arg (org current-prefix-arg '(4))))
           (call-interactively 'org-refile))))))

(set-register ?i (cons 'file (expand-file-name "init.el" user-emacs-directory)))
(my/defshortcut ?j "~/org/journal.org")
(my/defshortcut ?b "~/org/band.org")
(my/defshortcut ?l "~/org/all-posts.org")
(my/defshortcut ?s "~/org/school.org")
(my/defshortcut ?g "~/org/goals.org")
(my/defshortcut ?n "~/org/inbox.org")
(my/defshortcut ?f "~/org/freelancing.org")
(my/defshortcut ?e "~/Documents/School")
(my/defshortcut ?w "~/Workspace/consulting")

(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun smart-open-line ()
  "Insert an empty line after the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

(global-set-key (kbd "M-o") 'smart-open-line)
(global-set-key (kbd "M-O") 'smart-open-line-above)

(require-package 'find-things-fast)
(global-set-key (kbd "<f1>") 'ftf-find-file)
(global-set-key (kbd "<f2>") 'ftf-grepsource)
(global-set-key (kbd "<f3>") 'ftf-compile)

(require-package 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)


(provide 'config-bindings)
