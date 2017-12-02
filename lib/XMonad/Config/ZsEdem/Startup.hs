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
          , "xss-lock -n 'notify-send \"locking screen\"' ~/lock.sh"
          , "xset s 160 5"
          , "nm-applet"]
  where
        execOnce = spawn . ("exec "++)
