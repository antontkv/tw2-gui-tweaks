# The Witcher 2 GUI Tweaks

This mod changes some GUI things for a better user experience.

## Add the Exit game option to the Pause menu and Continue from the last save to the Main menu

Strange that those options weren't there in the first place.

## Add menus rollover for Main, Pause, Inventory and Journal menus

When you press up on the first element you go down to the last and vice versa.

## Add read status for books

Add read status for books in the Inventory and Loot menus.

## Configurable HUD modules

Hide any HUD module during normal gameplay. They will be shown in the radial menu and when combat starts.

## Fix for LT/RT buttons doesn't work for sorting in inventory

**Disable krbr.dzip**

It overrides some GUI panels and removes sorting from LT/RT buttons.

**krbr** is an extension for Korean and Brazilian language support. If you don't need those languages, you can disable this extension.

List of gui files overwritten by krbr:

- cnormalbutton.swf
- fonts_kr.swf
- ui_character.swf
- ui_crafting.swf
- ui_dialog.swf
- ui_elixirs.swf
- ui_inventory.swf
- ui_journal.swf
- ui_mainmenu.swf
- ui_sleep.swf

## Installation

Copy CookedPC into the Witcher 2 install directory, overwriting existing files.

Disable krbr.dzip in DLC Settings.

Add these lines to the `User.ini` file in `Documents\Witcher 2\Config\`:

```
[HUDTweaks]
HideHealth=1
HideSelectedItems=1
HideBuffs=1
HideMap=0
```

Change this value to whatever you like. 1 - hide module, 0 - don't.

Since `base_scripts.dzip` is modified you need to merge script files if you use other mods that change this dzip. Use [Gibbed RED Tools With UI](https://www.nexusmods.com/witcher2/mods/1027) to unpack/pack `base_scripts.dzip` and programs like WinMerge to merge files. To see what was changed in which files visit [GitHub repo](https://github.com/antontkv/tw2-vanquished-enemies-auto-loot).

The mod modifies files listed bellow, so any other mod that also modifies this file will not be compatible.

- clist.swf
- clistinfo.swf
- cmenulist.swf
- hud.swf
- ui_inventory.swf
- ui_trade.swf
