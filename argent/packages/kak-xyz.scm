(define-module (argent packages kak-xyz)
  #:use-module (gnu packages lua)
  #:use-module (guix build-system gnu)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:))

(define-public kak-rainbow
  (let ((commit "9c3d0aa62514134ee5cb86e80855d9712c4e8c4b")
        (revision "0"))
    (package
      (name "kak-rainbow-bodhizafa")
      (version (git-version "0.0.0" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/Bodhizafa/kak-rainbow")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "0mqghysiwi1h0hx96c7bq0a16yrxh65f3v8bqqn5bh9x1zh2l9mg"))))
      (build-system copy-build-system)
      (arguments
        (list #:install-plan
              #~'(("./" "share/kak/autoload/plugins/kak-rainbow/"))))
      (home-page "https://github.com/Bodhizafa/kak-rainbow")
      (synopsis "Cursor-centered rainbow highlighter for kakoune")
      (description "A cursor-centered rainbow highlighter for kakoune.  Handles
different styles of enclosing characters independently, so adding parens
doesn't change the colors of braces, etc.")
      (license license:expat))))

(define-public kak-luar
  (let ((commit "e32ac89fdc43e5dbd8750d55cbcf1aea66d3ebdf")
        (revision "0"))
    (package
      (name "kak-luar")
      (version (git-version "0.0.0" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/gustavo-hms/luar")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "1y6bksqvlsj8wx42figfc60qk2d9vs6kij4mzaxv5gywrzfiwghz"))))
      (build-system copy-build-system)
      (propagated-inputs (list lua fennel))
      (arguments
        (list #:install-plan
              #~'(("./" "share/kak/autoload/plugins/luar/"))))
      (home-page "https://github.com/gustavo-hms/luar")
      (synopsis "Script Kakoune using Lua")
      (description "Luar is a minimalist plugin to script Kakoune using either Lua
or Fennel.  It's not designed to expose Kakoune's internals like Vis or Neovim
do.  Instead, it's conceived with Kakoune's extension model in mind.  It does
so by defining a sole lua command which can execute whatever string is passed
to it in an external lua interpreter, and an equivalent fennel command which
executes whatever string is passed to it in an external fennel interpreter.  By
doing so, it can act as a complement for the %sh{} expansion when you need to
run some logic inside Kakoune.")
      (license license:lgpl3))))

(define-public kak-peneira
  (let ((commit "b56dd10bb4771da327b05a9071b3ee9a092f9788")
        (revision "0"))
    (package
      (name "kak-peneira")
      (version (git-version "0.0.0" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/gustavo-hms/peneira")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "0hkra2fnrk7bj6rry4nc6sld1wc36001hyirkagsfs9x9gx5k45d"))))
      (build-system copy-build-system)
      (propagated-inputs (list kak-luar))
      (arguments
        (list #:install-plan
              #~'(("./" "share/kak/autoload/plugins/peneira/"))))
      (home-page "https://github.com/gustavo-hms/peneira")
      (synopsis "A fuzzy finder crafted for Kakoune")
      (description "Peneira is a fuzzy finder for the Kakoune editor.  You can
use it to write custom filters for candidates lists.  You can also use its
built-in filters, that allow you to select files in a directory, symbols in the
current document, an so on.")
      (license license:lgpl2.1))))

(define-public kak-peneira-filters
  (let ((commit "b7ff4e344b9ee5f66d55e9c433f309c71ca4b707")
        (revision "1"))
    (package
      (name "kak-peneira-filters")
      (version (git-version "0.0.0" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://codeberg.org/mbauhardt/peneira-filters")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "03g24pr8hm5vs5la541fh6vzfrhg0g999vn2xsm9n3z7zbxg44n3"))))
      (build-system copy-build-system)
      (propagated-inputs (list kak-peneira))
      (arguments
        (list #:install-plan
              #~'(("./" "share/kak/autoload/plugins/peneira-filters/"))))
      (home-page "https://codeberg.org/mbauhardt/peneira-filters")
      (synopsis "Additional custom filters for the kakoune plugin gustavo-hms/peneira")
      (description "Additional custom filters for the kakoune plugin gustavo-hms/peneira.")
      (license license:expat))))
