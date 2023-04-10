// Create the object representing this mod
// First we populate basic information about this mod
::LegendsFavouredEnemyRefund <- {
    Version = "2.0.1",
    ID = "mod_legends_favoured_enemy_refund",
    Name = "Legends Favoured Enemy Perk Point Refund",
};

// Register the mod with Modding Script Hooks (see https://www.nexusmods.com/battlebrothers/mods/42 )
::mods_registerMod(::LegendsFavouredEnemyRefund.ID, ::LegendsFavouredEnemyRefund.Version, ::LegendsFavouredEnemyRefund.Name);

// Queue the mod after Legends mod; Also make incompatible with Andrew's Legends Additions mods (since this is making a standalone mod of one of its features)
// More info about how to use mods_queue can be found at the Nexus page for Modding Script Hooks: https://www.nexusmods.com/battlebrothers/mods/42
::mods_queue(::LegendsFavouredEnemyRefund.ID, "mod_msu(>=1.2.4), mod_legends(>=16.2.3), !mod_LA", function() {
    // Define mod object so we can use MSU systems ( see https://github.com/MSUTeam/MSU/wiki/Mod )
    ::LegendsFavouredEnemyRefund.Mod <- ::MSU.Class.Mod(::LegendsFavouredEnemyRefund.ID, ::LegendsFavouredEnemyRefund.Version, ::LegendsFavouredEnemyRefund.Name);
    
    // Enable MSU Registry system for Update Checking ( see https://github.com/MSUTeam/MSU/wiki/Registry )
    // This will notify users if there is a newer version of the mod on the configured GitHub repository
    ::LegendsFavouredEnemyRefund.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/Hanter-19/bb-legends-favoured-enemy-refund");
    ::LegendsFavouredEnemyRefund.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub)
    
    // Enable all MSU Debug logging for this Mod ( see https://github.com/MSUTeam/MSU/wiki/Debug ) - leave it commented out unless I'm doing dev debugging.
    // ::LegendsFavouredEnemyRefund.Mod.Debug.enable();

    // Initialization tasks
    ::include("mod_legends_favoured_enemy_refund/const.nut");
    // Prepare default kills required values
    ::include("mod_legends_favoured_enemy_refund/config/defaults.nut");
    // Define utility functions for later use
    ::include("mod_legends_favoured_enemy_refund/utils.nut");
    // Hook existing legend_favoured_enemy_skill object 
    ::include("mod_legends_favoured_enemy_refund/hooks/skills/legend_favoured_enemy_skill.nut");
    // Hook existing perk_legend_favoured_enemy_master_archer object specifically because it overrides the inherited onUpdate() function from legend_favoured_enemy_skill
    ::include("mod_legends_favoured_enemy_refund/hooks/skills/perks/perk_legend_favoured_enemy_master_archer.nut");

    // Add Mod Settings page
    // Note: This script must be triggered within /scripts/!mods_preload directory, otherwise MSU will not add the mod settings page
    ::include("mod_legends_favoured_enemy_refund/settings/mod_settings.nut");

    // Run the following so that any new instantiations of related objects before making any adjustments to the configurable value will have their tooltips updated
    ::LegendsFavouredEnemyRefund.Utils.updatePerkDefObjectsTooltips();
    ::LegendsFavouredEnemyRefund.Utils.updateConstStringsPerkDescriptions();
});