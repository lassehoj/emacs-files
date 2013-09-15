;; emacs package manager (package.el)
;;(require 'package)
;;(package-initialize)

;; extra resources for package.el (non-free sources)
;;(add-to-list 'package-archives
;;	     '("marmalade" .  "http://marmalade-repo.org/packages/") t)

;; fix the PATH variable
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(if window-system (set-exec-path-from-shell-PATH))

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))


;; * Scrolling *
(setq scroll-step 1)
(setq scroll-conservatively 1000)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)

(setq mouse-avoidance-mode 'jump)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(agda2-fontset-name "")
 '(agda2-include-dirs (quote ("/Users/lassehoj/daimi/danko/lib-0.6/src" "./")))
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(org-agenda-files (quote ("~/daimi/dIFP/project/report.org" "~/todo.org")))
 '(show-paren-mode t))

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(fset 'yes-or-no-p 'y-or-n-p)     ; use y and n for questions
; (setq visible-bell 1)             ; turn off bip warnings
(setq ring-bell-function 'ignore) ; disable bell completely
; (setq visible-bell 'top-bottom)   ; don't flash entire screen on bell
(iswitchb-mode 1)                 ; better buffer switching


;; coq-mode
(add-to-list 'auto-mode-alist '("\.v$" . coq-mode))
(autoload 'coq-mode "coq" "Major mode for editing Coq vernacular." t)
;; (add-hook 'coq-mode-hook 'pretty-mode) doesn't work

;; proof-general
(load-file "~/.emacs.d/site-lisp/ProofGeneral/generic/proof-site.el")
(require 'proof-site)
(add-hook 'proof-goals-mode-hook
	  (lambda ()
	    (setq proof-eagerly-raise nil)))
(add-hook 'proof-response-mode-hook
	  (lambda ()
	    (setq proof-eagerly-raise nil)))


;; Slime
;;(setq inferior-lisp-program "/usr/bin/clisp")
;;(add-to-list 'load-path "/usr/share/emacs23/site-lisp/slime")
;;(require 'slime)
;;(slime-setup)

;; only scroll one line when reaching bottom/top of screen
(setq scroll-step 1)

;; enable syntax highlighting
(global-font-lock-mode 1)

;; show line numbers in left column
(global-linum-mode t)
;; Offset the number by two spaces to work around some weird fringe glitch
(setq linum-format " %d ")

;; --- LaTeX --- ;;
;; Math mode for LaTex

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(setq reftex-plug-into-AUCTeX t)

; (setq-default TeX-master "master") ; All master files called "master".
; (setq-default TeX-master nil) ; Query for master file.
(setq TeX-PDF-mode t) ; default to pdf in LaTeX mode

;; haskell-mode
;;(load "/usr/share/emacs23/site-lisp/haskell-mode/haskell-site-file")

;; customize haskell-mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; disable toolbar
;;(tool-bar-mode -1)

;; disable menu-bar
;;(menu-bar-mode -1)

;; make ctrl-shift-insert paste from clipboard
;; (global-set-key [(control shift insert)] 'clipboard-yank)


;; nesC mode
;;(load "/usr/share/emacs23/site-lisp/nesc")
;;(autoload 'nesc-mode "nesc.el")
;;(setq auto-mode-alist (cons '("\\.nc" . nesc-mode) auto-mode-alist))

;; fix flyspell problem
;; (setq flyspell-issue-welcome-flag nil)


;; color-scheme
;; (require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-matrix)

(setq scheme-program-name "/usr/bin/petite")
;; (load-file                "C:/path/to/scheme-setup.el")

(add-hook 'inferior-scheme-mode-hook
  (lambda ()
  ;; Overwrite the standard 'switch-to-buffer' to use
  ;; 'switch-to-buffer-other-window'
  (defun switch-to-scheme (eob-p)
    "Switch to the scheme process buffer. With argument, position cursor at end of buffer."
    (interactive "P")
    (if (or (and scheme-buffer (get-buffer scheme-buffer))
            (scheme-interactively-start-process))
        (switch-to-buffer-other-window scheme-buffer)
        (error "No current process buffer.  See variable `scheme-buffer'"))
    (when eob-p
      (push-mark)
      (goto-char (point-max))))))

;; ocaml-mode
(load-file "~/.emacs.d/site-lisp/ocaml.emacs")


;; Org-mode settings
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

;; enable reftex blah
(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation))
(add-hook 'org-mode-hook 'org-mode-reftex-setup)


(global-font-lock-mode 1)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)


(if (string-equal system-type "darwin")
    (set-fontset-font "fontset-default"
                      'unicode
                      '("Monaco" . "iso10646-1")))

(load-theme 'wombat)
(set-face-attribute 'default nil
		    :family "Menlo" :height 120 :weight 'normal)
