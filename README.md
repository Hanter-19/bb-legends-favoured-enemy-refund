# Legends Favoured Enemy Perk Point Refund
- A submod for the [Battle Brothers Legends Mod](https://www.nexusmods.com/battlebrothers/mods/60).
- Inspired by Andréw's [Legends Additions mod](https://discordapp.com/channels/547043336465154049/1066453854423629854) which refunds favoured enemy perk points after achieving 50 kills (among numerous other overhauls).
- Made and tweaked into this standalone submod by Hanter.

## About
Have you ever felt that the Favoured Enemy perks in the Legends Mod are interesting, but you're reluctant to spend a precious perk point on it?
This is exactly how it feels for me and that's why I made this submod.

This submod refunds the Perk Point spent on Favoured Enemy perks introduced in the Legends mod for Battle Brothers.

The Perk Point is refunded after achieving a certain number of kills of the favoured enemy (the value for each enemy type is configurable in Mod Settings using MSU).

Can be added to both new or ongoing campaigns.

**WARNING**: I have not tested the impact of removing this mod mid-campaign.

## How To Install
Download the `mod_legends_favoured_enemy_refund` zip file from the latest release at the [Releases page](https://github.com/Hanter-19/bb-legends-favoured-enemy-refund/releases).
Paste the file (DO NOT UNZIP) into your Battle Brothers Data folder (default location on Windows: C:\Program Files (x86)\Steam\steamapps\common\Battle Brothers\data )

## Required Mods
Requires the following mods:
- [BB Legends Mod](https://www.nexusmods.com/battlebrothers/mods/60)
- [Modding Standards and Utilities (MSU)](https://www.nexusmods.com/battlebrothers/mods/479)

Generally, you should use the latest versions of the above mods. If you are using an unsupported version, you will get an error dialog when starting the game.
The error dialog will inform you which versions of the required mods are supported.

## Compatibility with Other Mods
Incompatible with the following mods:
- Legends Additions by Andréw

I *might* create a patch in the future to get this to work with Legends Additions.

Should be compatible with [Perk Trees Rework (PTR)](https://www.nexusmods.com/battlebrothers/mods/438).

## Discussion / Feedback / Bug Reports
Please join the [thread started for this mod](https://discord.com/channels/547043336465154049/1088956924516634707) in the submods channel of the Legends Mod Discord channel

## Note to Modders

### Learning to mod from this mod
I have written extensive comments in my code to kind of walkthrough what the mod does and what resources you can refer to.

If you are new to modding, start by looking at `/scripts/!mods_preload/mod_legends_favoured_enemy_refund.nut`

### Adding new favoured enemy types
This mod dynamically checks all perks in ::Const.Perks.PerkDefObjects for Perks where the ID contains the string `"favoured_enemy"`.

If a new Favoured Enemy perk (implemented in the exact same way as the Legends favoured enemy perks) is added in the same way to ::Const.Perks.PerkDefObjects before this mod is loaded, then this mod *should* be able to pick it up.

## Credits and Appreciation
Created by [Hanter](https://github.com/Hanter-19)

Many thanks to the following modders:
- Andréw whose Legends Additions mod inspired me to create this mod
- Abysscrane who shared numerous modding resources, which helped me get started modding
- LordMidas whose [BB modding tutorials on Youtube](https://www.youtube.com/watch?v=HigAIhhL5-U&list=PLq2sfy4jfXuVPxuNCfgdmJNqx5dhUaYWG) helped me setup my modding environment
- The BB Legends team for their amazing overhaul
- The MSU team for the amazing MSU utilties, all of which are well-documented on the [MSU Wiki on their github](https://github.com/MSUTeam/MSU/wiki "Modding Standards & Utilities (MSU)")

Code publicly available at https://github.com/Hanter-19/bb-legends-favoured-enemy-refund