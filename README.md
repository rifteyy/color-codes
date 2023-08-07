# color-codes
This program was inspired by sintrode's [colorPicker](https://github.com/sintrode/colorPicker).

RGB color value picker for text and background.
Windows 10/11 is required, other Windows versions are not supported.

If you want to use these colors in your script, you can generate escape character with:
```
for /F %%a in ('Echo(prompt $E^| cmd')Do set "ESC=%%a"
```
All you do after that is use it with
```
echo %ESC%[38;2;255;0;0This is cool red text!
```

If you would like to know more, you can read [Console Virtual Terminal Sequences on learn.microsoft.com](https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences).

![alt_text](https://media.discordapp.net/attachments/869861284621979681/1138185700559306803/Screenshot_5.png?width=891&height=463)

## Default usage:

`w` Go up in menu

`s` Go down in menu

`x` Import hexadecimal value and convert into RGB

`d` Increase color value by 1 (or however is `value_normal` defined)

`D` Increase color value by 10 (or however is `value_high` defined)

`a` Decrease color value by 1 (or however is `value_normal` defined)

`A` Decrease color value by 10 (or however is `value_high` defined)

Note that all these values can be changed in the script by editing variables containing these letters.
