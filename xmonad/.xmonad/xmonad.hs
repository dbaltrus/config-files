import System.Posix.Env (getEnv)

import XMonad
import XMonad.Config.Gnome (gnomeConfig)
import XMonad.Actions.CopyWindow (copy, kill1)
import XMonad.Actions.PhysicalScreens (sendToScreen, viewScreen)
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.IndependentScreens (onCurrentScreen, withScreens, workspaces')
import XMonad.StackSet (shift, view)
import XMonad.Util.EZConfig (additionalKeys)


workspaceControls conf =
  let mod = modMask conf in [
      ((mod .|. mask, key), windows $ onCurrentScreen function workspace) |
        (workspace, key) <- zip (workspaces' conf) [xK_1 ..],
        (function, mask) <- [
          (view, 0),
          (shift, XMonad.shiftMask),
          (copy, XMonad.shiftMask XMonad..|. XMonad.controlMask)
        ]
    ] ++ [
      ((mod XMonad..|. XMonad.shiftMask, XMonad.xK_c), kill1)
    ]

screenControls conf =
  let mod = modMask conf in [
      ((mod .|. mask, key), function screen) |
        (screen, key) <- zip [0 ..] [xK_w, xK_e],
        (function, mask) <- [
            (viewScreen, 0),
            (sendToScreen, shiftMask)
          ]
    ]

soundControls :: [((ButtonMask, KeySym), X ())]
soundControls = [
    ((0, 0x1008ff11), spawn "amixer set Master 3%-"),
    ((0, 0x1008ff12), spawn "amixer set Master toggle"),
    ((0, 0x1008ff13), spawn "amixer set Master 3%+")
  ]

baseHomeConfig = defaultConfig {
    terminal = "termite",
    --XMonad.modMask = XMonad.mod4Mask,
    startupHook = do
      spawn "/home/db/.xmonad/background-clock.sh"
      spawn "/home/db/.xmonad/go-to-bed.sh",
    workspaces = withScreens 1 $ map show [1 .. 9]
  }

homeConfig = baseHomeConfig `additionalKeys` (soundControls ++ workspaceControls baseHomeConfig)

baseWorkConfig = gnomeConfig {
    startupHook = setWMName "LG3D" -- Make swing play nice with XMonad.
  }

workConfig = baseWorkConfig `additionalKeys` (workspaceControls gnomeConfig ++ screenControls gnomeConfig)

main = do
  env <- getEnv "DESKTOP_SESSION"
  setup env
    where
      setup (Just "gnome") = xmonad workConfig
      setup _              = xmonad homeConfig

