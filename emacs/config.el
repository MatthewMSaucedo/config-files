;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;
;;
;;
;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Matthew's changes ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;;
;; ;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq vterm-timer-delay 0.01)

(setq user-full-name "Matthew Saucedo"
      user-mail-address "themattsaucedo@gmail.com")

(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
;; (doom-themes-treemacs-config)
;; (treemacs-display-current-project-exclusively)

;; Treemacs specific project open
(map! :leader
      :desc "Open project in Treemacs"
      "p t" #'treemacs-display-current-project-exclusively)

(setq
 ;; truly forget what this was for
 tramp-inline-compress-start-size 1000000
 ;; tell projectile where to look
 projectile-project-search-path '("~/code/")
 ;; make vterm a lil bit snappier
 vterm-timer-delay 0.01
 )

(use-package! python-black
  :demand t
  :after python
  :config
  (add-hook! 'python-mode-hook #'python-black-on-save-mode)
  ;; Feel free to throw your own personal keybindings here
  (map! :leader :desc "Blacken Buffer" "m b b" #'python-black-buffer)
  (map! :leader :desc "Blacken Region" "m b r" #'python-black-region)
  (map! :leader :desc "Blacken Statement" "m b s" #'python-black-statement)
  )

;; Python snippets
(after! anaconda-mode
  (set-company-backend! 'anaconda-mode '(company-anaconda company-yasnippet)))

;;  Pdf scrolling
(setq doc-view-continuous t)

;; Opacity
(doom/set-frame-opacity 100)

;; lsp always show breadcrumb
(setq lsp-headerline-breadcrumb-enable t)

(defun typescript-mode-setup ()
  "Custom setup for Typescript mode"
  (setq flycheck-checker 'javascript-eslint)
  )
(add-hook 'typescript-mode-hook 'typescript-mode-setup)

;; Toggle through org slides
(map! :leader
      :desc "Next slide"
      "n x" #'org-tree-slide-move-next-tree)
(map! :leader
      :desc "Previous slide"
      "n z" #'org-tree-slide-move-previous-tree)

;; rename the buffer!
(map! :leader
      :desc "Change title of buffer"
      "b t" #'rename-buffer)

;;;;;;;;;;;;;;;;;;;;;;;
;; Debugging
;;;;;;;;;;;;;;;;;;;;;;;
(use-package dap-mode
  :after lsp-mode
  :commands dap-debug
  :hook ((python-mode . dap-ui-mode) (python-mode . dap-mode))
  :config
  (require 'dap-python)
  (setq dap-python-debugger 'debugpy)
  (defun dap-python--pyenv-executable-find (command)
    (with-venv (executable-find "python")))

  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra))))

(map! :leader
      :desc "pytest proj in new buffer"
      "p t" #'python-pytest)

(general-auto-unbind-keys)
(map! :leader
      :desc "debug session start"
      "d s s" #'dap-debug)
(map! :leader
      :desc "debug session delete"
      "d s d" #'dap-delete-session)
(map! :leader
      :desc "debug eval"
      "d e" #'dap-eval)
(map! :leader
      :desc "debug continue"
      "d c" #'dap-continue)
(map! :leader
      :desc "debug next"
      "d n" #'dap-next)
(map! :leader
      :desc "debug breakpoint add"
      "d b a" #'dap-breakpoint-add)
(map! :leader
      :desc "debug breakpoint delete"
      "d b d" #'dap-breakpoint-delete)
(map! :leader
      :desc "debug show var buffer"
      "d l" #'dap-ui-locals)

;;;;;;;;;;;;;;;;;;;;;;;
;; Make venv python env work for tools like DAP
;;;;;;;;;;;;;;;;;;;;;;;
(defun dap-python--pyenv-executable-find (command)
  (executable-find command))
(map! :leader
      :desc "activate pyvenv in current buffer (virtual activate)"
      "v a" #'pyvenv-activate)
