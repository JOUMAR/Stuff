;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(ac-config-default)
(which-function-mode 1)

(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.\\([tT]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

;; Use 4 space indents via cperl mode
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cperl-close-paren-offset -4)
 '(cperl-continued-statement-offset 4)
 '(cperl-indent-level 4)
 '(cperl-indent-parens-as-block t)
 '(cperl-tab-always-indent t)
 '(package-selected-packages
   (quote
    (highlight-escape-sequences plsense-direx plsense auto-complete auto-overlays json-mode)))
 '(tramp-backup-directory-alist backup-directory-alist nil nil (tramp)))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq-default indent-tabs-mode nil)

;;(setq tab-width 4)

(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                          64 68 72 76 80 84 88 92 96 100 104 108 112
                          116 120))

(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

(setq highlight-tabs t)
(setq highlight-trailing-whitespace t)

(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))



(global-set-key (kbd "C-x C-t") 'tidy-check)
(global-set-key (kbd "M-s") 'isearch-forward-symbol-at-point)
( defun tidy-check ()
  "Check syntax via PerlTidy"
  (interactive)
;  (shell-command "cd /home/git/regentmarkets/bom-rpc/ && make tidy %s"
  (shell-command
   (format "cat %s"
           (shell-quote-argument (buffer-file-name)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
