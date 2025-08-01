(define-module (argent packages zig-xyz)
  #:use-module (gnu packages zig)
  #:use-module (guix build-system zig)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages))

(define-public zig-datetime
  (package
    (name "zig-datetime")
    (version "0.14.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/clickingbuttons/datetime")
               (commit "8ad66223b061cc527749c2eae650de7a10da765d")))
        (file-name (git-file-name name version))
        (sha256
          (base32 "150iy4dw1vl344wllblhl2f1ijxl7rhmmmqvf24gyr62xzk4y8rj"))))
    (build-system zig-build-system)
    (arguments (list #:zig zig-0.14 #:skip-build? #t))
    (synopsis "Generic Date, Time, and DateTime library.")
    (description "Generic Date, Time, and DateTime library.")
    (home-page "https://github.com/clickingbuttons/datetime")
    (license license:expat)))

(define-public timez
  (let ((commit "751d31f789ce554f0684c02759c3747101dc3e20")
        (revision "0"))
    (package
      (name "timez")
      (version (git-version "0.0.1" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/z-silver/timez")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "0v5vxcnc7qczn26lsi7swncg2pf8hcwl2bq4yskfddd4k0cr0a4q"))))
      (build-system zig-build-system)
      (arguments
        (list
          #:zig zig-0.14
          #:install-source? #f
          #:zig-release-type "small"))
      (inputs (list zig-datetime))
      (synopsis "Work time reporting tool")
      (description "A tool to help generate work time reports at the end of the month.")
      (home-page "https://github.com/z-silver/timez")
      (license license:unlicense))))

(define-public poop
  (let ((commit "e283827410e2caf751ce8f38d2ff5c217e1ce4cd")
        (revision "0"))
    (package
      (name "poop")
      (version (git-version "0.5.0" revision commit))
      (source
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/andrewrk/poop")
                 (commit commit)))
          (file-name (git-file-name name version))
          (sha256
            (base32 "0ib0rzb0fygbxpaqdigl73mimi5c44rczv95qb3xp2jfk6lavgrc"))))
      (build-system zig-build-system)
      (arguments
        (list
          #:zig zig-0.14
          #:install-source? #f
          #:zig-release-type "fast"
          #:zig-build-flags ''("-Dstrip")
          #:phases
          #~(modify-phases %standard-phases
              (delete 'check))))
      (synopsis "Performance Optimizer Observation Platform")
      (description "This command line tool uses Linux's perf_event_open functionality
to compare the performance of multiple commands with a colorful terminal user
interface.")
      (home-page "https://github.com/andrewrk/poop")
      (license license:expat))))
