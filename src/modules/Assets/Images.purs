module Assets.Images where

backgrounds :: { sunset :: { key :: String, path :: String } }
backgrounds =
  { sunset:
      { key: "backgrounds/sunset", path: "assets/backgrounds/sunset.svg" }
  }

ui :: { button :: { key :: String, path :: String } }
ui =
  { button: { key: "ui/button", path: "assets/ui/button.png" }
  }
