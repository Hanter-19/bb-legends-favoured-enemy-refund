/*
* Hook the Legends object perk_legend_favoured_enemy_master_archer because it overrides the onUpdate() function inherited from legend_favoured_enemy_skill
*/
::mods_hookExactClass("skills/perks/perk_legend_favoured_enemy_master_archer", function(o) {

    // Exact same logic as our hook for legend_favoured_enemy_skill    
    local old_onUpdate = o.onUpdate;
    o.onUpdate = function( _properties ) {

        if (!this.getContainer().getActor().getFlags().has(this.m.ID) && this.getTotalKillStats().Kills.tointeger() >= ::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting(this.m.ID).getValue()) {
            ::LegendsFavouredEnemyRefund.Mod.Debug.printLog("Refunding perk point for flag: " + this.m.ID);
            this.getContainer().getActor().getFlags().add(this.m.ID);
            this.getContainer().getActor().m.PerkPoints += 1;
        }
        old_onUpdate(_properties);

    };

});