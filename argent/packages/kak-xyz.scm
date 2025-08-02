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

(define-public kak-enluarada
  (let ((commit "a50a78fa8cf1065f83e58a7d06dc38c204027f43")
        (revision "0"))
    (package
      (name "kak-enluarada")
      (version (git-version "0.0.0" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/gustavo-hms/enluarada")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "0naqhzyxr3fy6afalxb1s61lmmi0qy87vwa8pgas75fi73aw91fz"))))
      (build-system copy-build-system)
      (propagated-inputs (list kak-luar))
      (arguments
        (list #:install-plan
              #~'(("./" "share/kak/autoload/plugins/enluarada/"))))
      (home-page "https://github.com/gustavo-hms/enluarada")
      (synopsis "A collection of Lua scripts for Kakoune")
      (description "A collection of Lua scripts for Kakoune.

This repository contains many small scripts created using the luar plugin for
Kakoune.  Since individually they don't make a full-fledged plugin, they are
put together here.  Despite their simplicity, they are useful after all.

Since these scripts are heterogeneous, providing solutions for different tasks,
it can happen that you are only interested in a subset of them.  Thus, each
group of scripts is wrapped inside its own module.  This way you can load only
those useful for you.  See the README on each subdirectory for more details.")
      (license license:gpl3))))

(define-public kak-sal
  (let ((commit "2744bc56dc9d683009498c9e46b11a4c799adf40")
        (revision "0"))
    (package
      (name "kak-sal")
      (version (git-version "0.0.0" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/z-silver/sal.kak")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "136zm1mv6bc7s3fny4ilf1xfb3kqa94gc3yd531sgc1d4mga6dqd"))))
      (build-system copy-build-system)
      (arguments
        (list #:install-plan
              #~'(("./" "share/kak/autoload/plugins/sal.kak/"))))
      (home-page "https://github.com/z-silver/sal.kak")
      (synopsis "Sal syntax highlighting for Kakoune")
      (description "Syntax highlighting for Sal.

Expect this to change somewhat frequently as the language evolves.")
      (license license:unlicense))))

(define-public kak-git-mode
  (let ((commit "a549d5742b1efd85cd122360f7d87689fc649316")
        (revision "0"))
    (package
      (name "kak-git-mode")
      (version (git-version "0.0.0" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/jordan-yee/kakoune-git-mode")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "1xw10287b73rc09f5744bz8lfcbhak52d76b3bzly030z2xda1d2"))))
      (build-system copy-build-system)
      (arguments
        (list #:install-plan
              #~'(("./" "share/kak/autoload/plugins/kakoune-git-mode/"))))
      (home-page "https://github.com/jordan-yee/kakoune-git-mode")
      (synopsis "Kakoune plugin providing improved git interaction")
      (description "Kakoune plugin providing improved Git interaction.

Mainly, this plugin provides a pre-configured set of mappings for the built-in
:git commands, with some extended functionaly.")
      (license license:unlicense))))

(define-public kak-tug
  (let ((commit "23adaadb795af2d86dcb3daf7af3ebe12e932441")
        (revision "0"))
    (package
      (name "kak-tug")
      (version (git-version "0.0.0" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/matthias-margush/tug")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "0qldzh3gr3m7sa1hibbmf1br5lgiqwn84ggm75iin113zc67avbi"))))
      (build-system copy-build-system)
      (arguments
        (list #:install-plan
              #~'(("rc/" "share/kak/autoload/plugins/tug/"))))
      (home-page "https://github.com/matthias-margush/tug")
      (synopsis "Unix commands for the kakoune editor")
      (description "Unix commands for the kakoune editor")
      (license license:unlicense))))

(define-public kak-clipb
  (let ((commit "b640b2324ef21630753c4b42ddf31207233a98d2")
        (revision "0"))
    (package
      (name "kak-clipb")
      (version (git-version "0.0.0" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/NNBnh/clipb.kak")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "1rs9ilzpl3pp0rm8ljcf5kp1vbw1f7wa62079d2971mg45jj46ib"))))
      (build-system copy-build-system)
      (arguments
        (list #:install-plan
              #~'(("./" "share/kak/autoload/plugins/clipb.kak/"))))
      (home-page "https://github.com/NNBnh/clipb.kak")
      (synopsis "Clipboard managers warper for Kakoune")
      (description "clipb.kak is a clipboard integration for Kakoune, an
extremely stripped down fork of Zach Peltzer's Kakboard with some design
improvements.")
      (license (list license:expat license:gpl3))))
