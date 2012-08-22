(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t))
 
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

;; load things from ~/.emacs.d/site-lisp
(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; slime
(setq inferior-lisp-program "/usr/bin/clisp")
(add-to-list 'load-path "/usr/share/emacs23/site-lisp/slime")
(require 'slime)
(slime-setup)

;; only scroll one line when reaching bottom/top of screen
(setq scroll-step 1)

;; enable syntax highlighting
(global-font-lock-mode 1)

;; show line numbers in left column
(global-linum-mode t)

;; show a space after the line numbers to seperate them from the content of the file
(setq linum-format "%d ")

;; --- LaTeX --- ;;
;; Math mode for LaTex
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(setq-default TeX-master "master") ; All master files called "master".
; (setq-default TeX-master nil) ; Query for master file.
(setq TeX-PDF-mode t) ; default to pdf in LaTeX mode


;; haskell-mode
(load "/usr/share/emacs23/site-lisp/haskell-mode/haskell-site-file")

;; customize haskell-mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; disable toolbar
(tool-bar-mode -1)

;; disable menu-bar
(menu-bar-mode -1)

;; make ctrl-shift-insert paste from clipboard
(global-set-key [(control shift insert)] 'clipboard-yank)


;; nesC mode
(load "/usr/share/emacs23/site-lisp/nesc")
(autoload 'nesc-mode "nesc.el")
(setq auto-mode-alist (cons '("\\.nc" . nesc-mode) auto-mode-alist))

;; fix flyspell problem
(setq flyspell-issue-welcome-flag nil)


;; color-scheme
(require 'color-theme)
(color-theme-initialize)
(color-theme-matrix)