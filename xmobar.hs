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
        [ Run $ XMonadLog
        -- , Run $ Kbd [] -- Not sure if working?
        , Run $ DiskU [("/", "<fn=1>\xf0c7</fn> hdd <free> free")] [] 60
        , Run $ Date "<fn=1>\xf073</fn> %Y-%m-%_d <fc=#ee9a00>%H:%M:%S</fc>" "date" 10
        , Run $ Cpu ["-t", "<fn=1>\xf108</fn> cpu (<total>%)","-H","50","--high","red"] 20
        , Run $ Memory ["-t", "<fn=1>\xf233</fn> mem <used>M (<usedratio>%)"] 20

        ]
    , template =
      " <fn=1>\xe61f</fn> %XMonadLog%"
      ++ "}{"
      ++ "%date% | %disku% | %cpu% | %memory% "
    , alignSep = "}{"
    }

main :: IO ()
main = xmobar config
