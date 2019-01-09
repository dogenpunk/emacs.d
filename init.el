(eval-when-compile (require 'cl))

(lexical-let ((emacs-start-time (current-time)))
	     (add-hook 'emacs-startup-hook
		       (lambda ()
			 (let ((elapsed (float-time (time-subtract (current-time) emacs-start-time))))
			   (message "[Emacs initialized in %.3fs]" elapsed)))))

(let ((gc-cons-threshold (* 256 1024 1024))
      (file-name-handler-alist nil)
      (core-directory (concat user-emacs-directory "core/"))
      (config-directory (concat user-emacs-directory "config/")))

  (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  (when (display-graphic-p) (menu-bar-mode -1))

  (defcustom dotemacs-globally-ignored-directories
    '("elpa" ".cache" "target" "dist" "node_modules" ".git" ".hg" ".svn" ".idea")
    "A set of default directories to ignore for anything that involves searching."
    :type '(repeat string)
    :group 'dotemacs)

  (require 'gnutls)
  (add-to-list 'gnutls-trustfiles "/usr/local/etc/openssl/cert.pem")

  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
			   ("org"   . "https://orgmode.org/elpa/")
			   ("gnu"   . "https://elpa.gnu.org/packages/")))
  (setq package-enable-at-startup nil)
  (package-initialize)

  (load (concat core-directory "core-boot"))
  (setq custom-file (concat user-emacs-directory "custom.el"))
  (when (file-exists-p custom-file)
    (load custom-file))

  (cl-loop for file in (reverse (directory-files-recursively config-directory "\\.el$"))
	   do (condition-case ex
		  (load (file-name-sans-extension file))
		('error (with-current-buffer "*scratch*"
			  (insert (format "[INIT ERROR]\n%s\n%s\n\n" file ex)))))))
