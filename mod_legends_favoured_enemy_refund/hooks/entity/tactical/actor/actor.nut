::mods_hookExactClass("entity/tactical/actor", function(o) {
	
	local old_resetPerks = o.resetPerks;

	o.resetPerks = function(){

		old_resetPerks();

		// Remove all flags related to Favoured Enemy Perks
		local flags = this.getFlags();

		// Track how many flags were removed, which implies we need to remove that many reset perk points 
		// (because they were earned by fulfilling the favoured enemy refund requirement)
		local flagsRemoved = 0; 

		foreach (flag in flags.m) {
			if (flag.Key.find("favoured_enemy") != null) {
				::LegendsFavouredEnemyRefund.Mod.Debug.printLog("Removing flag \"" + flag.Key + "\" for " + this.getName());
				flags.remove(flag.Key);
				flagsRemoved++;
			}
		}

		// Remove perks points that were earned from fulfilling favoured enemy refund requirement
		this.m.PerkPoints -= flagsRemoved;

	};

});