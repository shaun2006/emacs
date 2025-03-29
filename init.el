;; Don't show the splash screen
;(setq inhibit-startup-message t)  ; Comment at end of line
; Turn off some unneeded UI elements
(menu-bar-mode -1)  ; Leave this one on if you're a beginner!
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10) ; gives some breating room
;;(set-frame-font "Times New Roman 14" nil t) ; setup emacs font
;; remove the side browders
(set-fringe-mode 0)

;; shows time 
(setq display-time-format "%I:%M:%S")
(setq display-time-interval 1) 
(display-time-mode)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)

;; Load the emacs default theme
;;(load-theme 'deeper-blue t)
;;(load-theme 'tango-dark t)

(defun close-all-buffers ()
(interactive)
  (mapc 'kill-buffer (buffer-list)))


;; Initialize package sources
(require 'package)
(add-to-list 'package-archives '("gnu-devel" . "https://elpa.gnu.org/devel/"))

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa"
                         . "https://elpa.gnu.org/packages/")))


(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;;EMACS X WINDOW MANAGER
;(use-package exwm)
;(require 'exwm)
;(require 'exwm-config)
;(exwm-config-default)
;(require 'exwm-randr)
;;(setq exwn-randr-workspace-output-plist (0) DisplayPort-0" 1 "DisplayPort-1" 2 "HEMI-A-01))
;(setq exwm-randr-workspace-output-plist '(0 "HDMI-1"))
;(add-hook 'exwm-randr-screen-change-hook
;	  (lambda ()
;	    (start-process-shell-command
;;"xrandr" nil "xrandr -output DisplayPort-0-mode 1920x1080-pos 0x0-rotate normal-output DisplayPort-1-primary-mode 1920x1080-po 1920x0 -rotate normal output HDMI-A-0-mode 1920x1080-pos 3840x0-rotate normal")))
;	     "xrandr" nil "xrandr --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal")))
;(exwm-randr-enable)
;(require 'exwm-systemtray)
;(exwm-systemtray-enable)
;;Some functionality uses this to identify you, e.g. GPG configuration, etail
;;clients, file templates and snippets.
;;(setq user-full-name "username"
;;      user-mail-address "emai")



(use-package command-log-mode)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))


(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;;disable line numbers in surtten programs
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; give nice baw bellow
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; gives C-x hints
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.1))


;; gives code hints
;;(use-package company
;;  :ensure t
;;  :config
 ;; (progn
;;    (add-hook 'after-init-hook 'global-company-mode)))



(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))



;; ivrich
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; dont know :)
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("c-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; don't start serarch with ^


;; shows help about packages C-h v
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-key]      . helpful-key)
  ([remap describe-command]  . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-function] . counsel-describe-function))



;; loads the doom emacs themese from github
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-badger") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


;; loads all the icons needed by emacs
(use-package all-the-icons)

