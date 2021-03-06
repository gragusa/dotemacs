;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
  You should not put any user code in this function besides modifying the variable
  values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     rust
     yaml
     html
     python
     csv
     elfeed
     (elfeed :variables
             rmh-elfeed-org-files (list "~/Dropbox/org/rssfeeds.org"))
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------

     ;; better-defaults
     emacs-lisp
     osx
     git
     markdown
     (org :variables org-enable-reveal-js-support t)
     (spell-checking :variables enable-flyspell-auto-completion nil)
     evil-commentary
     x-org
     ess
     bibtex
     x-org
     (latex :variables
            latex-enable-auto-fill t
            latex-enable-folding t
            )
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     spell-checking
     ;; syntax-checking
     polymode
     (auto-completion :variables
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-sort-by-usage t
                      )
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(evil-multiedit julia-repl multiple-cursors)

   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration. 
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 8
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Monaco"
                               :size 12
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido 2
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers t 
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'. You are free
to put almost any user code here. The exception is org related
code, which should be placed in `dotspacemacs/user-config'."
  (add-to-list 'load-path "~/.emacs.d/private/misc")

  (menu-bar-mode 1)
  (delete-selection-mode 1)
  (setq exec-path-from-shell-check-startup-files nil)
  (setq tramp-ssh-controlmaster-options
        "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  (spacemacs|disable-company poly-markdown+R-mode)

  ;; Highlights all matches of the selection in the buffer.
  (define-key evil-visual-state-map "R" 'evil-multiedit-match-all)

  ;; Match the word under cursor (i.e. make it an edit region). Consecutive presses will
  ;; incrementally add the next unmatched match.
  (define-key evil-normal-state-map (kbd "s-d") 'evil-multiedit-match-and-next)
  ;; Match selected region.
  (define-key evil-visual-state-map (kbd "s-d") 'evil-multiedit-and-next)
  ;; Insert marker at point
  (define-key evil-insert-state-map (kbd "s-d") 'evil-multiedit-toggle-marker-here)

  ;; Same as s-d but in reverse.
  (define-key evil-normal-state-map (kbd "s-D") 'evil-multiedit-match-and-prev)
  (define-key evil-visual-state-map (kbd "s-D") 'evil-multiedit-and-prev)

  (evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)


  (with-eval-after-load 'org (setq org-directory
                                   '("~/Dropbox/org")))

  (with-eval-after-load 'org (setq org-agenda-files
                                   '("~/Dropbox/org/grnotes.org")))

  (global-set-key [home] 'beginning-of-line)
  (global-set-key [end] 'end-of-line)
  (global-set-key [(s-right)] 'end-of-line)
  (global-set-key [(s-left)] 'beginning-of-line)


  (global-set-key (kbd "s-/") 'comment-region)
  (global-set-key (kbd "s-?") 'uncomment-region)

  (global-set-key [(C-s-right)] 'windmove-right)
  (global-set-key [(C-s-left)] 'windmove-left)

  (global-set-key [(C-s-up)] 'windmove-up)
  (global-set-key [(C-s-down)] 'windmove-down)

  (global-set-key [f1] 'replace-string)
  (global-set-key [f2] 'split-window-horizontally)
  (global-set-key [f3] 'split-window-vertically)
  (global-set-key [f4] 'delete-window)

  (global-set-key (kbd "C-s-,") 'previous-buffer)
  (global-set-key (kbd "C-s-.") 'next-buffer)

  (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
  (define-key flyspell-mouse-map [mouse-3] #'undefined)

  ;;========================================================================
  ;; My personal ESS stuff
  ;;========================================================================

  (defun my-ess-eval ()
    (interactive)
    ;; (my-ess-start-R)  // Otherwise stata does not startup
    (if (and transient-mark-mode mark-active)
        (call-interactively 'ess-eval-region)
      (call-interactively 'ess-eval-line-and-step)))


  (add-hook 'ess-mode-hook
            (lambda()
              (define-key inferior-ess-mode-map [(s-up)] 'comint-previous-input)
              (define-key inferior-ess-mode-map [(s-down)] 'comint-next-input)
              (define-key ess-mode-map (kbd "<s-return>") 'my-ess-eval)
              (define-key ess-mode-map (kbd "TAB") 'julia-latexsub-or-indent)
              (setq-local split-height-threshold nil)
              (setq-local split-width-threshold  0)
              (setq inferior-julia-args "-e include("$(ENV["HOME"])/.julia/config/startup-babel.jl") -i")
              ;; Needed to fix ob-julia.el problem with Julia v1.0
              ;; https://stackoverflow.com/questions/52043705/emacs-org-babel-with-ob-julia-el-does-not-work-anymore-with-julia-v1-0
              ))

  (setq ess-use-auto-complete 'script-only)
  ;; At times ESS shell gets very heavy...Once it was a 340Mb
  ;; files. This function cleans it.
  (defun clear-shell ()
    (interactive)
    (let ((old-max comint-buffer-maximum-size))
      (setq comint-buffer-maximum-size 0)
      (comint-truncate-buffer)
      (setq comint-buffer-maximum-size old-max)))

  (with-eval-after-load 'org
    (defun cleanup-org-tables ()
      (save-excursion
        (goto-char (point-min))
        (while (search-forward "-+-" nil t) (replace-match "-|-"))
        ))

    (setq org-bullets-bullet-list '("■" "◆" "▲" "▶"))

    (add-hook 'markdown-mode-hook 'orgtbl-mode)
    (add-hook 'markdown-mode-hook
              (lambda()
                (add-hook 'after-save-hook 'cleanup-org-tables  nil 'make-it-local)))


    (setq inferior-julia-program-name "/usr/local/bin/julia")
    (setq org-support-shift-select t)

    (setq org-latex-pdf-process
          "latexmk -pdflatex='pdflatex -shell-escape -interaction nonstopmode' -pdf -f %f")

    (org-babel-do-load-languages
     'org-babel-load-languages
     '((R . t)
       (python . t)
       (julia . t)))

    (defun org-export-as-pdf ()
      (interactive)
      (save-buffer)
      (org-latex-export-to-pdf))

    (add-hook
     'org-mode-hook
     (lambda()
       (define-key org-mode-map
         (kbd "<f5>") 'org-export-as-pdf)))

  (setq org-src-preserve-indentation t)
  (setq org-latex-listings 'minted)
  (setq org-latex-minted-options
        '(("fontsize" "\\small")
          ("obeytabs" "true")
          ("bgcolor" "gray!20")
          ("frame" "single")
          ("linenos" "true")
          ("mathescape" "true")
          ))

  (add-to-list 'org-latex-packages-alist '("dvipsnames, x11names" "xcolor" nil))
  (add-to-list 'org-latex-packages-alist '("" "minted" nil))
  ;; (add-to-list 'org-latex-packages-alist '("" "mathpazo" t))

  (setq org-latex-pdf-process '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                                "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

  (add-hook
   'org-beamer-mode-hook
   (lambda()
     (define-key org-mode-map
       (kbd "<f5>") 'org-beamer-export-as-pdf)))

  (setq org-confirm-babel-evaluate nil)

  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
  (add-hook 'org-mode-hook 'org-display-inline-images)

  )



  (defun rl-save-and-LaTeX ()
    "Save and LaTeX `TeX-master-file' (without querying the user)"
    (interactive)
    (let (TeX-save-query)	           ;;the following will save without prompting
      (TeX-save-document (TeX-master-file))) ;;save master document and its files
    (TeX-command "LaTeX" 'TeX-master-file))

  (defun next-command-LaTeX ()
    "View LaTeX"
    (interactive)
    (TeX-command "View" 'TeX-master-file)
    )



  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (define-key
                LaTeX-mode-map (kbd "<f5>") 'rl-save-and-LaTeX)
              (define-key
                LaTeX-mode-map (kbd "<f6>") 'next-command-LaTeX)
              (push '("PDF Tools" TeX-pdf-tools-sync-view)
                    TeX-view-program-list)
              (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
                    TeX-source-correlate-start-server t)
              ))

  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (push
               '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
                 :help "Run latexmk on file")
               TeX-command-list)))

  (add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))
  (add-hook 'LaTeX-mode-hook 'outline-minor-mode)
  (add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
            'TeX-revert-document-buffer)

  ;; (setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
  ;; (setq TeX-view-program-list
  ;;       '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))


  (with-eval-after-load 'yasnippet
    (setq yas-snippet-dirs (remq 'yas-installed-snippets-dir yas-snippet-dirs)))

  ;; (setq-default
  ;;  ;; Break lines at specified column (<= 80, defaults 72)
  ;;  fill-column 72
  ;;  ;; Turns on auto-fill-mode to automatically break lines
  ;;  auto-fill-function 'do-auto-fill
  ;;  )


  (setq org-capture-templates
        (quote
         (("w"
           "Default template"
           entry
           (file+headline "~/org/capture.org" "Notes")
           "* %^{Title}\n\n  Source: %u, %c\n\n  %i"
           :empty-lines 1)
          ;; ... more templates here ...
          )))




  ;; somewhere after (require 'ess-site)
  (setq ess-swv-processor 'knitr)
  (setq ess-swv-plug-into-AUCTeX-p t)

  (defun ess-swv-add-TeX-commands ()
    "Add commands to AUCTeX's \\[TeX-command-list]."
    (unless (and (featurep 'tex-site) (featurep 'tex))
      (error "AUCTeX does not seem to be loaded"))
    (add-to-list 'TeX-command-list
                 '("Knit" "Rscript -e \"library(knitr); knit('%t')\""
                   TeX-run-command nil (latex-mode) :help
                   "Run Knitr") t)
    (add-to-list 'TeX-command-list
                 '("LaTeXKnit" "%l %(mode) %s"
                   TeX-run-TeX nil (latex-mode) :help
                   "Run LaTeX after Knit") t)
    (setq TeX-command-default "Knit")
    (mapc (lambda (suffix)
            (add-to-list 'TeX-file-extensions suffix))
          '("nw" "Snw" "Rnw")))

  (defun ess-swv-remove-TeX-commands (x)
    "Helper function: check if car of X is one of the Knitr strings"
    (let ((swv-cmds '("Knit" "LaTeXKnit")))
      (unless (member (car x) swv-cmds) x)))

  ;;; remove automatic matching of backtics
  (sp-pair "`" nil :actions :rem)
  ;;;

  (add-to-list 'exec-path "/usr/texbin")
  (add-to-list 'exec-path "/Library/TeX/texbin")


  (require 'julia-repl)
  (add-hook 'julia-mode-hook 'julia-repl-mode) ;; always use minor mode
  (setq ess-tab-complete-in-script t)

  ;; Start term in emacs mode always
  (eval-after-load 'evil-vars '(evil-set-initial-state 'term-mode 'emacs))

  (add-hook 'julia-mode-hook
            (lambda()
              (kbd "<s-return>") 'julia-repl-send-region-or-line))

  (require 'multiple-cursors)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)


  (defun toggle-show-trailing-whitespace ()
    "Toggle show-trailing-whitespace between t and nil"
    (interactive)
    (setq show-trailing-whitespace (not show-trailing-whitespace)))


;;   (setq mu4e-maildir (expand-file-name "~/.Maildir"))

;;   ;; (setq mu4e-drafts-folder "/[Gmail].Drafts")
;;   ;; (setq mu4e-sent-folder   "/[Gmail].Sent Mail")
;;   ;; (setq mu4e-trash-folder  "/[Gmail].Trash")

;;   ;; don't save message to Sent Messages, GMail/IMAP will take care of this
;;   (setq mu4e-sent-messages-behavior 'delete)

;;   ;; setup some handy shortcuts
;;   (setq mu4e-maildir-shortcuts
;;         '(("/INBOX"             . ?i)
;;           ("/[Gmail].Sent Mail" . ?s)
;;           ("/[Gmail].Trash"     . ?t)))

;;   (setq mu4e-mu-binary "/usr/local/bin/mu")

;; ;; allow for updating mail using 'U' in the main view:
;;   (setq mu4e-get-mail-command "offlineimap")

;; ;; something about ourselves
;; ;; I don't use a signature...
;;   (setq
;;    user-mail-address "giuseppe.ragusa@gmail.com"
;;    user-full-name  "Giuseppe Ragusa"
;;    ;; message-signature
;;    ;;  (concat
;;    ;;    "Foo X. Bar\n"
;;    ;;    "http://www.example.com\n")
;;    )

;; ;; sending mail -- replace USERNAME with your gmail username
;; ;; also, make sure the gnutls command line utils are installed
;; ;; package 'gnutls-bin' in Debian/Ubuntu, 'gnutls' in Archlinux.

;; (setq message-send-mail-function 'smtpmail-send-it
;;       starttls-use-gnutls t
;;       smtpmail-starttls-credentials
;;       '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials
;;       (expand-file-name "~/.authinfo.gpg")
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587
;;       smtpmail-debug-info t)
)


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (cargo toml-mode racer rust-mode julia-repl elfeed-web elfeed-goodies ace-jump-mode simple-httpd elfeed-org noflet elfeed evil-multiedit org-category-capture org-mime dash-functional flyspell-popup evil-commentary xterm-color shell-pop org-ref pdf-tools key-chord ivy tablist multi-term helm-bibtex parsebib eshell-z eshell-prompt-extras esh-help biblio biblio-core yaml-mode web-mode tagedit slim-mode scss-mode sass-mode pug-mode less-css-mode helm-css-scss haml-mode emmet-mode company-web web-completion-data mu4e-maildirs-extension mu4e-alert ht yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode helm-pydoc cython-mode company-anaconda anaconda-mode pythonic powerline spinner ox-reveal alert log4e gntp org-plus-contrib markdown-mode hydra parent-mode projectile pkg-info epl request gitignore-mode flyspell-correct flx magit magit-popup git-commit with-editor smartparens iedit anzu evil goto-chg undo-tree highlight ctable ess julia-mode f s diminish pos-tip company bind-map bind-key yasnippet packed dash auctex helm avy helm-core async auto-complete popup auctex-latexmk csv-mode multiple-cursors ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline smeargle reveal-in-osx-finder restart-emacs rainbow-delimiters popwin polymode persp-mode pcre2el pbcopy paradox osx-trash osx-dictionary orgit org-projectile org-present org-pomodoro org-download org-bullets open-junk-file neotree move-text mmm-mode markdown-toc magit-gitflow macrostep lorem-ipsum linum-relative link-hint launchctl info+ indent-guide hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md fuzzy flyspell-correct-helm flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu ess-smart-equals ess-R-object-popup ess-R-data-view elisp-slime-nav dumb-jump company-statistics company-quickhelp company-auctex column-enforce-mode clean-aindent-mode auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
