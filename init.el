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
     yaml
     html
     python
     csv
     emacs-lisp
     osx
     git
     markdown
     (org :variables org-enable-reveal-js-support t)
     (spell-checking :variables enable-flyspell-auto-completion t)
     evil-commentary
     x-org
     ess
     bibtex
     pdf-tools
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
     )

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
              ))



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
          "latexmk -pdflatex='pdflatex -shell-escape -interaction nonstopmode' -pdf -f  %f")
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

  (setq org-latex-pdf-process '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                                "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

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

  ;; extra outline headers
  (setq TeX-outline-extra
        '(("%preamble" 1)
          ("%chapter" 2)
          ("%section" 3)
          ("%subsection" 4)
          ("%subsubsection" 5)
          ("%paragraph" 6)))

  ;; add font locking to the headers
  (font-lock-add-keywords
   'latex-mode
   '(("^%\\(chapter\\|\\(sub\\|subsub\\)?section\\|paragraph\\)"
      0 'font-lock-keyword-face t)
     ("^%preamble{\\(.*\\)}"       1 'font-latex-sectioning-1-face t)
     ("^%chapter{\\(.*\\)}"       1 'font-latex-sectioning-1-face t)
     ("^%section{\\(.*\\)}"       1 'font-latex-sectioning-2-face t)
     ("^%subsection{\\(.*\\)}"    1 'font-latex-sectioning-3-face t)
     ("^%subsubsection{\\(.*\\)}" 1 'font-latex-sectioning-4-face t)
     ("^%paragraph{\\(.*\\)}"     1 'font-latex-sectioning-5-face t)))



  ;; Use pdf-tools to open PDF files

  ;; add "PDF Tools" to the list of possible PDF tools

    ;; (unless (assoc "PDF Tools" TeX-view-program-list-builtin)
    ;;   (push '("PDF Tools" TeX-pdf-tools-sync-view) TeX-view-program-list))
  ;; (push '("PDF Tools" TeX-pdf-tools-sync-view) TeX-view-program-list)
  ;; (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
  ;;       TeX-source-correlate-start-server t)
  ;; Update PDF buffers after successful LaTeX runs
  (add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
            'TeX-revert-document-buffer)


  ;; (setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
  ;; (setq TeX-view-program-list
  ;;       '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))


  (with-eval-after-load 'yasnippet
    (setq yas-snippet-dirs (remq 'yas-installed-snippets-dir yas-snippet-dirs)))

  (setq-default
   ;; Break lines at specified column (<= 80, defaults 72)
   fill-column 72
   ;; Turns on auto-fill-mode to automatically break lines
   auto-fill-function 'do-auto-fill
   )


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
    (xterm-color shell-pop multi-term eshell-z eshell-prompt-extras esh-help org-ref pdf-tools key-chord ivy tablist helm-bibtex parsebib biblio biblio-core flyspell-popup evil-commentary yaml-mode web-mode tagedit slim-mode scss-mode sass-mode pug-mode less-css-mode helm-css-scss haml-mode emmet-mode company-web web-completion-data mu4e-maildirs-extension mu4e-alert ht yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode helm-pydoc cython-mode company-anaconda anaconda-mode pythonic powerline spinner ox-reveal alert log4e gntp org-plus-contrib markdown-mode hydra parent-mode projectile pkg-info epl request gitignore-mode flyspell-correct flx magit magit-popup git-commit with-editor smartparens iedit anzu evil goto-chg undo-tree highlight ctable ess julia-mode f s diminish pos-tip company bind-map bind-key yasnippet packed dash auctex helm avy helm-core async auto-complete popup auctex-latexmk csv-mode multiple-cursors ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline smeargle reveal-in-osx-finder restart-emacs rainbow-delimiters popwin polymode persp-mode pcre2el pbcopy paradox osx-trash osx-dictionary orgit org-projectile org-present org-pomodoro org-download org-bullets open-junk-file neotree move-text mmm-mode markdown-toc magit-gitflow macrostep lorem-ipsum linum-relative link-hint launchctl info+ indent-guide hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md fuzzy flyspell-correct-helm flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu ess-smart-equals ess-R-object-popup ess-R-data-view elisp-slime-nav dumb-jump company-statistics company-quickhelp company-auctex column-enforce-mode clean-aindent-mode auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
