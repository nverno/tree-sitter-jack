((nil
                                       .
  ((projectile-project-type            . npm)
   (projectile-compile-use-comint-mode . t)
   (projectile-project-test-cmd        . "npm test")
   (projectile-project-run-cmd         . "npm run parse")
   (projectile-project-compilation-cmd . "npm run build")))
 ("test" (text-mode
          (indent-line-function        . indent-relative)
          (tab-width                   . 2))))
