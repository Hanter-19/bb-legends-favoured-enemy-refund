/*
* Hook the Legends object legend_favoured_enemy_skill to add our additional behaviour on some of its methods
*/
::mods_hookExactClass("skills/legend_favoured_enemy_skill", function(o) {
    
    // Save the old version of legend_favoured_enemy_skill.onUpdate() defined by the Legends Mod
    local old_onUpdate = o.onUpdate;
    // Rewrite onUpdate with our changes
    o.onUpdate = function( _properties ) {
        local actor = this.getContainer().getActor();
        local flags = actor.getFlags();
        local refundedFlagKey = ::LegendsFavouredEnemyRefund.Const.getRefundedFlagKey(this.m.ID);
        local startingStrengthFlagKey = ::LegendsFavouredEnemyRefund.Const.getStartingStrengthFlagKey(this.m.ID);
        
        // startingStrengthFlagKey is added at 1 of 2 points: 
        // 1. When the perk is activated, so we can track when the bonus has sufficiently been increased
        // 2. If the mod is added to an existing save and the player has people who already have the perk, we add the flag (we need to wait till lifetime stats is deserialized) 
        if (!flags.has(startingStrengthFlagKey) && ::World.State.isFinishedInit()) { // lifetime stats is deserialized in player.nut after the skills are added, so we need to make sure everything is ready
            flags.add(startingStrengthFlagKey, this.getTotalKillStats().Strength);
            ::LegendsFavouredEnemyRefund.Mod.Debug.printLog("Adding flag " + startingStrengthFlagKey + " to " + actor.getName() + " with value = " + this.getTotalKillStats().Strength);
        }

        // Check if refund is possible
        if (!flags.has(refundedFlagKey)) {
            local startingStrength = flags.has(startingStrengthFlagKey) ? flags.get(startingStrengthFlagKey) : 0;
            local bonusIncreased = this.getTotalKillStats().Strength - startingStrength;
            local requiredIncrease = ::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting(::LegendsFavouredEnemyRefund.Const.BonusIncreaseSettingID).getValue();

            // Refund the perk once you have achieved the configured bonus increase after taking the perk, or if the bonus is at maximum
            if (bonusIncreased >= requiredIncrease || this.getTotalKillStats().Strength >= ::LegendsFavouredEnemyRefund.Const.MaxStrength) {
                ::LegendsFavouredEnemyRefund.Mod.Debug.printLog("Refunding perk point for flag: " + refundedFlagKey);
                actor.getFlags().add(refundedFlagKey);
                actor.m.PerkPoints += 1;
            }
        }
        // Maintain existing behaviour by calling the older version afterwards
        old_onUpdate(_properties);
    };

    // Save the old version of legend_favoured_enemy_skill.getTooltip() defined by the Legends Mod
    local old_getTooltip = o.getTooltip;
    // Rewrite getTooltip with our changes
    o.getTooltip = function() {
        
        // Maintain existing behaviour by calling the older version first
        local ret = old_getTooltip();

        local flags = this.getContainer().getActor().getFlags();
        local refundedFlagKey = ::LegendsFavouredEnemyRefund.Const.getRefundedFlagKey(this.m.ID);
        local startingStrengthFlagKey = ::LegendsFavouredEnemyRefund.Const.getStartingStrengthFlagKey(this.m.ID);
        
        // Add additional tooltip about the perk point refund
        if (flags.has(refundedFlagKey)) {
            // Perk Point has been refunded
            ret.push({
                id = 15,
                type = "hint",
                icon = "ui/icons/unlocked_small.png",
                text = "The perk point spent on this perk has been refunded."
            });
        } else {
            // To refund the perk point, increase the bonus by the configured amount, or to the maximum bonus if the remaining possible increase is less than the configured amount
            local strength = 1.0 * this.getTotalKillStats().Strength;
            local requiredIncrease = 1.0 * ::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting(::LegendsFavouredEnemyRefund.Const.BonusIncreaseSettingID).getValue();
            local startingStrength = 1.0 * flags.get(startingStrengthFlagKey);
            local remainingIncrease = ::Math.minf(requiredIncrease - strength + flags.get(startingStrengthFlagKey), ::LegendsFavouredEnemyRefund.Const.MaxStrength - strength);
            ret.push({
                id = 15,
                type = "hint",
                icon = "ui/icons/special.png",
                text = "Increase the bonus by [color=%highlightLightBg%]%remainingIncrease%%[/color] more to refund the perk point spent on this perk.",
                param = [
                    ["remainingIncrease", remainingIncrease]
                ]
            });
        }
        
        return ret;
    };

    local old_getUnactivatedPerkTooltipHints = o.getUnactivatedPerkTooltipHints;
    o.getUnactivatedPerkTooltipHints = function(_actor = null) {
        local ret = old_getUnactivatedPerkTooltipHints(_actor);
        local stats = this.getTotalKillStats(_actor);
        local strength = stats.Strength;

        local t = "";
        local p = [];
        if (stats.Strength >= ::LegendsFavouredEnemyRefund.Const.MaxStrength) {
            t = "After activating this perk, the perk point will immediately be refunded because the maximum bonus has already been achieved";
        } else {
            // The remaining increase required for refund is either the configured value, or whatever is left till the maximum strength if it is less than the configured value
            local requiredIncrease = ::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting(::LegendsFavouredEnemyRefund.Const.BonusIncreaseSettingID).getValue();
            local remainingIncrease = ::Math.minf(requiredIncrease, ::LegendsFavouredEnemyRefund.Const.MaxStrength - stats.Strength);
            t = "After activating this perk, increase the bonus by [color=%highlightLightBg%]%requiredIncrease%%[/color] to refund the perk point spent on this perk";
            p = [
                ["requiredIncrease", remainingIncrease]
            ];
        }
        ret.push({
            id = 5,
            type = "hint",
            icon = "ui/icons/special.png",
            text = t,
            param = p
        });
        return ret;
    };
});