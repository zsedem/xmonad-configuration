{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Main(main) where
import           System.Directory                 (getHomeDirectory)
import           Data.Default                     (def)
import           XMonad
import           XMonad.Config.Xfce
import           XMonad.Config.ZsEdem             (themeColor)
import qualified XMonad.Config.ZsEdem             as ZsEdem
import           XMonad.Hooks.EwmhDesktops        (ewmh)
import           XMonad.Hooks.ManageDocks         (docks, avoidStruts)
import           XMonad.Layout.NoBorders          (smartBorders)
import           XMonad.Layout.Spacing            (spacing)
import           XMonad.Layout.WindowNavigation   (windowNavigation)
import           XMonad.Util.EZConfig             (additionalKeys)
import           XMonad.Layout.Tabbed             (tabbed, shrinkText)


layoutHook' = smartBorders $ avoidStruts $ windowNavigation (
                      tabbed shrinkText ZsEdem.theme |||
                      Full |||
                      tall |||
                      Mirror tall )
        where
            tall = spacing 5 $ Tall 1 (3/100) (2/3)

main = do
    homePath <- (++"/")<$> getHomeDirectory
    let desktopConfig =  xfceConfig
    xmonad $ ewmh $ docks $ desktopConfig
     { manageHook = ZsEdem.manageHook <+> manageHook desktopConfig
     , layoutHook = layoutHook'
     , modMask = mod4Mask
     , workspaces = ZsEdem.workspaces
     , focusFollowsMouse  = False
     , clickJustFocuses   = False
     , terminal = "st -f 'Monofur for Powerline:size=19'"
     , focusedBorderColor = themeColor
     , normalBorderColor = "#424242"
     , borderWidth = 2
     , startupHook = startupHook desktopConfig >> ZsEdem.startupHook
     } `additionalKeys` ZsEdem.keyBindings

