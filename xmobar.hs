import Xmobar

config :: Config
config =
  defaultConfig
    { font = "xft:Source Code Pro:style=Regular:pixelsize=12"
    , additionalFonts =
        [ "xft:DejaVuSansMono Nerd Font:style=Book:pixelsize=24"
        ]
    , allDesktops = True
    , alpha = 200
    , position = Bottom
    , commands =
        [ Run $ XMonadLog,
          Run $ Memory ["t", "Mem: <usedratio>%"] 10,
          Run $ Kbd [],
          Run $ Date "%a %_d %b %Y <fc=#ee9a00>%H:%M:%S</fc>" "date" 10
        ]
    , template = "%XMonadLog% } <fn=1>\xe61f</fn> weow { %kbd% | %date% | %memory%"
    , alignSep = "}{"
    }

main :: IO ()
main = xmobar config
