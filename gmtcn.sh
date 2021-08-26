#!/bin/bash

if [ $# -eq 0 ]; then
cat << EOF >&2

    gmtcn - Show Chinese HTML documentation of GMT's specified module. 
    (c) Mao Zhou (https://github.com/ZMAlt)

 Usage: 
    gmtcn docs home

    gmtcn docs <module-name> 
    gmtcn docs <option-name> 
    gmtcn docs <proj-name>
    gmtcn docs <setting-name>

    gmtcn <other>

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
    media unit color pen fill font char latex vector line anchor panel

EOF
	exit
fi


if [ ${1} != "docs" ]; then
    echo -e "\033[31m ERROR: \033[0m"
    bash ${0}
    exit
fi

if [ ! -n "${2}" ]; then
    bash ${0}
    exit
fi

http=https://docs.gmt-china.org/latest/

J=""
opt=""
case $2
in
    home)    
        open ${http}
        exit
        ;;
    module|option|proj|conf|install|table|grid|cpt|dataset|chinese|api)
        open ${http}${2}
        exit
        ;;
    gallery)
        open ${http}"examples"
        exit
        ;;
    started|advanced)
        open ${http}"tutorial/"${2}
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
            open ${http}"option/"${option_parse[$i]}
            exit
        else 
            if [ $(($i+1)) -eq ${#option[@]} ]; then
                echo -e "\033[31m ERROR: \033[0m"
                bash ${0}
                exit
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
            open ${http}"proj/"${proj_parse[$i]}
            exit
        else 
            if [ $(($i+1)) -eq ${#proj[@]} ]; then
                echo -e "\033[31m ERROR: \033[0m"
                bash ${0}
                exit
            fi
        fi
    done 
fi

# basic
basic=( media unit color pen fill font char latex arrow line anchor panel )
basic_parse=(paper unit color pen fill text special-character latex vector line anchor embellishment)
for i in ${!basic[@]}
do
    if [ ${2} = ${basic[$i]} ]; then
        open ${http}"basis/"${basic_parse[$i]}
        exit
    fi
done 

# setting
setting=(FONT MAP COLOR DIR FORMAT IO PROJ PS TIME OTHER)
setting_parse=(font map color dir format io proj ps time misc)
for i in ${!setting[@]}
do
    if [ ${2} = ${setting[$i]} ]; then
        open ${http}"conf/"${setting_parse[$i]}
        exit
    fi
done 

# module 
module=( `gmt --show-modules ` )
for i in ${!module[@]}
do
    if [ ${2} = ${module[$i]} ]; then
        open ${http}"module/"${2}
        exit
    else 
        if [ $(($i+1)) -eq ${#module[@]} ]; then
            echo -e "\033[31m ERROR: \033[0m"
            bash ${0}
            exit
        fi
    fi
done 