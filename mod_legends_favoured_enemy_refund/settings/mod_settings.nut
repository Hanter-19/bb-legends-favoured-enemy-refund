local page = ::LegendsFavouredEnemyRefund.Mod.ModSettings.addPage("Settings");

// The bonus increase required after taking the perk is configurable, with a default value of 10%
local defaultValue = ::LegendsFavouredEnemyRefund.Const.DefaultStrengthIncreaseRequired;
local defaultValueDescriptionText = ::MSU.Text.colorGreen(format("The default value is %s%%", defaultValue.tostring()));
local descriptionText = @"Set the required bonus increase earned after taking a favoured enemy perk for it to refund its perk point.

If you take the perk and reach the maximum bonus before the required increase is achieved, the perk point will also be refunded.

%s";
local description = format(descriptionText,defaultValueDescriptionText);

local rangeSetting = ::MSU.Class.RangeSetting(::LegendsFavouredEnemyRefund.Const.BonusIncreaseSettingID, defaultValue, 1, ::LegendsFavouredEnemyRefund.Const.MaxStrength, 1, "Bonus Increase Required for Perk Point Refund", description);
page.addElement(rangeSetting);

// Define behaviour for after the configurable value is changed
rangeSetting.addAfterChangeCallback( function ( _oldValue ) {
    ::LegendsFavouredEnemyRefund.Mod.Debug.printLog(format("Updating required bonus increase from %s to %s", _oldValue + "", this.getValue() + ""));
    ::LegendsFavouredEnemyRefund.Utils.updateRosterSkillProgress();
});

local defaultButtonSetting = ::MSU.Class.ButtonSetting( "ResetDefaults",
                                                        "Reset", 
                                                        "Use Default Value", 
                                                        "Reset number of kills required to default of " + ::LegendsFavouredEnemyRefund.Const.DefaultStrengthIncreaseRequired + "%"
);

page.addElement(defaultButtonSetting);

defaultButtonSetting.addCallback( function ( _data = null ) {
    ::LegendsFavouredEnemyRefund.Mod.ModSettings.getSetting(::LegendsFavouredEnemyRefund.Const.BonusIncreaseSettingID).reset();
    ::LegendsFavouredEnemyRefund.Mod.Debug.printLog("Reset required bonus increase to default value");
});

// Add Mod Setting spage for debug logging configurations
local loggingPage = ::LegendsFavouredEnemyRefund.Mod.ModSettings.addPage("Logging");
// Set Debug mode off by default, but make it configurable in MSU Mod Settings
::LegendsFavouredEnemyRefund.Mod.Debug.disable();
local debugBooleanSetting = ::MSU.Class.BooleanSetting("DebugLogging", 
                                                false, 
                                                "Debug Logging", 
                                                "Enable or disable Debug Logging for this Mod"
);
loggingPage.addElement(debugBooleanSetting);

debugBooleanSetting.addCallback( function ( _data = null ) {
    if ( _data ) {
        ::LegendsFavouredEnemyRefund.Mod.Debug.enable();
    } else {
        ::LegendsFavouredEnemyRefund.Mod.Debug.disable();
    }
});
// Add a validator button to test whether debug mode is enabled or disabled
local validationButtonSetting = ::MSU.Class.ButtonSetting(  "ValidationButton",
                                                            "Click to Print", 
                                                            "Validate Logging", 
                                                            "Click on this button to print a line in the log file so you can validate that debug logging is enabled"
);
loggingPage.addElement(validationButtonSetting);
validationButtonSetting.addCallback( function ( _data = null ) {
    ::LegendsFavouredEnemyRefund.Mod.Debug.printLog("Validate Logging button clicked");
});