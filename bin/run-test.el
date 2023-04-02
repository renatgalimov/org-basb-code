;;; run-test.el ---
;;
;; Filename: run-test.el
;; Description:
;; Author: Renat Galimov
;; Maintainer:
;; Created: Wed Apr 20 20:03:20 2022 (+0300)
;; Version:
;; Package-Requires: ()
;; Last-Updated:
;;           By:
;;     Update #: 30
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(set-binary-mode 'stdout nil)
(set-binary-mode 'stderr nil)

(require 'org)
;; Check that directory exists
(unless (file-exists-p "~/emacs/")
  (mkdir "~/emacs/"))
(setq straight-enable-use-package-integration nil)
(setq straight-use-package-by-default nil)
(setq straight-vc-git-default-clone-depth 1)
(setq org-basb-code-file "~/emacs/CODE.el")

(org-babel-tangle-file "./README.org" "~/emacs/CODE.el")
(load-file "~/emacs/CODE.el")
(with-current-buffer "*straight-process*"
  (print (buffer-substring-no-properties (point-min) (point-max))))

(unless (and (featurep 'org-ql) (fboundp 'org-ql-view))
  (error "org-ql is not installed properly"))

(pdf-info-check-epdfinfo)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; run-test.el ends here