(when (display-graphic-p)
  (require 'all-the-icons))


;; show the tree view
(use-package neotree)


;; use key bindings
(use-package general)
  (general-define-key
   "C-M-j" 'counsel-switch-buffer
   "C-x C-r" 'recently-show)


;; Haskell packages
;;(use-package company-ghci)
;;(use-package ghci-completion)
(use-package haskell-mode)



;; python ide
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

;; html ide

;; code hints
(use-package eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs
	       '(python-mode . ("pylsp"))
	       '(haskell-mode . ("haskell-language-server-wrapper" "--lsp"))
;;	       '(LaTeX-mode-hook . ("texlab"))
	       )
  
  (setq-default eglot-workspace-configuration
                '((:pylsp . (:configurationSources ["flake8"] :plugins (:pycodestyle (:enabled nil) :mccabe (:enabled nil) :flake8 (:enabled t))))))

  :hook
  ((python-mode  . eglot-ensure)
   (haskell-mode . eglot-ensure)
;;   (LaTeX-mode-hook . eglot-ensure)
   ))

;;(setq lsp-LaTeX-server 'texlab)
(add-hook 'LaTeX-mode-hook #'eglot-ensure)

(use-package envrc
  :config
  (envrc-global-mode +1))

(use-package eglot
  :config
  (add-hook 'haskell-mode-hook #'eglot-ensure)
  ;; Optionally add keybindings to some common functions:
  :bind ((:map eglot-mode-map
               ("C-c C-e r" . eglot-rename)
               ("C-c C-e l" . flymake-show-buffer-diagnostics)
               ("C-c C-e p" . flymake-show-project-diagnostics)
               ("C-c C-e C" . eglot-show-workspace-configuration)
               ("C-c C-e R" . eglot-reconnect)
               ("C-c C-e S" . eglot-shutdown)
               ("C-c C-e A" . eglot-shutdown-all)
               ("C-c C-e a" . eglot-code-actions)
               ("C-c C-e f" . eglot-format))))

;; Optional: Show/pick completions on tab, sane max height:
(setq tab-always-indent 'complete
      completions-max-height 20
      completion-auto-select 'second-tab)

;(server-start) ; for emacsclient / quick startup



(use-package org-roam
  :ensure t
   :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Documents/notes/org-roam/")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
  :map org-mode-map
         ("C-c n c"    . completion-at-point))
  :config
  (org-roam-setup))

(use-package minimap)

(setq minimap-window-location 'right)

(use-package nhexl-mode)

;; recentf stuff
(recently-mode 1)



;(use-package evil
;  :ensure t
;  :config
;  (evil-set-undo-system 'undo-tree)
;  (setq evil-search-module 'evil-search)
;  (evil-mode))



(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1))

(use-package auctex
  :ensure t  
  :defer t
  :hook (LaTeX-mode . (lambda ())))
			
(add-hook 'LaTeX-mode-hook 'company-mode)
(add-hook 'LaTeX-mode-hook
          (lambda ()
	    (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "LaTeX")
            (setq TeX-save-query nil)
            (setq TeX-view-program-selection '((output-pdf "Okular")
                                                 (output-dvi "Okular")))))



(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(add-hook 'doc-view-mode-hook 'auto-revert-mode)


(use-package lsp-mode :commands lsp :ensure t)
(use-package lsp-ui :commands lsp-ui-mode :ensure t)

(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))

;; json edit
(use-package json-mode)

(use-package magit)


 ;; Configure Elfeed
(use-package elfeed
  :ensure t
  :config
  (setq elfeed-db-directory (expand-file-name "elfeed" user-emacs-directory)
	elfeed-show-entry-switch 'display-buffer)
  :bind
  ("C-x w" . elfeed ))


(use-package flycheck-aspell)


(setq ispell-program-name "/usr/bin/ispell")

(bind-key "C-c s" #'ispell-buffer)




(use-package elfeed)

(setq elfeed-feeds
      '("https://archive.nytimes.com/www.nytimes.com/services/xml/rss/index.html" The New York Times)
      )

(use-package pacmacs)


(use-package dmenu)
(use-package evil)
(use-package exwm-firefox-core)
(use-package exwm-firefox-evil)
(require 'exwm-firefox-evil)
;; Auto enable exwm-firefox-evil-mode on all firefox buffers
(add-hook 'exwm-manage-finish-hook 'exwm-firefox-evil-activate-if-firefox)

(dolist (k `(
	     escape
	     ))
  (cl-pushnew k exwm-input-prefix-keys))

;;(shell-command "picom &")
;;emacs --eval '(picom &)' \
;;(call-process "/bin/bash" "~/.config/xmonad/scripts/bg.sh")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "ce4234c32262924c1d2f43e6b61312634938777071f1129c7cde3ebd4a3028da" "ae426fc51c58ade49774264c17e666ea7f681d8cae62570630539be3d06fd964" "60ada0ff6b91687f1a04cc17ad04119e59a7542644c7c59fc135909499400ab8" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "c865644bfc16c7a43e847828139b74d1117a6077a845d16e71da38c8413a5aaa" "570263442ce6735821600ec74a9b032bc5512ed4539faf61168f2fdf747e0668" "adaf421037f4ae6725aa9f5654a2ed49e2cd2765f71e19a7d26a454491b486eb" "443e2c3c4dd44510f0ea8247b438e834188dc1c6fb80785d83ad3628eadf9294" "f053f92735d6d238461da8512b9c071a5ce3b9d972501f7a5e6682a90bf29725" default))
 '(package-selected-packages
   '(evil exwm-firefox-evil dmenu shrink-whitespace pacmacs eglot flycheck-aspell elfeed magit autobookmarks sync-recentf recently json-mode json-ls org-noter-pdftools org-pdfview nhexl-mode minimap org-roam lsp-pyright anaconda-mode ac-haskell-process auto-complete ghci-completion company-ghci company-ghc company-backends haskell-mode general all-the-icons neotree doom-themes helpful ivy-rich counsel company which-key rainbow-delimiters doom-modeline ivy command-log-mode use-package))
 '(warning-suppress-log-types '((server))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'downcase-region 'disabled nil)
