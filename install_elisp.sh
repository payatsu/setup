#!/bin/sh -e

emacs -Q --batch \
--eval '(require '\''package)' \
--eval '(add-to-list '\''package-archives '\''("melpa" . "https://melpa.org/packages/"))' \
--eval '(package-initialize)' \
--eval '(package-refresh-contents)' \
--eval '(package-install '\''company)' \
--eval '(package-install '\''company-quickhelp)' \
--eval '(package-install '\''yasnippet)' \
--eval '(package-install '\''irony)' \
--eval '(package-install '\''flycheck)'
