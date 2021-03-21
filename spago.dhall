{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "mana-pure"
, dependencies =
  [ "aff"
  , "canvas"
  , "console"
  , "debug"
  , "effect"
  , "matrices"
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
  , "purescript-astar"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
