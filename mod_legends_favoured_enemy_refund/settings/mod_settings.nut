local page = ::LegendsFavouredEnemyRefund.Mod.ModSettings.addPage("Settings");

page.addTitle("KillsRequired","Kills Required for Perk Point Refund");
page.addDivider("divider1");

// Dynamically make the kills needed for each type of enemy before the refund configurable, with a default value of 50
foreach (id in ::LegendsFavouredEnemyRefund.Const.FavouredEnemyPerkIDs) {

    local defaultValue = ::LegendsFavouredEnemyRefund.Const.DefaultKillsRequired.getDefaultValueByID(id);
    local defaultValueDescriptionText = ::MSU.Text.colorGreen(format("The default value for this enemy type is %s", defaultValue.tostring()));
    local description = format("Set the number of kills for the enemy type required for this favoured enemy perk to refund its perk point.\n\n%s",defaultValueDescriptionText)
    
    local rangeSetting = page.addRangeSetting(id, defaultValue, 1, 100, 1, ::Const.Perks.LookupMap[id].Name, description);
    
    // Define behaviour for after the configurable vale is changed
    rangeSetting.addAfterChangeCallback( function ( _oldValue ) {
        ::LegendsFavouredEnemyRefund.Mod.Debug.printLog(format("Updating required kills for %s from %s to %s", id, _oldValue + "", this.getValue() + ""));
        ::LegendsFavouredEnemyRefund.Utils.updatePerkDefObjectsTooltips();
        ::LegendsFavouredEnemyRefund.Utils.updateConstStringsPerkDescriptions();
        ::LegendsFavouredEnemyRefund.Utils.updateRosterSkillProgressAndAllTooltips();
    });
}

page.addDivider("divider2");

// Add a button to reset all enemy types to use the original default value
local resetDefaultsButton = page.addButtonSetting(  "ResetDefaults",
                                                    "Reset All", 
                                                    "Use Default Values", 
                                                    "Reset number of kills required to default values for all enemy types."
                                                );

resetDefaultsButton.addCallback( function ( _data = null ) {    
    
    foreach(id in ::LegendsFavouredEnemyRefund.Const.FavouredEnemyPerkIDs) {
        
        ::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting(id).reset();
    
    }

    ::LegendsFavouredEnemyRefund.Mod.Debug.printLog("Reset number of kills required to default values for all enemy types");

});

page.addDivider("divider3");

// Add a slider to set all enemy types to use the same configurable value
local allValue=50
local valueForAllRangeSetting = page.addRangeSetting(   "ValueForAll", 
                                                        50, 
                                                        1, 
                                                        100, 
                                                        1, 
                                                        "Set Same Value For All", 
                                                        format( "Set ALL enemy types to require the same number of configured kills\n\n%s",
                                                                ::MSU.Text.colorRed(    "As a precaution, to apply this value, first click on \"Apply\" and then \"Confirm\" to set all sliders to this value." + 
                                                                                        "\nThen Click on \"Apply\" or \"Save\" for the changes to take effect"
                                                                )
                                                        )
                                                    );

// Add a button so that the user has to confirm before applying the value to all enemies
local confirmAllValueButton = page.addButtonSetting(    "ConfirmAllValue", 
                                                        "Confirm"
                                                        "",
                                                        "You will still need to click on \"Apply\" or \"Save\" for the settings to take effect"
                                                    );

confirmAllValueButton.addCallback( function ( _data = null ) {

    foreach(id in ::LegendsFavouredEnemyRefund.Const.FavouredEnemyPerkIDs) {
        
        ::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting(id).set(::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting("ValueForAll").getValue());
    
    }

    ::LegendsFavouredEnemyRefund.Mod.Debug.printLog(format("Set number of kills required to %s for all enemy types",allValue.tostring()));

});

// Add Mod Setting spage for debug logging configurations
local loggingPage = ::LegendsFavouredEnemyRefund.Mod.ModSettings.addPage("Logging");
// Set Debug mode off by default, but make it configurable in MSU Mod Settings
::LegendsFavouredEnemyRefund.Mod.Debug.disable();
local debugBoolean = loggingPage.addBooleanSetting( "DebugLogging", 
                                                    false, 
                                                    "Debug Logging", 
                                                    "Enable or disable Debug Logging for this Mod"
                                                );
debugBoolean.addCallback( function ( _data = null ) {
    if ( _data ) {
        ::LegendsFavouredEnemyRefund.Mod.Debug.enable();
    } else {
        ::LegendsFavouredEnemyRefund.Mod.Debug.disable();
    }
});
// Add a validator button to test whether debug mode is enabled or disabled
local validationButton = loggingPage.addButtonSetting(  "ValidationButton",
                                                        "Click to Print", 
                                                        "Validate Logging", 
                                                        "Click on this button to print a line in the log file so you can validate that debug logging is enabled"
                                                    );
validationButton.addCallback( function ( _data = null ) {
    ::LegendsFavouredEnemyRefund.Mod.Debug.printLog("Validate Logging button clicked");
});