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
        ${open} "${baseurl}/examples"
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

option=(-B -J -R -U -V -X -Y -a -b -c -d -e -f -g -h -i -j -l -n -o -p -q -r -s -t -w -x -:)
option_parse=(B J R U V XY XY a binary c d e f g h io distcal l n io p q nodereg s t w x colon)
if [ ! x"$opt" = x ]; then
    for i in ${!option[@]}
    do

        if [ ${opt} = ${option[$i]} ]; then
            ${open} "${baseurl}/option/${option_parse[$i]}"
            exit
        else
            if [ $(($i+1)) -eq ${#option[@]} ]; then
                echo -e "\n\033[31m ERROR: No option named ${2} is found. \033[0m"
                usage
            fi
        fi
    done
fi

proj=(-JX -JP -JA -JB -JC -JCyl_stere -JD -JE -JF -JG -JH -JI -JJ -JK -JL -JM -JN -JO -JPoly -JQ -JR -JS -JT -JU -JV -JW -JY)
proj_parse=(Jx Jp Ja Jb Jc Jcyl_stere Jd Je Jf Jg Jh Ji Jj Jk Jl Jm Jn Jo Jpoly Jq Jr Js Jt Ju Jv Jw Jy)
if [ ! x"$J" = x ]; then
    for i in ${!proj[@]}
    do
        if [ ${J} = ${proj[$i]} ]; then
            ${open} "${baseurl}/proj/${proj_parse[$i]}"
            exit
        else
            if [ $(($i+1)) -eq ${#proj[@]} ]; then
                echo -e "\n\033[31m ERROR: No projection named ${2} is found. \033[0m"
                usage
            fi
        fi
    done
fi

# basic
basic=( canvas unit color pen fill font char latex arrow line anchor panel dir )
basic_parse=(canvas unit color pen fill text special-character latex vector line anchor embellishment input-files)
for i in ${!basic[@]}
do
    if [ ${2} = ${basic[$i]} ]; then
        ${open} "${baseurl}/basis/${basic_parse[$i]}"
        exit
    fi
done

# setting
setting=(FONT MAP COLOR DIR FORMAT IO PROJ PS TIME OTHER)
setting_parse=(font map color dir format io proj ps time misc)
for i in ${!setting[@]}
do
    if [ ${2} = ${setting[$i]} ]; then
        ${open} "${baseurl}/conf/${setting_parse[$i]}"
        exit
    fi
done

# module
module=( `gmt --show-modules ` )
for i in ${!module[@]}
do
    if [ ${2} = ${module[$i]} ]; then
        ${open} "${baseurl}/module/${2}"
        exit
    else
        if [ $(($i+1)) -eq ${#module[@]} ]; then
            echo -e "\n\033[31m ERROR: No model named ${2} is found. \033[0m"
            usage
        fi
    fi
done
