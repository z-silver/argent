(define-module (argent packages clojure)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system clojure)
  #:use-module ((guix licenses) #:prefix license:))

(define-public clojure-dependency
  (package
    (name "clojure-dependency")
    (version "1.0.0")
    (home-page "https://github.com/stuartsierra/dependency")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url home-page)
                    (commit (string-append "dependency-" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1fwd7dlbinlm3shjkcji35ahxjgk9a1y0v00mm84fc3gx6a19kb5"))))
    (build-system clojure-build-system)
    (arguments
      `(#:doc-dirs '()
        #:source-dirs (list "src/")
        #:test-dirs (list "test/" "src/")))
    (synopsis "A data structure for representing dependency graphs in Clojure")
    (description "This library provides a basic implementation of a directed
acyclic graph (DAG) data structure, represented as a pair of maps.  It is
immutable and persistent.

Nodes in the graph may be any type which supports Clojure's equality semantics
such as keywords, symbols, or strings.")
    (license license:epl1.0)))

(define-public clojure-init
  (package
    (name "clojure-init")
    (version "0.2.96")
    (home-page "https://github.com/ferdinand-beyer/init")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url home-page)
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "13063mc17lwqpjk0k242z39zxh3f0fdmrizir0z0qigmq9fz0pcx"))))
    (build-system clojure-build-system)
    (propagated-inputs (list clojure-dependency))
    (arguments
      `(#:doc-dirs (list "doc/")
        #:source-dirs (list "src/")
        #:test-dirs (list "test/" "src/")))
    (synopsis "Dependency injection a la carte")
    (description "Init is a small Clojure framework for application
initialization and dependency injection.  It is heavily inspired by Integrant
and similar to Component, but also draws ideas from popular Java projects like
Dagger 2, Guice, Spring and CDI.")
    (license license:expat)))

(define-public clojure-clj-reload
  (package
    (name "clojure-clj-reload")
    (version "1.0.0")
    (home-page "https://github.com/tonsky/clj-reload")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url home-page)
                    (commit version)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1mv853qdflyh1dykgr2w49n68z6r6kqvafm3lwpd5c7fdwwli3va"))))
    (build-system clojure-build-system)
    (arguments
      `(#:doc-dirs '()
        #:source-dirs (list "src/")
        ;; FIXME: make tests actually work.
        #:tests? #f
        #:test-dirs (list "test/" "src/" "fixtures/keep_test/"
                          "fixtures/core_test/")
        #:test-exclude '(two-nses-second two-nses split o n no-unload m l i j
                         k f a g h d c e double b
                         clj-reload.dependency
                         clj-reload.keep-custom
                         clj-reload.keep-defprotocol
                         clj-reload.keep-defrecord
                         clj-reload.keep-deftype
                         clj-reload.keep-vars
                         clj-reload.keep-downstream
                         clj-reload.keep-upstream)))
    (synopsis "Smarter way to reload Clojure code")
    (description "Smarter way to reload Clojure code.  Clj-Reload tracks
namespace dependencies, unloads namespaces, and then loads them in the correct
topological order.

This is only about namespace dependencies within a single project.  It has
nothing to do with Leiningen, Maven, JAR files, or repositories.")
    (license license:expat)))

(define-public clojure-dirwatch
  (package
    (name "clojure-dirwatch")
    (version "0.2.5")
    (home-page "https://github.com/juxt/dirwatch")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url home-page)
                    (commit version)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "06qrzg9mq2ca2lylsnjhb3a73zg2f1xzras5mydl6z8ib2y5fixy"))))
    (build-system clojure-build-system)
    (arguments
      `(#:doc-dirs '()
        #:source-dirs (list "src/")
        #:test-dirs (list "test/")))
    (synopsis "A Clojure directory watcher, wrapping the JDK 7 java.nio.file.WatchService.")
    (description "Watch directories for changes.

Similar to watchtower (but uses JDK 7 async notification mechanisms rather than polling)

Similar to ojo (but simpler, unlimited watchers allowed and directory recursive)")
    (license license:epl1.0)))

(define-public clojure-clj-reinit
  (package
    (name "clojure-clj-reinit")
    (version "0.2.0")
    (home-page "https://github.com/z-silver/clj-reinit")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url home-page)
                    (commit version)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0jzxa2rmlh427kbdsp7mwah9y3k0csmdh2ll94qifm9yz72snzy0"))))
    (build-system clojure-build-system)
    (propagated-inputs (list clojure-init clojure-clj-reload clojure-dirwatch))
    (arguments
      `(#:doc-dirs '()
        #:source-dirs (list "src/")
        #:test-dirs '()))
    (synopsis "Reloaded workflow using clj-reload and init")
    (description "clj-reinit is to clj-reload/init as integrant-repl is to tools.namespace/integrant.

Except it's way cooler.")
    (license license:unlicense)))
