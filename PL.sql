-- ---------------------------------------------------------
-- Project Lift Log — Group 16
-- Nathan Anderson, Logan Jordan
-- CS340 Project Step 4
-- PL/SQL procedures
-- ---------------------------------------------------------
-- This procedure demonstrates a CUD operation working against
-- the RESET data. It deletes jsmith's Bodyweight goal.
-- Call it after /reset, then check /goals to confirm the row
-- is gone.
-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_delete_jsmith_bodyweight_goal;

DELIMITER //
CREATE PROCEDURE sp_delete_jsmith_bodyweight_goal()
BEGIN
    DELETE Goals FROM Goals
    INNER JOIN Users ON Goals.userID = Users.userID
    WHERE Users.username = 'jsmith'
      AND Goals.goalType = 'Bodyweight';
END //
DELIMITER ;