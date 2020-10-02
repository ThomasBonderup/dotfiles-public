;; start package.el with emacs
(require 'package)
;; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;; initialize package.el
(package-initialize)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "brave-browser")

;; Ensure that use-package is installed.
;;
;; If use-package isn't already installed, it's extremely likely that this is a
;; fresh installation! So we'll want to update the package repository and
;; install use-package before loading the literate configuration.
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    blacken                         ;; Black formatting on save
    material-theme                  ;; Theme
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

(use-package auto-compile
  :config (auto-compile-on-load-mode))

(setq load-prefer-newer t)

;;(require 'rtags) ;; optional, must have rtags installed
;;(cmake-ide-setup)
(use-package company
:config
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)
(global-company-mode t))

(use-package company-irony
:config 
(add-to-list 'company-backends 'company-irony))

(use-package irony
:config
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package irony-eldoc
:config
(add-hook 'irony-mode-hook #'irony-eldoc))

(use-package drag-stuff
:config
(drag-stuff-mode t)
(drag-stuff-define-keys)
(global-set-key (kbd "C-M-I") 'drag-stuff-up)
(global-set-key (kbd "C-M-K") 'drag-stuff-down)
(global-set-key (kbd "C-M-J") 'drag-stuff-left)
(global-set-key (kbd "C-M-L") 'drag-stuff-right))

(setq x-select-enable-clipboard t)

(setq org-startup-indented t)
(setq org-indent-indentation-per-level 0)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; ====================================
;; Web Development Setup
;; ====================================
(use-package emmet-mode
:config
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode))

(use-package web-mode
:config
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))

;; ====================================
;; Python Development Setup
;; ====================================
;; Enable elpy
(use-package elpy
:config
(elpy-enable))

(require 'ein)

;; Use IPython for REPL
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")

;; Enable Flycheck
(use-package flycheck
:config
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode)))

;; Enable autopep8
(use-package py-autopep8
:config
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save))

(add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))

(defun my-compile ()
  "Use compile to run python programs"
  (interactive)
  (compile (concat "python " (buffer-name))))
(setq compilation-scroll-output t)

