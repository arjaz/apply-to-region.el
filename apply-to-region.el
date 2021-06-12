;;; apply-to-region --- Apply to region
;;; -*- lexical-binding: t; -*-

;;; Commentary:
;;; Some QoL functions for me

;;; Code:

(require 'subr-x)

(defun apply-to-region (start end)
  "Read a sexp and apply it to each line in the region between START and END.
The sexp can be either a symbol or an s-expression with IT being the line."
  (interactive "r")
  (let* ((expr (read-minibuffer "Eval: "))
         (func (if (symbolp expr)
                   expr
                   `(lambda (it) ,expr))))
    (replace-region-contents
     start
     end
     #'(lambda ()
         (let* ((text (buffer-substring-no-properties start end))
                (lines (split-string text "\n" nil nil))
                (modded (mapconcat func lines "\n")))
           modded)))))

(provide 'apply-to-region)
;;; apply-to-region.el ends here
