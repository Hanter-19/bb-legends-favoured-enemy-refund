/*
* A collection of methods we will use for this mod
*/
::LegendsFavouredEnemyRefund.Utils <- {
    /*
    * Updates the progress of the character towards meeting the refund requirement for the Favoured Enemy skill
    */
    function updateRosterSkillProgress() {
        foreach ( employee in ::World.getPlayerRoster().getAll() ) {
            employee.getSkills().update();
        }
    }
};