(defcustom dotemacs-os/additional-exec-paths
  nil
  "Additional paths to be added to `exec-path'."
  :type '(repeat (string))
  :group 'dotemacs)

(require-package 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(defun /os/addpath (patth)
  (let* ((directory (expand-file-name path))
	 (env-value (concat directory path-separator (getenv "PATH"))))
    (when directory
      (setenv "PATH" env-value)
      (setq eshell-path-env env-value)
      (add-to-list 'exec-path directory))))

(dolist (path dotemacs-os/additional-exec-paths)
  (/os/addpath path))

(when (eq system-type 'darwin)
  (require-package 'osx-trash)
  (osx-trash-setup)

  (require-package 'reveal-in-osx-finder))

(defun /os/reveal-in-os ()
  (interactive)
  (call-interactively #'reveal-in-osx-finder))

(provide 'config-os)
