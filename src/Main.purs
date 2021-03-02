module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Effect.Ref as Ref
import Game.Domain (initialGame, updateCounter)
import Web.Event.EventTarget (addEventListener, eventListener)
import Web.HTML (window)
import Web.HTML.Event.EventTypes (click)
import Web.HTML.Window (toEventTarget)

main:: Effect Unit
main = do
  ref <- Ref.new initialGame
  target <- map toEventTarget window
  clickListener <-
    eventListener \e -> do 
      newVal <- Ref.modify updateCounter ref
      -- `modify_` updates the existing ref "in place"
      -- without returning a new one
      -- Ref.modify_ (\n -> n + 1 ) ref
      log $ show newVal
  addEventListener click clickListener true target
  

