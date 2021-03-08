{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "my-project"
, dependencies =
  [ "aff"
  , "canvas"
  , "console"
  , "debug"
  , "effect"
  , "ordered-collections"
  , "psci-support"
  , "quickcheck"
  , "refs"
  , "signal"
  , "st"
  , "transformers"
  , "web-dom"
  , "web-events"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
