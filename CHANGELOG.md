# 3.0.0
- Updated for Legends 19.5.0
- Refund mechanic has been completely reworked
> Refund is now based on the bonus accrued after activating the perk. After increasing the bonus by 10% (configurable), the perk point will be refunded
> If the perk is activated when there is less than 10% between the current bonus and the max of 25%, the perk point will be refunded when the max bonus is achieved
> All favoured enemy types will use the same required bonus increase (default 10%). It is no longer possible to configure it for each different enemy type

# 2.0.1
- Fixed a bug that was causing the Favoured Enemy - Archer perk to not refund. Many thanks to Emo Used HM01 for reporting the bug!
- Coding convention: renamed hook filename to match the original file it is hooking

# 2.0.0
- The number of kills required to refund the perk point is now customizable based on the enemy type
- There are default values for each enemy type
- Added various settings in the Mod Settings to configure the above

# 1.1.0
- Add MSU Registry system which will notify users when a newer release build is available on Github
- Coding convention: move hook script(s) into hooks folder
- Coding convention: rename returned variable in hooked function to `ret`
- Make debug logging configurable in MSU Mod Settings (default switched off)
- Set requirement for MSU version >=1.2.4 and Legends version >=16.2.3

# 1.0.0
- Intitial release