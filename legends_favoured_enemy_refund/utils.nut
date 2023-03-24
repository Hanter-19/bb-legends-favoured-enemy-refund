/*
* A collection of methods we will use for this mod
*/
::LegendsFavouredEnemyRefund.Utils <- {

    /*
    * Update Legends ::Const.Strings.PerkDescription.LegendFavouredEnemy___ values which are used to populate the perk description 
    * whenever a Favoured Enemy perk / status effect is newly instantiated. 
    * ( For example, see in the Legends code: scripts/skills/perks/perk_legend_favoured_enemy_bandit.nut in the create() function )
    * An example of manually setting it would be like this:
    *   ::Const.Strings.PerkDescription.LegendFavouredEnemyGhoul = "this is the new tooltip";
    */
    function updateConstStringsPerkDescriptions() {
        foreach ( id in ::LegendsFavouredEnemyRefund.Const.FavouredEnemyPerkIDs ) {
            local key = ::Const.Perks.LookupMap[id].Const;
            local addOn = format(LegendsFavouredEnemyRefund.Const.AddOnTextTemplate, ::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting("KillsForRefund").getValue().tostring());
            ::Const.Strings.PerkDescription[key] = ::LegendsFavouredEnemyRefund.Const.OriginalPerkDescriptions[id] + addOn;
        }
    }

    /*
    * Update the Tooltips for each Legends Favoured Enemy perk in ::Const.Perks.PerkDefObjects.
    * An example of manually setting it would be like this:
    *   ::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyGhoul].Tooltip = "this is the new tooltip";
    * Or setting it to one of the Const.Strings (which we will also update in our updateConstStringsPerkDescriptions() method ):
    *   ::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyGhoul].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyGhoul;
    */
    function updatePerkDefObjectsTooltips() {

        // Update the Tooltip text
        local addOn = format(LegendsFavouredEnemyRefund.Const.AddOnTextTemplate, ::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting("KillsForRefund").getValue().tostring());

        foreach ( id in ::LegendsFavouredEnemyRefund.Const.FavouredEnemyPerkIDs ) {
            ::Const.Perks.LookupMap[id].Tooltip = ::LegendsFavouredEnemyRefund.Const.OriginalPerkDescriptions[id] + addOn;
            // if ( _employee.getBackground().getPerk(id) != null ) {
            //     _employee.getBackground().getPerk(id).Tooltip = ::LegendsFavouredEnemyRefund.Const.OriginalPerkDescriptions[id] + _addOn;
            // }
        }
    }

    /*
    * Updates two things: 
    * 1. The progress towards getting the Favoured Enemey skill Perk Point refund for all characters in the player's roster
    *       - This is necessary so that when the player changes the KillsForRefund value, the perk point will be immediately refunded if applicable 
    * 2. The description tooltip for the favoured enemy skills and perks of all characters in the player's roster
    *       - This is necessary because the description text is stored in the instance of the legend_favoured_enemy_skill class at creation,
    *         meaning that if the player changes the KillsForRefund value, the description text needs to be individually updated for each instance  
    */
    function updateRosterSkillProgressAndAllTooltips() {

        local addOn = format(LegendsFavouredEnemyRefund.Const.AddOnTextTemplate, ::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting("KillsForRefund").getValue().tostring());

        foreach ( employee in ::World.getPlayerRoster().getAll() ) {
            this.updateRosterSkillProgress( employee );
            this.updateRosterPerkTreePerkDescriptions( employee, addOn );
            this.updateRosterSkillsDescriptions( employee, addOn );
        }
    }

    /*
    * Updates the progress of the character towards meeting the refund requirement for the Favoured Enemy skill
    */
    function updateRosterSkillProgress( _employee ) {
        _employee.getSkills().update();
    }

    /*
    * Updates the description tooltip for the perk in the Perk Selection Screen for all characters in the current roster
    */
    function updateRosterPerkTreePerkDescriptions( _employee, _addOn ) {

        foreach ( id in ::LegendsFavouredEnemyRefund.Const.FavouredEnemyPerkIDs ) {
            if ( _employee.getBackground().getPerk(id) != null ) {
                _employee.getBackground().getPerk(id).Tooltip = ::LegendsFavouredEnemyRefund.Const.OriginalPerkDescriptions[id] + _addOn;
            }
        }
    }

    /*
    * Updates the description tooltip for the Status Effect / Skill Icons for all characters in the current roster
    */
    function updateRosterSkillsDescriptions( _employee, _addOn ) {

        foreach ( id in ::LegendsFavouredEnemyRefund.Const.FavouredEnemyPerkIDs ) {
            if ( _employee.getSkills().getSkillByID(id) != null ) {
                _employee.getSkills().getSkillByID(id).legend_favoured_enemy_skill.m.Description = ::LegendsFavouredEnemyRefund.Const.OriginalPerkDescriptions[id] + _addOn;
            }
        } 
    }

};