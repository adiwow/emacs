(load (expand-file-name "~/quicklisp/slime-helper.el"))
  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "sbcl")



;;(load-theme 'misterioso' t)

(savehist-mode t)

(setq savehist-file "~/.emacs.d/savehist")

(defun save-defaults ()
  (desktop-save desktop-dirname)
  (savehist-save)
  (bookmark-save))

(defun save-histories ()
  (let ((buf (current-buffer)))
    (save-excursion
      (dolist (b (buffer-list))
        (switch-to-buffer b)
        (save-history)))
    (switch-to-buffer buf)))

(defun save ()
  (interactive)
  (save-desktop)
  (save-defaults)
  (save-histories))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(smartparens visual-fill-column org-bullets forge evil-magit magit counsel-projectile projectile hydra evil-collection evil general helpful counsel ivy-rich which-key rainbow-delimiters org-modern))
 '(warning-suppress-log-types '(((slime warning))))
 '(warning-suppress-types '(((slime warning)) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Add Date
(setq display-time-day-and-date t
      display-time-format "%a %b %d %R"
      display-time-interval 60
      display-time-default-load-average nil)
(display-time)
;; Basic UI Configuration ------------------------------------------------------

;; You will most likely need to adjust this font size for your system!
(defvar runemacs/default-font-size 180)

(setq inhibit-startup-message t)

;(scroll-bar-mode -1)        ; Disable visible scrollbar
;(tool-bar-mode -1)          ; Disable the toolbar
;(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

;(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Font Configuration ----------------------------------------------------------

;;(set-face-attribute 'default nil :font "Fira Code Retina" :height runemacs/default-font-size)

;; Set the fixed pitch face
;;(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 260)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 150 :weight 'regular)

;; Package Manager Configuration -----------------------------------------------

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(column-number-mode)
(global-display-line-numbers-mode t)

(use-package command-log-mode)


;; Ivy Configuration -----------------------------------------------------------

;(use-package ivy
 ; :diminish
  ;:bind (
;	 ("C-s" . swiper)
 ;        :map ivy-minibuffer-map
  ;       ("TAB" . ivy-alt-done)
   ;      ("C-l" . ivy-alt-done)
    ;     ("C-j" . ivy-next-line)
     ;    ("C-k" . ivy-previous-line)
      ;   :map ivy-switch-buffer-map
     ;    ("C-k" . ivy-previous-line)
    ;     ("C-l" . ivy-done)
   ;      ("C-d" . ivy-switch-buffer-kill)
  ;       :map ivy-reverse-i-search-map
 ;        ("C-k" . ivy-previous-line)
;         ("C-d" . ivy-reverse-i-search-kill)  ;:config
  ;(ivy-mode 1))

;; NOTE: The first time you load your configuration on a new machine, you'll
;; need to run the following command interactively so that mode line icons
;; display correctly:
;;
;; M-x all-the-icons-install-fonts

 (use-package all-the-icons)

 (use-package doom-modeline
   :init (doom-modeline-mode 1)
   :custom ((doom-modeline-height 15)))

 (use-package doom-themes
   :init (load-theme 'doom-badger t))

 (use-package rainbow-delimiters
   :hook (prog-mode . rainbow-delimiters-mode))

;; (use-package which-key
;;   :init (which-key-mode)
;;   :diminish which-key-mode
;;   :config
;;   (setq which-key-idle-delay 1))

;(use-package ivy-rich
 ; :init
  ;(ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Key Binding Configuration ---------------------------------------------------

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


(use-package general
 :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
   "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

;(use-package evil
  ;:init
  ;(setq evil-want-integration t)
  ;(setq evil-want-keybinding nil)
  ;(setq evil-want-C-u-scroll t)
  ;(setq evil-want-C-i-jump nil)
  ;:config
 ; (evil-mode 1)
 ; (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
 ; (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
 ; (evil-global-set-key 'motion "j" 'evil-next-visual-line)
 ; (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

 ; (evil-set-initial-state 'messages-buffer-mode 'normal)
 ; (evil-set-initial-state 'dashboard-mode 'normal))

;(use-package evil-collection
 ; :after evil
  ;:config
  ;(evil-collection-init))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(rune/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

;; Projectile Configuration ----------------------------------------------------

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

;; Magit Configuration ---------------------------------------------------------

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;;(use-package evil-magit
 ;; :after magit)

;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
(use-package forge)

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

;; Org Mode Configuration ------------------------------------------------------

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (efs/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(use-package smartparens-config
  :ensure smartparens
  :config (progn (show-smartparens-global-mode t)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

;;Timestamps
(defun format-date (format)
  (let ((system-time-locale "en_US.UTF-8"))
    (insert (format-time-string format))))

(defun insert-date ()
  (interactive)
  (format-date "%A, %B %d %Y"))

(defun insert-date-and-time ()
  (interactive)
  (format-date "%Y-%m-%d %H:%M:%S"))

;;line numbers
(setq linum-format "%5d │ ")

(defun my-linum-mode-hook ()
  (linum-mode t))

(add-hook 'find-file-hook 'my-linum-mode-hook)

;;KEY-BIND FOR SMARTPARENS

