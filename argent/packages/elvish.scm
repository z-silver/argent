(define-module (argent packages elvish)
  #:use-module (guix build-system go)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages golang-build)
  #:use-module (gnu packages golang-web)
  #:use-module (gnu packages golang-xyz))

(define-public go-pkg-nimblebun-works-go-lsp
  (package
    (name "go-pkg-nimblebun-works-go-lsp")
    (version "1.1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nimblebun/go-lsp")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "14hdbk0h85930phnsih5k33dj2qx9b3j4vvsf24g6v3qqjvbp54q"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "pkg.nimblebun.works/go-lsp"))
    (home-page "https://pkg.nimblebun.works/go-lsp")
    (synopsis "Language Server Protocol types for Go")
    (description
     "Package lsp contains type definitions and documentation for the Language Server
Protocol.")
    (license license:expat)))

(define-public go-github-com-elves-elvish
  ;; TODO: add build variant
  (package
    (name "elvish")
    (version "0.21.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/elves/elvish")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1yrah4xbm8jsmr578676bd0yq1n3dc6ahs0hav6csnl7739jpags"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "src.elv.sh/cmd/elvish"
      #:unpack-path "src.elv.sh"))
    (propagated-inputs (list go-pkg-nimblebun-works-go-lsp
                             go-golang-org-x-sys
                             go-golang-org-x-sync
                             go-go-etcd-io-bbolt
                             go-github-com-sourcegraph-jsonrpc2
                             go-github-com-mattn-go-isatty
                             go-github-com-google-go-cmp
                             go-github-com-creack-pty))
    (home-page "https://github.com/elves/elvish")
    (synopsis
     "Elvish: Friendly Interactive Shell and Expressive Programming Language")
    (description
     "Elvish is a cross-platform shell, supporting Linux, BSDs and Windows.  It
features an expressive programming language, with features like namespacing and
anonymous functions, and a fully programmable user interface with friendly
defaults.  It is suitable for both interactive use and scripting.")
    ;; From the README:
    ;; All source files use the BSD 2-clause license (see LICENSE), except for
    ;; the following:

    ;; Files in pkg/diff and pkg/rpc are released under the BSD 3-clause
    ;; license, since they are derived from Go's source code. See
    ;; pkg/diff/LICENSE and pkg/rpc/LICENSE.

    ;; Files in pkg/persistent and its subdirectories are released under EPL
    ;; 1.0, since they are partially derived from Clojure's source code. See
    ;; pkg/persistent/LICENSE.

    ;; Files in pkg/md/spec are released under the Creative Commons CC-BY-SA
    ;; 4.0 license, since they are derived from the CommonMark spec. See
    ;; pkg/md/spec/LICENSE.
    (license (list license:bsd-2
                   license:bsd-3
                   license:epl1.0
                   license:cc-by-sa4.0))))
