(when (or (executable-find "aspell")
          (executable-find "ispell")
          (executable-find "hunspell"))
  (eval-when-compile (require 'cl))
  (add-hook 'after-change-major-mode-hook
            (lambda ()
              (when (cl-find-if #'derived-mode-p '(text-mode org-mode))
                (turn-on-flyspell)))))

(provide 'config-spelling)
