#!/bin/bash

function usage () {
cat <<-EOF >&2
gmtcn - Show Chinese HTML documentation of GMT's specified module.
GMT 中文社区 (https://gmt-china.org/)

 Usage:
    gmtcn docs home

    gmtcn docs <module-name>
    gmtcn docs <option-name>
    gmtcn docs <proj-name>
    gmtcn docs <setting-name>

    gmtcn docs <other>

 Module-name:
    All translated GMT module

 Option-name:
    -B -R -J -x -a -:   ...

 Proj-name:
    -JP -JX -JQ  ...

 Setting-name:
    FONT MAP COLOR DIR FORMAT IO PROJ PS TIME OTHER

 Other:
    module option proj setting gallery
    install started advanced
    table grid cpt dataset chinese api
    canvas unit color pen fill font char latex vector line anchor panel dir
EOF
exit
}

# usage
if [ $# -eq 0 ]; then
    usage
fi

# Arguments check
if [ ${1} != "docs" ]; then
    echo -e "\n\033[31m ERROR: ${1} is not recognized or supprted. \033[0m"
    usage
fi

if [ ! -n "${2}" ]; then
    usage
fi

# system
sys=$(uname)
if [ ${sys} = "Linux" ] ; then
    open=xdg-open
    ${open} --version > /dev/null || echo -e "\n\033[31m ERROR: ${open} does not exist. \033[0m"
elif [ ${sys} = "Darwin" ] ; then
    open=open
elif [ ${sys} = *MINGW64* ] ; then
    open=start
else
    echo -e "\n\033[31m ERROR: ${sys} is not recognized or supported. \033[0m"
    exit
fi


baseurl=https://docs.gmt-china.org/latest

J=""
opt=""
case $2
in
    home)
        ${open} ${baseurl}
        exit
        ;;
    module|option|proj|conf|install|table|grid|cpt|dataset|chinese|api)
        ${open} "${baseurl}/${2}"
        exit
        ;;
    setting)
        ${open} "${baseurl}/conf"
        exit
        ;;
    gallery)
        ${open} "${baseurl}/gallery"
        exit
        ;;
    started|advanced)
        ${open} "${baseurl}/tutorial/${2}"
        exit
        ;;
    -J)
        opt=$2
        ;;
    -J*)
        J=$2
        ;;
    -*)
        opt=$2
        ;;
    *)
        ;;
esac

# Mapping options to the corresponding URL
declare -A option_mapping=(
    [-B]=B
    [-J]=J
    [-R]=R
    [-U]=U
    [-V]=V
    [-X]=XY
    [-Y]=XY
    [-a]=a
    [-b]=binary
    [-c]=c
    [-d]=d
    [-e]=e
    [-f]=f
    [-g]=g
    [-h]=h
    [-i]=io
    [-j]=distcal
    [-l]=l
    [-n]=n
    [-o]=io
    [-p]=p
    [-q]=q
    [-r]=nodereg
    [-s]=s
    [-t]=t
    [-w]=w
    [-x]=x
    [-:]=colon
)
if [[ -n $opt && ${option_mapping[$opt]+_} ]]; then
    ${open} "${baseurl}/option/${option_mapping[$opt]}"
    exit
else
    if [ ! x"$opt" = x ]; then
        echo -e "\n\033[31m ERROR: No option named ${opt} is found. \033[0m"
        usage
    fi
fi

# Mapping projections to the corresponding URL
declare -A proj_mapping=(
    [-JX]=Jx
    [-JP]=Jp
    [-JA]=Ja
    [-JB]=Jb
    [-JC]=Jc
    [-JCyl_stere]=Jcyl_stere
    [-JD]=Jd
    [-JE]=Je
    [-JF]=Jf
    [-JG]=Jg
    [-JH]=Jh
    [-JI]=Ji
    [-JJ]=Jj
    [-JK]=Jk
    [-JL]=Jl
    [-JM]=Jm
    [-JN]=Jn
    [-JO]=Jo
    [-JPoly]=Jpoly
    [-JQ]=Jq
    [-JR]=Jr
    [-JS]=Js
    [-JT]=Jt
    [-JU]=Ju
    [-JV]=Jv
    [-JW]=Jw
    [-JY]=Jy
)

if [[ -n $J && ${proj_mapping[$J]+_} ]]; then
    ${open} "${baseurl}/proj/${proj_mapping[$J]}"
    exit
else
    if [ ! x"$J" = x ]; then
        echo -e "\n\033[31m ERROR: No projection named ${J} is found. \033[0m"
        usage
    fi
fi

# Mapping basic to the corresponding URL
declare -A basic_mapping=(
    [canvas]=canvas
    [unit]=unit
    [color]=color
    [pen]=pen
    [fill]=text
    [font]=special-character
    [char]=vector
    [latex]=latex
    [arrow]=line
    [line]=anchor
    [anchor]=embellishment
    [panel]=input-files
    [dir]=dir
)
if [[ -n $2 && ${basic_mapping[$2]+_} ]]; then
    ${open} "${baseurl}/basis/${basic_mapping[$2]}"
    exit
fi

declare -A setting_mapping=(
    [FONT]=font
    [MAP]=map
    [COLOR]=color
    [DIR]=dir
    [FORMAT]=format
    [IO]=io
    [PROJ]=proj
    [PS]=ps
    [TIME]=time
    [OTHER]=misc
)

if [[ -n $2 && ${setting_mapping[$2]+_} ]]; then
    ${open} "${baseurl}/conf/${setting_mapping[$2]}"
    exit
fi

# module
module=( $(gmt --show-modules) )

for m in "${module[@]}"; do
    if [[ $2 == "$m" || "gmt$2" == "$m" ]]; then
        ${open} "${baseurl}/module/${2/#gmt/}"
        exit
    fi
done

echo -e "\n\033[31m ERROR: No module named ${2} is found. \033[0m"
usage