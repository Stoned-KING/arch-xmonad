;; woudan emacs config file

;; author      : sudhanshu selvan aka wuodan
;; version     : 1.00.01
;; date        : 03-05-23
;; description : custom configuration file for the text editor emacs that is written in emacs lisp or elisp
;; usage       : place the file under ~/.emacs.d/ or ~/.config/emacs/ directory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DO NOT RUN THIS WITHOUT KNOWING WHAT IT EXECUTES ; RUN AT YOUR OWN RISK!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Startup Performance

;; -*- lexical-binding: t; -*-
;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))
;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s seconds with %d garbage collections."
                     (emacs-init-time "%.2f")
                     gcs-done)))

;; Package Management

;; Install straight.el package manager
(unless (featurep 'straight)
  ;; Bootstrap straight.el
  (defvar bootstrap-version)
  (let ((bootstrap-file
         (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
        (bootstrap-version 5))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
          (url-retrieve-synchronously
           "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
           'silent 'inhibit-cookies)
        (goto-char (point-max))
        (eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage)))
;; Use straight.el for use-package expressions
(straight-use-package 'use-package)
;; install use-package with straight.el
(straight-use-package 'el-patch)
;; use-package will use straight.el to auto install missing packages
(use-package el-patch
  :straight t)

;; streamlined configuration with setup.el

;; use this as an alternative to use-package
(straight-use-package '(setup :type git :host nil :repo "https://git.sr.ht/~pkal/setup"))
(require 'setup)
;; Uncomment this for debugging purposes
;; (defun dw/log-require (&rest args)
;;   (with-current-buffer (get-buffer-create "*require-log*")
;;     (insert (format "%s\n"
;;                     (file-name-nondirectory (car args))))))
;; (add-to-list 'after-load-functions #'dw/log-require)

;; :pkg

;; the :pkg keyword will depend on guix-installed emacs packages unless the parameter seems like a straight.el recipe (it’s a list)
;; Recipe is always a list
;; Install via Guix if length == 1 or :guix t is present
(defvar dw/guix-emacs-packages '()
  "Contains a list of all Emacs package names that must be
installed via Guix.")
;; Examples:
;; - (org-roam :straight t)
;; - (git-gutter :straight git-gutter-fringe)
(defun dw/filter-straight-recipe (recipe)
  (let* ((plist (cdr recipe))
         (name (plist-get plist :straight)))
    (cons (if (and name (not (equal name t)))
              name
            (car recipe))
          (plist-put plist :straight nil))))

(setup-define :pkg
  (lambda (&rest recipe)
    (if (and dw/is-guix-system
             (or (eq (length recipe) 1)
                 (plist-get (cdr recipe) :guix)))
        `(add-to-list 'dw/guix-emacs-packages
                      ,(or (plist-get recipe :guix)
                           (concat "emacs-" (symbol-name (car recipe)))))
      `(straight-use-package ',(dw/filter-straight-recipe recipe))))
  :documentation "Install RECIPE via Guix or straight.el"
  :shorthand #'cadr)

;; :delay

;; delay the loading of a package until a certail amount of idle time has passed
(setup-define :delay
   (lambda (&rest time)
     `(run-with-idle-timer ,(or time 1)
                           nil ;; Don't repeat
                           (lambda () (require ',(setup-get 'feature)))))
   :documentation "Delay loading the feature until a certain amount of idle time has passed.")

;; :disabled

;; used to disable a package configuration, similar to :disabled in use-package
(setup-define :disabled
  (lambda ()
    `,(setup-quit))
  :documentation "Always stop evaluating the body.")

;; :load-after

;; this keyword causes a body to be executed after other packages/features are loaded:
(setup-define :load-after
    (lambda (features &rest body)
      (let ((body `(progn
                     (require ',(setup-get 'feature))
                     ,@body)))
        (dolist (feature (if (listp features)
                             (nreverse features)
                           (list features)))
          (setq body `(with-eval-after-load ',feature ,body)))
        body))
  :documentation "Load the current feature after FEATURES."
  :indent 1)

;; keep .emac.d Clean

;; change the user-emacs-directory to keep unwanted things out of ~/.emacs.d
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))

;; update load path

;; a folder of custom emacs lisp libraries which can be added to the load path
;; Add my library path to load-path
;; (push "~/.dotfiles/.emacs.d/lisp" load-path)

;; default coding system - windows

;; avoid constant errors on windows about the coding system by setting the default to utf-8
;; (set-default-coding-systems 'utf-8)

;; server mode

;; start the emacs server from this instance so that all emacsclient calls are routed here
;; (server-start)

;; keyboard bindings

;; esc cancels all
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


;; General settings ; Toggle variables with t and nil
(setq inhibit-startup-message t                  ; Don't show the splash screen
      visible-bell t                             ; Flash the frame to represent a bell 
      use-dialog-box nil                         ; Mouse commands use dialog boxes to ask questions
      global-auto-revert-non-file-buffers t)     ; Revert dired and other buffers

;; Custom ui settings ; Toggle functions with 1 and -1
(tool-bar-mode -1)                    ; Display the tool bar in all graphical frames.
(scroll-bar-mode -1)                  ; Display the vertical scroll bars in all frames
(menu-bar-mode 1)                     ; Display the menu bar in each frame
(global-display-line-numbers-mode 1)  ; Display line numbers in every buffer 
(hl-line-mode 1)                      ; Highlight the current line
(blink-cursor-mode 1)                 ; Blinking cursor
(recentf-mode 1)                      ; Display the most recently edited files
(save-place-mode 1)                   ; Save place in file
(global-auto-revert-mode 1)           ; Revert any buffer associated with a file when the file changes on disk

;; enable line numbers and customize their format
(column-number-mode)
;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))
;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; dont warn for large files (videos)
(setq large-file-warning-threshold nil)

;; dont warn for following symlinked files
(setq vc-follow-symlinks t)

;; dont warn when advice is added for functions
(setq ad-redefinition-action 'accept)

;; emacs themes

;; Custom values to be loaded for the selected theme 
;; These variables will act as input when loading the selected theme

; Can use borderless, accented, 3d, moody, padded as multiple aspect variable inputs
(setq modus-themes-mode-line '(moody borderless accented)) ; Control the overall style of the mode line

; Can use accented bg-only no-extend as multiple aspect variable inputs
(setq modus-themes-region '(accented bg-only no-extend))   ; Control the overall style of the active region
; Can use default, moderate, opinionated as single aspect variable inputs
; Control the style of the completion framework ui
(setq modus-themes-completions
      '((matches . (extrabold underline))
        (selection . (semibold italic))))                  
(setq modus-themes-bold-constructs t)                      ; Use bold text in more code constructs
(setq modus-themes-italic-constructs t)                    ; Use italic font forms in more code constructs
; Can use bold, underline, intense as multiple aspect variable inputs
(setq modus-themes-paren-match '(bold intense))            ; Control the style of matching parenthesis
; Can use faint, alt-syntax, green-strings, yellow-comments as multiple aspect variable inputs
(setq modus-themes-syntax '(faint alt-syntax green-strings yellow-comments)) ; Control style of code syntax highlighting
; Can use nil, subtle, intense as single aspect variable input
(setq modus-themes-fringes 'subtle)                        ; Define the visibility of fringes
(setq modus-themes-tabs-accented t)                        ; Toggle accented tab backgrounds
; can use background, intense, gray, bold, italic, nil as multiple aspect variable inputs
(setq modus-themes-prompts '(bold intense background))                ; style minibuffer and REPL prompts
(load-theme 'modus-vivendi t)         ; Load the modus vivendi dark theme

;; Save what you enter into minibuffer prompts
(setq history-length 25)              ; Maximum length of history list before truncation takes place
(savehist-mode 1)                     ; Save the minibuffer history

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; package-archives

;; setup melpa package-archives
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; lsp-mode

;; setup lsp-mode 
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp)
	 (sh-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
;; optionally if you want to use debugger
;; (use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language
;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode))
;; setup lsp-deferred
(use-package lsp-mode
	     :hook
	     (python-mode . lsp-deferred)
	     (sh-mode . lsp-deferred)
	     (csharp-mode . lsp-deferred)
	     :commands (lsp lsp-deferred))

;; install and setup lsp-haskell
(require 'lsp)
(require 'lsp-haskell)
;; Hooks so haskell and literate haskell major modes trigger LSP setup
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

(use-package csharp-mode :ensure t
:init
(add-hook 'csharp-mode-hook #'company-mode)
(add-hook 'csharp-mode-hook #'rainbow-delimiters-mode))

(use-package company :ensure t :mode "company-mode")
  (use-package company-box :ensure t
:hook (company-mode . company-box-mode))
