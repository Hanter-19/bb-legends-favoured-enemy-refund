/*
*	Define the default number of kills required for each Legends enemy type
*/
::LegendsFavouredEnemyRefund.Const.DefaultKillsRequired <- {

	Defaults = {}

	function getDefaultValueByID( _id ) {

		if ( _id in Defaults ) {
			return Defaults[_id];
		} else {
			return 50;
		}

	}

}

local defaults = {}
	
defaults["perk.legend_favoured_enemy_ghoul"] <- 50;
defaults["perk.legend_favoured_enemy_hexen"] <- 20;
defaults["perk.legend_favoured_enemy_alps"] <- 20;
defaults["perk.legend_favoured_enemy_unhold"] <- 20;
// Legends counts snakes as Lindwurms, so 10 might be a bit low;
// Maybe in a future update the refund condition should be bonus % gained instead of kills
defaults["perk.legend_favoured_enemy_lindwurm"] <- 10;
defaults["perk.legend_favoured_enemy_direwolf"] <- 40;
defaults["perk.legend_favoured_enemy_spider"] <- 50;
defaults["perk.legend_favoured_enemy_schrat"] <- 10;
defaults["perk.legend_favoured_enemy_ork"] <- 30;
defaults["perk.legend_favoured_enemy_goblin"] <- 40;
defaults["perk.legend_favoured_enemy_vampire"] <- 20;
defaults["perk.legend_favoured_enemy_skeleton"] <- 30;
defaults["perk.legend_favoured_enemy_zombie"] <- 50;
defaults["perk.legend_favoured_enemy_noble"] <- 30;
defaults["perk.legend_favoured_enemy_barbarian"] <- 50;
defaults["perk.legend_favoured_enemy_bandit"] <- 50;
defaults["perk.legend_favoured_enemy_master_archer"] <- 20;
defaults["perk.legend_favoured_enemy_swordmaster"] <- 20;
defaults["perk.legend_favoured_enemy_mercenary"] <- 30;
defaults["perk.legend_favoured_enemy_caravan"] <- 50;
defaults["perk.legend_favoured_enemy_southerner"] <- 30;
defaults["perk.legend_favoured_enemy_nomad"] <- 50;

::LegendsFavouredEnemyRefund.Const.DefaultKillsRequired.Defaults = defaults;

