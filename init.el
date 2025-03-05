(require 'elcord)
(elcord-mode)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
;; Theme
(use-package timu-spacegrey-theme
  :ensure t)
;; Icons
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-completion
  :ensure t
  :defer
  :hook (marginalia-mode . #'all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))
;; Startup dashboard
(use-package dashboard
  :ensure t
  :custom
  (dashboard-startup-banner (concat user-emacs-directory "themes/emacs.txt"))
  :config
  (dashboard-setup-startup-hook))
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil) 
;; Line config
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 10)))
;; Customize tabs
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "rounded")
  (setq centaur-tabs-height 15)
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-icon-type 'all-the-icons)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))
;; Like vim keys
(use-package xah-fly-keys
  :ensure t
  :load-path "lisp/"
  :config
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1))
;; Rust config
(use-package cargo
  :ensure t)

(use-package cargo-mode
  :ensure t
  :hook
  (rust-mode . cargo-minor-mode)
  :config
  (setq compilation-scroll-output t))

(use-package rustic
  :ensure t
  :config
  (setq rustic-format-on-save nil)
  :custom
  (rustic-cargo-use-last-stored-arguments t))

(use-package rust-mode
  :ensure t
  :init
  (add-hook 'rust-mode-hook #'lsp))

;; Languages config
(use-package python-mode
  :ensure t)

(use-package go-mode
  :ensure t)

(use-package lua-mode
  :ensure t)

(use-package luarocks
  :ensure t)

(use-package cc-mode
  :ensure t)

(use-package iasm-mode
  :ensure t)

(use-package nasm-mode
  :ensure t)
;; WakaTime Config
(use-package wakatime-mode
  :ensure t)
;; LSP Configuration
(use-package lsp-mode
  :ensure t
  :hook (c++-mode . lsp))

;; LSP-Ui Configuration
(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :custom
  (lsp-ui-doc-show-with-cursor t))

;; Company config
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

;; FlyCheck config
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Tree-Sitter
(use-package tree-sitter
  :ensure t)

(use-package tree-sitter-langs
  :ensure t
  :hook
  (c-mode . tree-sitter-hl-mode))

;; Consult binds
(use-package consult
  :ensure t
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
)

;; Vertico bind
(use-package vertico
  :ensure t
  :init
  (vertico-mode))

;; Orderless config
(use-package orderless
  :ensure t
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(timu-spacegrey))
 '(custom-safe-themes
   '("15466a777080bcd4f71fea193fd7e4988552919c0e8a09621883aa19166b5099" "b9f44212b4be6f0466811c5d8a297dda3c40dbf4c4cfd97c1686fceb2043b617" "7fac152a13c430ee81f0fed959305e3331a6355765b3ae825006933b9ec36861" default))
 '(global-display-line-numbers-mode t)
 '(global-tab-line-mode nil)
 '(global-wakatime-mode t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(rust-mode python-mode go-mode python wakatime-mode timu-spacegrey-theme use-package flycheck company orderless vertico consult luarocks lua-mode lsp-ui lsp-mode elcord))
 '(recentf-mode t)
 '(scroll-bar-mode nil)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(wakatime-api-key "YOUR API KEY"))
  (add-to-list 'default-frame-alist '(font . "JetBrains Mono"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
