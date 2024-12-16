import Xmobar

config :: Config
config =
  defaultConfig
    { font = "xft:Hasklig Regular 9"
    , additionalFonts =
        [ "xft:DejaVuSansM Nerd Font:style=Book:pixelsize=18"
        ]
    , allDesktops = True
    , alpha = 220
    , position = BottomH 28
    , commands =
        [ Run $ XMonadLog
        -- , Run $ Kbd [] -- Not sure if working?
        , Run $ DiskU [("/", "<fn=1>\xf0c7</fn>  hdd <free> free")] [] 60
        , Run $ Date "<fn=1>\xf073</fn>  %Y-%m-%d %H:%M:%S" "date" 10
        , Run $ Cpu ["-t", "<fn=1>\xf108</fn>  cpu (<total>%)","-H","50","--high","red"] 20
        , Run $ Memory ["-t", "<fn=1>\xf233</fn>  mem <used>M (<usedratio>%)"] 20
        ]
    , template =
      " <fn=1>\xe61f</fn> %XMonadLog%"
      ++ "}{"
      ++ "<fc=#75caff>%date%</fc> | <fc=#10eb59>%disku%</fc> | <fc=#ffd026>%cpu%</fc> | <fc=#ff6038>%memory%</fc> "
    , alignSep = "}{"
    , border = TopB
    , borderColor = "#444444"
    , borderWidth = 1
    }

main :: IO ()
main =
  xmobar config
