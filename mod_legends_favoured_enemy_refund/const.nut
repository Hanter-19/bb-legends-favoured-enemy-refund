// Prepare table to store various Constants related to this mod
::LegendsFavouredEnemyRefund.Const <- {};

// String to store template text that will be appended to each Favoured Enemy tooltip
::LegendsFavouredEnemyRefund.Const.AddOnTextTemplate <- "\n\nWhen you kill %s of these enemies, refund the perk point spent on this perk.";

// Prepare array to dynamically store IDs of all Favoured Enemy Perks
::LegendsFavouredEnemyRefund.Const.FavouredEnemyPerkIDs <- [];
// Loop over Legends Const.Perks.PerkDefObjects to find all Favoured Enemy perks and store the ID
// ( For more information on what PerkDefObjects are for, see Legends code /scripts/config/z_perks_defs.nut )
foreach (perk in ::Const.Perks.PerkDefObjects) {
    if (perk.ID.find("favoured_enemy") != null) {
        ::LegendsFavouredEnemyRefund.Const.FavouredEnemyPerkIDs.push(perk.ID);
    }
}
::LegendsFavouredEnemyRefund.Mod.Debug.printLog(format("Found %s Favoured Enemy Perks:\n%s", 
														::LegendsFavouredEnemyRefund.Const.FavouredEnemyPerkIDs.len().tostring(), 
														::MSU.Log.formatData(::LegendsFavouredEnemyRefund.Const.FavouredEnemyPerkIDs)));

// Prepare table to dynamically store original perk descriptions
::LegendsFavouredEnemyRefund.Const.OriginalPerkDescriptions <- {};

foreach (id in ::LegendsFavouredEnemyRefund.Const.FavouredEnemyPerkIDs) {
	// The Legends mod prepares PerkDefObjects at startup, populating each object with values such as Tooltip=::Const.Strings.PerkDescription.LegendFavouredEnemyGhoul
	// Here, we will use LookupMap to get the original Tooltip value for each Favoured Enemy perk.
	// Note that Legends mod populated Perks with PerkDefObjects, where each Perk takes its Tooltip value from Const.Strings.PerkDescription values
	// We will separately need to update the Tooltip values in Const.Strings.PerkDescription for each Favoured Enemy perk
	// so that new instantiations of these objects will include our changes ( this is done in our updateConstStringsPerkDescriptions() method )
	::LegendsFavouredEnemyRefund.Const.OriginalPerkDescriptions[id] <- ::Const.Perks.LookupMap[id].Tooltip;
}

::LegendsFavouredEnemyRefund.Mod.Debug.printLog(format("Stored original perk descriptions for %s Favoured Enemy perks",
														::LegendsFavouredEnemyRefund.Const.OriginalPerkDescriptions.len().tostring()));
// ::LegendsFavouredEnemyRefund.Mod.Debug.printLog(::MSU.Log.formatData(::LegendsFavouredEnemyRefund.Const.OriginalPerkDescriptions));
// The above line doesn't seem to print into the logs,
// but for manual debugging, it works when running directly in the Dev Console ( see https://www.nexusmods.com/battlebrothers/mods/380 )