(local-set-key "\C-c\C-c" 'my-compile)

;; ====================================
;; Typescript Development Setup
;; ====================================

(use-package tide
:config
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; start flymake-google-cpplint-load
;; let's define a function for flymake initialization

;;(require 'flymake-cursor)

;; start google-c-style with emacs
;;(require 'google-c-style)
;;(add-hook 'c-mode-common-hook 'google-set-c-style)
;;(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; ===================================
;; Basic Customization
;; ===================================

(setq next-line-add-newlines t)
;; add monokai theme to emacs
(use-package monokai-theme
:config
(load-theme 'monokai t))

(setq frame-title-format "emacs")

;; remove menu-bar
(menu-bar-mode -1)

;; remove tool-bar
(tool-bar-mode -1)

;; remove scroll-bar
(scroll-bar-mode -1)

;; activate ido-mode - switch buffers, find file
(ido-mode)

;; add line numbers to emacs
(global-linum-mode t)

;; display current line number and column
(column-number-mode)

;; show-paren-mode allows one to see matching pairs of parentheses and other characters.
(show-paren-mode)

;; This page is about libraries that highlight the current line of characters, so you can find it easily.
(global-hl-line-mode)

;; activate winner-mode - redo/undo
(winner-mode t)

;; move between windows with arrows
(windmove-default-keybindings)

;; SMEX IS A M-X ENHANCEMENT for Emacs 
(use-package smex
:config
(global-set-key (kbd "M-x") 'smex))

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Autopair is an extension to the Emacs text editor that automatically pairs braces and quotes:
(use-package autopair
:config
(autopair-global-mode))

;; adds undo-tree to emacs
;; (use-package undo-tree
;; :config
;; (global-undo-tree-mode))
(global-set-key (kbd "M-/") 'undo-tree-visualize)

;; switch window shortcut
(global-set-key (kbd "C-M-z") 'switch-window)

;; Ace jump mode is a minor mode of emacs, which help you to move the cursor within Emacs.
(use-package ace-jump-mode
:config
(global-set-key (kbd "C-c C-SPC") 'ace-jump-mode))

;; increase transparency
(global-set-key (kbd "C-M-)") 'transparency-increase)

;; decrease transparency
(global-set-key (kbd "C-M-(") 'transparency-decrease)

;; mark next line
(global-set-key (kbd "C-}") 'mc/mark-next-like-this)

;; mark previous line
(global-set-key (kbd "C-{") 'mc/mark-previous-like-this)

;; emacs on startup
;;(use-package dashboard
;;:config
;;(dashboard-setup-startup-hook))

(setq dashboard-items '((projects . 5)
                        (bookmarks . 5)
                        (recents . 5)
                        (agenda . 5)
                        (registers . 5)))


;; adds file tree to emacs
(use-package neotree
:config
(global-set-key [f8] 'neotree-toggle))

;; org mode - your life in plain text
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-directory "~/exocortex/org")
(setq org-default-notes-file "~/exocortex/org/refile.org")
;; org files store locations
(setq org-agenda-files (list org-directory))

;; org bullets
(use-package org-bullets
:config
;;(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; org mode capture
;;(define-key global-map "\C-cc" 'org-capture)

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

(setq org-export-coding-system 'utf-8)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/exocortex/org/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/exocortex/org/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/exocortex/org/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/exocortex/org/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/exocortex/org/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/exocortex/org/refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/exocortex/org/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/exocortex/org/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

;;
;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)

;; google search in emacs shortcut
(defun prelude-google ()
  "Googles a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "Google: ")))))
  
(add-to-list 'load-path "/path/to/tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)

;; projectile - easier file navigation
(use-package counsel-projectile
:config
(projectile-global-mode)
(setq projectile-completion-system 'ivy)
(counsel-projectile-mode)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;; A light that follows your cursor around so you don't lose it
;; (use-package beacon
;; :config
;; (beacon-mode 1)
;; (setq beacon-color "#666600"))

(use-package engine-mode
:config
(engine-mode t)
(engine/set-keymap-prefix (kbd "C-c s")))

(defengine google
  "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
  :keybinding "g")

(defengine duckduckgo
  "https://duckduckgo.com/?q=%s"
  :keybinding "d")

(defengine github
  "https://github.com/search?ref=simplesearch&q=%s"
  :keybinding "e")

(defengine google
  "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s")

(defengine rfcs
  "http://pretty-rfc.herokuapp.com/search?q=%s")

(defengine stack-overflow
  "https://stackoverflow.com/search?q=%s"
  :keybinding "s")

(defengine wikipedia
  "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
  :keybinding "w")

(defengine wiktionary
  "https://www.wikipedia.org/search-redirect.php?family=wiktionary&language=en&go=Go&search=%s")

(defengine youtube
  "https://www.youtube.com/results?search_query=%s")

;; easy keys to split window. Key based on ErgoEmacs keybinding
(global-set-key (kbd "M-3") 'delete-other-windows) ; expand current pane
(global-set-key (kbd "M-4") 'split-window-below) ; split pane top/bottom
(global-set-key (kbd "M-2") 'delete-window) ; close current pane
(global-set-key (kbd "M-s") 'other-window) ; cursor to other pane

;; make cursor movement keys under right hand's home-row.
(global-set-key (kbd "M-j") 'backward-char) ; was indent-new-comment-line
(global-set-key (kbd "M-l") 'forward-char)  ; was downcase-word
(global-set-key (kbd "M-i") 'previous-line) ; was tab-to-tab-stop
(global-set-key (kbd "M-k") 'next-line) ; was kill-sentence

(global-set-key (kbd "M-SPC") 'set-mark-command) ; was just-one-space
(global-set-key (kbd "M-a") 'execute-extended-command) ; was backward-sentence

;; save emacs files backups directory
(setq backup-directory-alist
          `(("." . ,(concat user-emacs-directory "backups"))))
    
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

(use-package expand-region
:config
(global-set-key (kbd "C-=") 'er/expand-region))
(pending-delete-mode t)

(use-package yasnippet-snippets
:config
(yas-global-mode 1))

(use-package disable-mouse
:config
(require 'disable-mouse)
(global-disable-mouse-mode))

(recentf-mode 1) ; keep a list of recently opened files
;; set F7 to list recently opened file
(global-set-key (kbd "<f7>") 'recentf-open-files)

; roslaunch highlighting
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))

;; make emacs fullscreen on start
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(defun visit-emacs-config ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "C-c e") 'visit-emacs-config)

;; space befoare line-number
(setq linum-format " %d")
;; solid line separator after line-number
;;(setq linum-format " %d \u2502 ")

;; see which lines in emacs that have been changed since last git commit
;;(global-git-gutter-mode +1)

;; rainbow parentheses in emacs - easier to spot mathcing delimiters
(use-package rainbow-delimiters
:config
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; git inside emacs
(use-package magit
:config
(global-set-key (kbd "C-x g") 'magit-status))

;; dockerfile-mode
;; Adds syntax highlighting -  build the image directly (C-c C-b) from the buffer.
(use-package dockerfile-mode
:config
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package docker
:config
:bind ("C-c d" . docker))

;; nyan-mode
(use-package nyan-mode
:config
(nyan-mode))

(use-package k8s-mode
:config
(require 'k8s-mode))

(defun dired-dotfiles-toggle ()
  "Show/hide dot-files"
  (interactive)
  (when (equal major-mode 'dired-mode)
    (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p) ; if currently showing
	(progn 
	  (set (make-local-variable 'dired-dotfiles-show-p) nil)
	  (message "h")
	  (dired-mark-files-regexp "^\\\.")
	  (dired-do-kill-lines))
      (progn (revert-buffer) ; otherwise just revert to re-show
	     (set (make-local-variable 'dired-dotfiles-show-p) t)))))

(setq inhibit-splash-screen t)
(require 'bookmark)
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")
