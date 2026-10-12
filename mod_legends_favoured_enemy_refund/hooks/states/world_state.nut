/**
 * We need to know when a mercenary's lifetime stats has been deserialized so that we can add the start bonus flag properly if the mod is added during an existing save.
 * Waiting until the world state is done deserializing (or starting a new campaign, which wouldn't affect the bonus flag) is the best way to ensure this
 */
::mods_hookExactClass("states/world_state", function(o) {
	
	o.m.FinishedInit <- false;

	local old_init = o.init;
	o.init = function() {
		old_init();
		this.m.FinishedInit = true;
		::LegendsFavouredEnemyRefund.Utils.updateRosterSkillProgress();
	};

	local old_onFinish = o.onFinish;
	o.onFinish = function() {
		old_onFinish();
		this.m.FinishedInit = false;
	};

	o.isFinishedInit <- function () {
		return this.m.FinishedInit;
	};
});