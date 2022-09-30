import XMonad

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers

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
  { terminal = "urxvt -e /usr/bin/fish"
  }

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = grey " | "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . focused . ppWindow
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
    lowWhite = xmobarColor "#bbbbbb" ""

    grey    = xmobarColor "#8a8a8a" ""
    focused = xmobarColor "#ff6038" ""
    unfocused    = grey

