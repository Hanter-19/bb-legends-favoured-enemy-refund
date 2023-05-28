::mods_hookExactClass("entity/tactical/actor", function(o) {
	
	local old_resetPerks = o.resetPerks;

	o.resetPerks = function(){

		old_resetPerks();

		// Remove all flags related to Favoured Enemy Perks
		local flags = this.getFlags();
		foreach (flag in flags.m) {
			if (flag.Key.find("favoured_enemy") != null) {
				::LegendsFavouredEnemyRefund.Mod.Debug.printLog("Removing flag \"" + flag.Key + "\" for " + this.getName());
				flags.remove(flag.Key);
			}
		}

	};

});