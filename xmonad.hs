import XMonad

import XMonad.Layout.Spacing
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers

c_focused :: String
c_focused = "#e80400"

c_focused_window = "#ff6038"

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB
        (statusBarProp
            "xmobar-exe"
            (pure myXmobarPP)
        )
        defToggleStrutsKey
     $ def
  { terminal = "urxvt"
  , layoutHook =
      spacingRaw True (Border 5 0 5 5) True (Border 5 5 5 5) True
      $ myLayoutHook
  , normalBorderColor  = "#555555"
  , focusedBorderColor = c_focused
  }

myLayoutHook =
  Tall 1 (3/100) (1/2)
  ||| Mirror (Tall 1 (3/100) (3/5))
  ||| Full

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = grey " | "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Bottom" c_focused 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white "[") (white "]") . focusedWindow . ppWindow
    formatUnfocused = wrap (grey "[") (grey "]") . unfocused . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#777777" ""

    grey    = xmobarColor "#8a8a8a" ""
    focused = xmobarColor c_focused ""
    focusedWindow = xmobarColor c_focused_window ""
    unfocused = grey

