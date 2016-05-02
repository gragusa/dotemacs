;;; packages.el --- polymode layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Walmes Zeviani & Fernando Mayer
;; URL: https://github.com/syl20bnr/spacemacs

;;; Code:

(defconst polymode-packages
  '(polymode))

(defun polymode/init-polymode ()
  (use-package polymode
    :mode (("\\.[rR]md" . Rmd-mode))
    :mode (("\\.[jJ]md" . poly-markdown-mode))
    :init
    (progn
      (defun Rmd-mode ()
        "ESS Markdown mode for Rmd files"
        (interactive)
        (require 'poly-R)
        (require 'poly-markdown)
        (R-mode)
        (poly-markdown+r-mode))
      ))
    (with-eval-after-load 'polymode
	(define-polymode poly-markdown+julia-mode pm-poly/markdown :lighter " PM-jmd"))
  )

;;; packages.el ends here
