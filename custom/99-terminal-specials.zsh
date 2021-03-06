# Terminal output control (http://www.termsys.demon.co.uk/vtansi.htm)
tc='\e['

# Colors and styles (based on https://github.com/demure/dotfiles/blob/master/subbash/prompt)

bold="${tc}1m"        # Bold text only, keep colors
underline="${tc}4m"   # Underline text only, keep colors
inverse="${tc}7m"     # Inverse: swap background and foreground colors
regular="${tc}22;24m" # Regular text only, keep colors
nofg="${tc}39m"       # Regular foreground coloring
nobg="${tc}49m"       # Regular background coloring
nostyle="${tc}0m"     # Reset all coloring and style

# Basic            High Intensity      Background           High Intensity Background
black="${tc}30m";  iblack="${tc}90m";  onblack="${tc}40m";  oniblack="${tc}100m";
red="${tc}31m";    ired="${tc}91m";    onred="${tc}41m";    onired="${tc}101m";
green="${tc}32m";  igreen="${tc}92m";  ongreen="${tc}42m";  onigreen="${tc}102m";
yellow="${tc}33m"; iyellow="${tc}93m"; onyellow="${tc}43m"; oniyellow="${tc}103m";
blue="${tc}34m";   iblue="${tc}94m";   onblue="${tc}44m";   oniblue="${tc}104m";
purple="${tc}35m"; ipurple="${tc}95m"; onpurple="${tc}45m"; onipurple="${tc}105m";
cyan="${tc}36m";   icyan="${tc}96m";   oncyan="${tc}46m";   onicyan="${tc}106m";
white="${tc}37m";  iwhite="${tc}97m";  onwhite="${tc}47m";  oniwhite="${tc}107m";

color_pallete() {
    (
    local text="${1=Colouring}"
    local padding=${#text}

    local colors="black red green yellow blue purple cyan white"
    local styles="bold underline"

    # ${(s: :)var} splits var into lines where a ' ' (space) is found
    # ${(r:number:)var} makes the output into number columns, creating a padding to the right if necessary
    # ${(l:number:)var} makes the output into number columns, creating a padding to the left if necessary

    echo "${bold}${white}Color pallete${nostyle}"
    echo
    echo "The name of the columns/rows are the name of the actual variables"
    echo "For example, to print ${bold}${red}${onwhite}this text${nostyle}, use:" '${bold}${red}${onwhite}this text${nostyle}'
    echo
    echo "A color with the 'i' prefix means 'intense', normally a brighter color. For example: ${green}green${nostyle} and ${igreen}igreen${nostyle}"
    echo
    echo "Supported styles are: "
    echo "  bold: ${bold}Some nice text${nostyle}"
    echo "  underline: ${underline}Some nice text${nostyle}"
    echo "  inverse (swaps background and foreground colors): ${inverse}Some nice text${nostyle}"
    echo "  regular (keep colors but make text regular, removing the underline or bold): ${iblue}${underline}Some nice${regular} text${nostyle}"
    echo "  nofg (remove foreground color): ${underline}${iblue}Some nice${nofg} text${nostyle}"
    echo "  nobg (remove background color): ${underline}${white}${ongreen}Some nice${nobg} text${nostyle}"
    echo "  nostyle (resets everything, removing any color or styling): ${underline}${white}${ongreen}Some nice${nostyle} text"
    echo
    echo "Press -R to toggle between color codes and actual coloring"
    echo

    # header
    for column in style color; do
        echo -n "${(r:9:)column} "
    done
    column=regular
    echo -n "${(r:${padding}:)column} "
    for column in ${(s: :)colors}; do
        for bgtype in on oni; do
            final_column=$bgtype$column
            echo -n "${(r:${padding}:)final_column} "
        done
    done
    echo

    # data
    for style in "" ${(s: :)styles}; do
        for color in ${(s: :)colors} ; do
            for fgtype in "" i; do
                local final_color=$fgtype$color
                echo -n "${(l:9:)style} ${(r:9:)final_color} "
                echo -n "${(P)style}${(P)final_color}${(r:${padding}:)text}${nostyle} "
                for background in ${(s: :)colors}; do
                    for bgtype in on oni; do
                        local final_background=$bgtype$background
                        echo -n "${(P)style}${(P)final_color}${(P)final_background}${(r:${padding}:)text}${nostyle} "
                    done
                done
                echo ${nostyle}
            done
        done
    done
    ) | less -R -S
}
