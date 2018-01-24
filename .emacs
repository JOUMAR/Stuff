(package-initialize)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(ac-config-default)
;;(which-function-mode 1)

(setq read-file-name-completion-ignore-case t)
(setq completion-ignored-extensions t)
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
 '(package-selected-packages (quote (json-mode auto-complete)))
 '(which-function-mode t))

(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; Use 4 space indents via cperl mode

(show-paren-mode t) ;; включить выделение выражений между {},[],()
;;(setq show-paren-style 'expression) ;; выделить цветом выражения между {},[],()
(setq show-paren-delay 0)
;;(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
;;                          64 68 72 76 80 84 88 92 96 100 104 108 112
;;                          116 120))

(setq-default indent-tabs-mode nil)

(setq tab-width 4)

;;(defvaralias 'c-basic-offset 'tab-width)
;;(defvaralias 'cperl-indent-level 'tab-width)

(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

(setq highlight-tabs t)
(require 'which-func)
(add-to-list 'which-func-modes 'org-mode)
(which-func-mode 1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(which-func ((t (:foreground "dark red")))))

( tool-bar-mode 0 )
( global-hl-line-mode +1 )
( load-theme 'misterioso )

;;(custom-set-variables
;; '(cperl-close-paren-offset -4)
;; '(cperl-continued-statement-offset 4)
;; '(cperl-indent-level 4)
;; '(cperl-indent-parens-as-block t)
;; '(cperl-tab-always-indent t)
;; '(package-selected-packages
;;   (quote
;;    (highlight-escape-sequences plsense-direx plsense auto-complete auto-overlays json-mode)))
;; '(tramp-backup-directory-alist backup-directory-alist nil nil (tramp)))

(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))

;(global-set-key (kbd "C-x C-t") 'tidy-check)
(global-set-key (kbd "M-s") 'isearch-forward-symbol-at-point)
;( defun tidy-check ()
;  "Check syntax via PerlTidy"
;  (interactive)
;  (shell-command "cd /home/git/regentmarkets/bom-rpc/ && make tidy %s"
;  (shell-command
;   (format "cat %s"
;           (shell-quote-argument (buffer-file-name)))))

