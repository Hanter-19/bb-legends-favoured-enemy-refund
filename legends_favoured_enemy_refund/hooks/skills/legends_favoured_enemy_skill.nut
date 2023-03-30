/*
* Hook the Legends object legend_favoured_enemy_skill to add our additional behaviour on some of its methods
*/
::mods_hookExactClass("skills/legend_favoured_enemy_skill", function(o) {
    
    // Save the old version of legend_favoured_enemy_skill.onUpdate() defined by the Legends Mod
    local old_onUpdate = o.onUpdate;
    // Rewrite onUpdate with our changes
    o.onUpdate = function( _properties ) {

        //if perk id hasn't been added yet, and you have more than the configured number of kills of that favored enemy,
        if (!this.getContainer().getActor().getFlags().has(this.m.ID) && this.getTotalKillStats().Kills.tointeger() >= ::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting("KillsForRefund").getValue()) {
            ::LegendsFavouredEnemyRefund.Mod.Debug.printLog("Refunding perk point for flag: " + this.m.ID);
            this.getContainer().getActor().getFlags().add(this.m.ID);
            this.getContainer().getActor().m.PerkPoints += 1;
        }
        // Maintain existing behaviour by calling the older version afterwards
        old_onUpdate(_properties);
    };

    // Save the old version of legend_favoured_enemy_skill.getTooltip() defined by the Legends Mod
    local old_getTooltip = o.getTooltip;
    // Rewrite getTooltip with our changes
    o.getTooltip = function() {
        
        // Maintain existing behaviour by calling the older version first
        local resp = old_getTooltip();
        
        // Add additional tooltip about the perk point refund
        if (this.getContainer().getActor().getFlags().has(this.m.ID)) {
            // Perk Point has been refunded
            resp.push({
                id = 15,
                type = "hint",
                icon = "ui/icons/unlocked_small.png",
                text = "The perk point spent on this perk has been refunded."
            });
        } else {
            // Need X more kills to refund the perk point
            resp.push({
                id = 15,
                type = "hint",
                icon = "ui/icons/special.png",
                text = "Kill " + (::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting("KillsForRefund").getValue() - this.getTotalKillStats().Kills) + " more of these favoured enemies to refund the perk point spent on this perk."
            });
        }
        
        return resp;
    };
});