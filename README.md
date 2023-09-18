# gmtcn
借鉴 GMT 官方 docs 模块，在终端下打开 GMT 中文手册网页。

## 使用方法

```bash
bash gmtcn.sh docs [option]
```

为与 GMT 的 docs 模块用法一致，可以在终端配置文件中添加 `gmtcn="bash gmtcn.sh"`，这样就可以直接使用 `gmtcn` 命令。

```bash
$ gmtcn                  

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
```

## 与 `gmt docs` 命令的不同

1. 本脚本目前只适用于 MacOS 和 Linux 系统。
2. 由于用户本地不存在中文手册 html 文件，因此只能打开在线网页 （默认打开最新版本的手册网页）
3. 除模块外，还可以打开选项，投影，配置参数，安装，画笔，单位等中文手册章节，包括具体的选项和投影
4. 模块只包括已翻译的模块，未翻译的模块并不会自动跳转到对应的英文文档
5. 打开模块章节并不能直接定位对应的选项，需手动查找
