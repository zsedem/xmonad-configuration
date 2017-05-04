module XMonad.Config.ZsEdem.Startup(startupHook) where
import           XMonad                 (X, spawn)
import           XMonad.Hooks.SetWMName (setWMName)
import           XMonad.Util.Run        (runProcessWithInput)

startupHook :: X ()
startupHook = do
    setWMName "LG3D"
    mapM_ execOnce
          [ "xsetroot -cursor_name left_ptr"
          , "nitrogen --restore"
          , "dunst -conf ~/.dunstrc"
          , "nm-applet"]
  where
        execOnce = spawn . ("exec "++)
