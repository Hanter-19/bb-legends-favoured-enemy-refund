// Create the object representing this mod
// First we populate basic information about this mod
::LegendsFavouredEnemyRefund <- {
    Version = "1.0.0",
    ID = "mod_legends_favoured_enemy_refund",
    Name = "Legends Favoured Enemy Perk Point Refund",
};

// Register the mod with Modding Script Hooks (see https://www.nexusmods.com/battlebrothers/mods/42 )
::mods_registerMod(::LegendsFavouredEnemyRefund.ID, ::LegendsFavouredEnemyRefund.Version, ::LegendsFavouredEnemyRefund.Name);

// Queue the mod after Legends mod; Also make incompatible with Andrew's Legends Additions mods (since this is making a standalone mod of one of its features)
// More info about how to use mods_queue can be found at the Nexus page for Modding Script Hooks: https://www.nexusmods.com/battlebrothers/mods/42
::mods_queue(::LegendsFavouredEnemyRefund.ID, "mod_legends, !mod_LA", function() {
    // Define mod object so we can use MSU systems ( see https://github.com/MSUTeam/MSU/wiki/Mod )
    ::LegendsFavouredEnemyRefund.Mod <- ::MSU.Class.Mod(::LegendsFavouredEnemyRefund.ID, ::LegendsFavouredEnemyRefund.Version, ::LegendsFavouredEnemyRefund.Name);
    // Enable all MSU Debug logging for this Mod ( see https://github.com/MSUTeam/MSU/wiki/Debug )
    ::LegendsFavouredEnemyRefund.Mod.Debug.enable();

    // Initialization tasks
    ::include("legends_favoured_enemy_refund/const.nut");
    // Define utility functions for later use
    ::include("legends_favoured_enemy_refund/utils.nut");
    // Hook existing legends_favoured_enemy_skill object 
    ::include("legends_favoured_enemy_refund/skills/legends_favoured_enemy_skill.nut");

    // Add Mod Settings page
    // Note: This script must be triggered within /scripts/!mods_preload directory, otherwise MSU will not add the mod settings page 
    local page = ::LegendsFavouredEnemyRefund.Mod.ModSettings.addPage("Mod Settings");
    // Make the number of kills required for the perk point refund configurable, with a default value of 50
    page.addRangeSetting("KillsForRefund", 50, 1, 100, 1, "Kills For Refund", "Set the number of kills required for the favoured enemy perk to refund its perk point")
    // Define behaviour for after the KillsForRefund value is changed
    ::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting("KillsForRefund").addAfterChangeCallback( function ( _oldValue ) {
        ::LegendsFavouredEnemyRefund.Mod.Debug.printLog(format("Updating KillsForRefund value from %s to %s", _oldValue + "", this.getValue() + ""));
        ::LegendsFavouredEnemyRefund.Utils.updatePerkDefObjectsTooltips();
        ::LegendsFavouredEnemyRefund.Utils.updateConstStringsPerkDescriptions();
        ::LegendsFavouredEnemyRefund.Utils.updateRosterSkillProgressAndAllTooltips();
    })

    // Run the following so that any new instantiations of related objects before making any adjustments to the configurable value will have their tooltips updated
    ::LegendsFavouredEnemyRefund.Utils.updatePerkDefObjectsTooltips();
    ::LegendsFavouredEnemyRefund.Utils.updateConstStringsPerkDescriptions();
});