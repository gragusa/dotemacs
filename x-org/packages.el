(setq x-org-packages
    '(
      (org :location built-in)
      ))

(defun x-org/post-init-org ()
  (setq org-modules (quote (org-protocol)))
  (require 'org-protocol)

;; the rest of my org mode config
)
