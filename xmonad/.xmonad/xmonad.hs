-- default desktop configuration for Fedora

import System.Posix.Env (getEnv)
import Data.Maybe (maybe)

import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Config.Kde
import XMonad.Config.Xfce
import XMonad.Layout.NoBorders
import XMonad.Actions.PhysicalScreens
import XMonad.Layout.IndependentScreens
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Hooks.SetWMName

-- main = do
--      session <- getEnv "DESKTOP_SESSION"
--      xmonad  $ maybe desktopConfig desktop session

main = xmonad $ gnomeConfig {
  keys = myKeys <+> keys gnomeConfig
  , startupHook = setWMName "LG3D"
  , workspaces = withScreens 2 ["web", "email", "irc"] }
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  [((modm .|. mask, key), f sc)
    | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    , (f, mask) <- [(viewScreen, 0), (sendToScreen, shiftMask)]]

  ++

  [((m .|. modm, k), windows $ onCurrentScreen f i)
     | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
     , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

desktop "gnome" = gnomeConfig
desktop "kde" = kde4Config
desktop "xfce" = xfceConfig
desktop "xmonad-gnome" = gnomeConfig
desktop _ = desktopConfig
