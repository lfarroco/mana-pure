module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Effect.Ref as Ref
import Web.Event.EventTarget (addEventListener, eventListener)
import Web.HTML (window)
import Web.HTML.Event.EventTypes (click)
import Web.HTML.Window (toEventTarget)

main:: Effect Unit
main = do
  ref <- Ref.new 0
  target <- map toEventTarget window
  clickListener <-
    eventListener \e -> do 
      newVal <- Ref.modify (\n -> n + 1 ) ref
      -- `modify_` updates the existing ref "in place"
      -- without returning a new one
      -- Ref.modify_ (\n -> n + 1 ) ref
      log $ show newVal
  addEventListener click clickListener true target
  

