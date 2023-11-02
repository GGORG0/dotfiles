;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "GGORG"
      user-mail-address "GGORG0@protonmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14)
     doom-variable-pitch-font (font-spec :family "Noto Sans" :size 14)
     doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 20))
(setq doom-unicode-font doom-font)

;; (custom-set-faces! '(fringe :foreground "#ff0000"))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'catppuccin)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Projects/org")


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


;; enable word-wrap (almost) everywhere
;; (+global-word-wrap-mode +1)


;; Discord rich presence
(defun elcord-buffer-details-format-custom ()
  (format "Editing %s in %s" (buffer-name) (doom-project-name)))

(setq! elcord-editor-icon 'emacs_material_icon)
(setq! elcord-use-major-mode-as-main-icon 't)
(setq! elcord-buffer-details-format-function 'elcord-buffer-details-format-custom)

(require 'elcord)
(elcord-mode)


;; GitHub Copilot
;; accept completion from copilot and fallback to company

(use-package! copilot
  :hook (prog-mode . copilot-mode))

(map! :desc "Accept Copilot completion"
      :map copilot-completion-map
      "<tab>" #'copilot-accept-completion)

(map! :desc "Accept Copilot completion"
      :map copilot-completion-map
      "TAB" #'copilot-accept-completion)

(map! :desc "Accept Copilot completion by word"
      :map copilot-completion-map
      "C-TAB" #'copilot-accept-completion-by-word)

(map! :desc "Accept Copilot completion by word"
      :map copilot-completion-map
      "C-<tab>" #'copilot-accept-completion-by-word)


;; Frame transparency

(set-frame-parameter nil 'alpha-background 75) ; For current frame
(add-to-list 'default-frame-alist '(alpha-background . 75)) ; For all new frames henceforth


;; LSP Inline type hints
(after! lsp-mode
 (setq lsp-inlay-hint-enable t)
 (lsp-inlay-hints-mode))
