// Prepare table to store various Constants related to this mod
::LegendsFavouredEnemyRefund.Const <- {};

::LegendsFavouredEnemyRefund.Const.BonusIncreaseSettingID <- "BonusIncreaseSettingID";
::LegendsFavouredEnemyRefund.Const.MaxStrength <- 20; // Legends hardcodes the bonus range of 5-25, so we have to hardcode the max strength gain too (ideally, we should just reference a const from Legends)

::LegendsFavouredEnemyRefund.Const.getRefundedFlagKey <- function (_id) {
	return "Refunded_" + _id;
};

::LegendsFavouredEnemyRefund.Const.getStartingStrengthFlagKey <- function (_id) {
	return "RefundStartingStrength_" + _id;
};