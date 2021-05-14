module Assets.Images where

-- TODO: refactor to use custom type instead of string
backgrounds :: { plain :: { key :: String
           , path :: String
           }
, sunset :: { key :: String
            , path :: String
            }
}
backgrounds =
  { sunset: { key: "backgrounds/sunset", path: "assets/backgrounds/sunset.svg" }
  , plain: { key: "backgrounds/plain", path: "assets/backgrounds/plain.svg" }
  }

ui :: { button :: { key :: String, path :: String } }
ui =
  { button: { key: "ui/button", path: "assets/ui/button.png" }
  }
