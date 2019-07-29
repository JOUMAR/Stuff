(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(ac-config-default)
(which-function-mode 1)
(dumb-jump-mode 1)
(setq auth-sources '((:source "~/.authinfo.gpg")))

(setq read-file-name-completion-ignore-case t)
(setq completion-ignored-extensions t)
(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.tt\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(add-to-list 'load-path "/home/moose/lua-mode-master/")

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

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
    (web-mode hl-todo alchemist elixir-yasnippets elixir-mode yasnippet-classic-snippets yasnippet flycheck-color-mode-line flycheck scratch nyan-mode dash dumb-jump highlight-escape-sequences plsense-direx plsense auto-complete auto-overlays json-mode)))
 '(tramp-backup-directory-alist backup-directory-alist nil nil (tramp)))
(nyan-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'json-mode-hook #'flycheck-mode)
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
 )

( tool-bar-mode   0 )
( menu-bar-mode   0 )
( scroll-bar-mode 0 )
( global-hl-line-mode +1 )
( load-theme 'misterioso )
(setq web-mode-enable-current-element-highlight 1)
(setq web-mode-markup-indent-offset 2)

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


(add-hook 'c++-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c o") 'ff-find-other-file ) ) )

(defun insert-snippet-dumper ()
  "Insert snippet and move point."
  (interactive)
  (insert "Panda::Log->error( Dumper  );")
  (backward-char 3))
(global-set-key (kbd "<pause>") 'insert-snippet-dumper)

;(defun insert-snippet-fat-arrow ()
;  "Insert snippet and move point."
;  (interactive)
;  (insert " => ")
;  (backward-char 3))
;(global-set-key (kbd "C-M-,") 'insert-snippet-fat-arrow)

;(defun insert-snippet-arrow ()
;  "Insert snippet and move point."
;  (interactive)
;  (insert "->")
;  (backward-char 3))
;(global-set-key (kbd "C-M-]") 'insert-snippet-fat-arrow)
(global-set-key (kbd "C-z") 'undo)
