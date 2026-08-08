-- ---------------------------------------------------------
-- Project Lift Log — Group 16
-- Nathan Anderson, Logan Jordan
-- CS340 Project Step 5
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
-- ---------------------------------------------------------
-- WORKOUT EXERCISES
-- ---------------------------------------------------------

-- workout exercises create function

DROP PROCEDURE IF EXISTS sp_create_workoutexercise;

DELIMITER //
CREATE PROCEDURE sp_create_workoutexercise(
  -- psuedonames
  IN p_workoutID INT,
  IN p_exerciseID INT,
  IN p_repCount INT,
  IN p_weight DECIMAL(6,2),
  IN p_durationSeconds INT
)
BEGIN
    INSERT INTO WorkoutExercises (workoutID, exerciseID, repCount, weight, durationSeconds)
    VALUES (
      -- values to be inserted
      p_workoutID,
      p_exerciseID,
      p_repCount,
      p_weight,
      p_durationSeconds
    );
END //
DELIMITER ;

-- workout exercises delete function

DROP PROCEDURE IF EXISTS sp_delete_workoutexercise;

DELIMITER //
CREATE PROCEDURE sp_delete_workoutexercise(
  -- psuedonames
  IN p_workoutExerciseID INT
)
BEGIN
    -- deleting a workoutExercise with correct id
    DELETE FROM WorkoutExercises
    WHERE workoutExerciseID = p_workoutExerciseID;
END //
DELIMITER ;

-- workout exercises update function

DROP PROCEDURE IF EXISTS sp_update_workoutexercise;

DELIMITER //
CREATE PROCEDURE sp_update_workoutexercise(
  -- psuedonames
  IN p_workoutExerciseID INT,
  IN p_workoutID INT,
  IN p_exerciseID INT,
  IN p_repCount INT,
  IN p_weight DECIMAL(6,2),
  IN p_durationSeconds INT
)
BEGIN
  -- update function setting all workoutexercise params to new params
  UPDATE WorkoutExercises
  SET workoutID = p_workoutID, exerciseID = p_exerciseID, repCount = p_repCount, weight = p_weight, durationSeconds = p_durationSeconds
  WHERE workoutExerciseID = p_workoutExerciseID;
END //
DELIMITER ;