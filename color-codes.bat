@echo off
setlocal enabledelayedexpansion
>nul chcp 65001
for /F %%a in ('Echo(prompt $E^| cmd')Do set "ESC=%%a"
set "menu_pos=1"
set "hexChars=0123456789ABCDEF"
set "left_arrow=!ESC![38;5;241m[‹]!ESC![0m"
set "right_arrow=!ESC![38;5;241m[›]!ESC![0m"
for %%A in (
	"color[1]-255;0;0-RED-val[1]-6-255"
	"color[2]-0;255;0-GREEN-val[2]-7-255"
	"color[3]-0;0;255-BLUE-val[3]-8-255"
	"color[4]-255;0;0-RED-val[4]-11-0"
	"color[5]-0;255;0-GREEN-val[5]-12-0"
	"color[6]-0;0;255-BLUE-val[6]-13-0"
) do for /f "delims=- tokens=1,2,3,4,5,6" %%B in ("%%~A") do (
	set "%%~B.color=%%~C"
	set "%%~B.name=%%~D"
	set "%%~E=%%~G"
	set "%%~B.ypos=%%~F"
)

set "import_hex[key]=x"
set "menu_up[key]=w"
set "menu_down[key]=s"
set "value_increase_normal[key]=d"
set "value_increase_high[key]=D"
set "value_decrease_normal[key]=a"
set "value_decrease_high[key]=A"
set "value_normal=1"
set "value_high=10"

:main_menu
title github.com/rifteyy/color-codes
call :convert_to_hex
echo.!ESC![?25l!ESC![1;1H#####################################################
echo.#!ESC![48;2;!val[4]!;!val[5]!;!val[6]!m!ESC![38;2;!val[1]!;!val[2]!;!val[3]!m     You can also press !import_hex[key]! to import hex values.    !ESC![0m#
echo.#####################################################
echo.!ESC![5;1HText - %%ESC%%[38;2;!val[1]!;!val[2]!;!val[3]!m       !ESC![42GHEX: #!rh!!gh!!bh!
echo.!ESC![10;1HBackground - %%ESC%%[48;2;!val[4]!;!val[5]!;!val[6]!m     !ESC![42GHEX: #!rhb!!ghb!!bhb!   
echo.!ESC![7;42H!ESC![48;2;!val[1]!;!val[2]!;!val[3]!m     !ESC![0m
echo.!ESC![8;42H!ESC![48;2;!val[1]!;!val[2]!;!val[3]!m     !ESC![0m
echo.!ESC![12;42H!ESC![48;2;!val[4]!;!val[5]!;!val[6]!m     !ESC![0m
echo.!ESC![13;42H!ESC![48;2;!val[4]!;!val[5]!;!val[6]!m     !ESC![0m
for /l %%A in (1 1 6) do (
	if !menu_pos! equ %%A (
		echo.!ESC![!color[%%A].ypos!;1H^>^>!ESC![5G!ESC![38;2;!color[%%A].color!m!color[%%A].name!!ESC![0m:!ESC![12G!left_arrow! !val[%%A]!     !ESC![20G!!right_arrow! ^<^<
	) else (
		echo.!ESC![!color[%%A].ypos!;1H    !ESC![38;2;!color[%%A].color!m!color[%%A].name!!ESC![0m:!ESC![12G!left_arrow! !val[%%A]!    !ESC![20G!!right_arrow!     
	)
)
)
set "key="
setlocal DisableDelayedExpansion
for /f "delims=" %%C in ('2^>nul xcopy /w /l "%~f0" "%~f0"') do if not defined key set "key=%%C"
(  
endlocal
set "key=^%key:~-1%" !
)
if "!key!"=="!menu_up[key]!" if not !menu_pos! equ 1 set /a menu_pos-=!value_normal!
if "!key!"=="!menu_down[key]!" if not !menu_pos! equ 6 set /a menu_pos+=1
if "!key!"=="!value_increase_normal[key]!" if not !val[%menu_pos%]! equ 255 set /a val[%menu_pos%]+=!value_normal!
if "!key!"=="!value_decrease_normal[key]!" if not !val[%menu_pos%]! equ 0 set /a val[%menu_pos%]-=!value_normal!
if "!key!"=="!value_increase_high[key]!" if not !val[%menu_pos%]! gtr 255 set /a val[%menu_pos%]+=!value_high!
if "!key!"=="!value_decrease_high[key]!" if not !val[%menu_pos%]! lss 0 set /a val[%menu_pos%]-=!value_high!
if "!key!"=="!import_hex[key]!" (
	echo.!ESC![?25h
	set /p "user_hex=Enter hexadecimal value: "
	set /a "val[1]=0x!user_hex:~0,2!"
	set /a "val[2]=0x!user_hex:~2,2!"
	set /a "val[3]=0x!user_hex:~4,2!"
	cls
	goto :main_menu
)
if !val[%menu_pos%]! lss 0 set /a val[%menu_pos%]=0
if !val[%menu_pos%]! gtr 255 set /a val[%menu_pos%]=255
goto :main_menu

:convert_to_hex <>
set /a "r3=val[4]/16"
set /a "r4=val[4]%%16"
set "rhb=!hexChars:~%r3%,1!!hexChars:~%r4%,1!"
set /a "g3=val[5]/16"
set /a "g4=val[5]%%16"
set "ghb=!hexChars:~%g3%,1!!hexChars:~%g4%,1!"
set /a "b5=val[6]/16"
set /a "b5=val[7]%%16"
set "bhb=!hexChars:~%b3%,1!!hexChars:~%b4%,1!"
set /a "r1=val[1]/16"
set /a "r2=val[1]%%16"
set "rh=!hexChars:~%r1%,1!!hexChars:~%r2%,1!"
set /a "g1=val[2]/16"
set /a "g2=val[2]%%16"
set "gh=!hexChars:~%g1%,1!!hexChars:~%g2%,1!"
set /a "b1=val[3]/16"
set /a "b2=val[3]%%16"
set "bh=!hexChars:~%b1%,1!!hexChars:~%b2%,1!"
exit/b0
