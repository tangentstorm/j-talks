
# addons directory

This repo is pretty much designed only for me, so it's a
bit of work to set up the dependencies you need here.

First clone these repos:


- https://github.com/tangentstorm/godot-waveform
- https://github.com/tangentstorm/jlang-rs-gd
- https://github.com/tangentstorm/jlang-rs
- https://github.com/tangentstorm/fnarbmlyx

I put all of these repos (and this current j-talks one) under `d:/ver/` on windows 10.

Next you need to create symlinks from j-talks/addons/ to various parts of those repos.

Here's how I do it on windows 10:

```powershell
# launch powershell as administrator!
# you *may* need to turn on developer mode to make symlinks work:
# https://docs.microsoft.com/en-us/windows/apps/get-started/enable-your-device-for-development

cd D:\ver\j-talks\addons\

New-Item -ItemType SymbolicLink -Path jlang-rs-gd -Target D:\ver\jprez\godot-plugin\addons\jlang-rs-gd
New-Item -ItemType SymbolicLink -Path jprez -Target D:\ver\jprez\godot-plugin\addons\jprez
New-Item -ItemType SymbolicLink -Path waveform -Target D:\ver\godot-waveform\addons\waveform
```
