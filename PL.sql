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

/*
-- retired demo proc

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
*/
-- -----------------------------------

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

-- ---------------------------------------------------------
-- WORKOUTS
-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_create_workout;

DELIMITER //
CREATE PROCEDURE sp_create_workout(
  -- psuedonames
  IN p_userID INT,
  IN p_workoutDate DATE,
  IN p_notes VARCHAR(255)
)
BEGIN
  -- insert a new workout
  INSERT INTO Workouts(userID, workoutDate, notes)
  VALUES (
    p_userID,
    p_workoutDate,
    p_notes
  );
END //
DELIMITER ;

-- ---------------------------------------------------------
-- EXERCISES
-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_create_exercise;

DELIMITER //
CREATE PROCEDURE sp_create_exercise(
  -- psuedonames
  IN p_name VARCHAR(255),
  IN p_muscleGroup VARCHAR(255),
  IN p_equipment VARCHAR(255)
)
BEGIN
  -- insert a new exercise
  INSERT INTO Exercises(name, muscleGroup, equipment)
  VALUES (
    p_name,
    p_muscleGroup,
    p_equipment
  );
END //
DELIMITER ;

-- ---------------------------------------------------------
-- GOALS
-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_create_goal;

DELIMITER //
CREATE PROCEDURE sp_create_goal(
  -- psuedonames
  IN p_userID INT,
  IN p_exerciseID INT,
  IN p_goalType varchar(255),
  IN p_targetValue DECIMAL(6,2),
  IN p_createdDate DATE,
  IN p_completedDate DATE
)
BEGIN
  -- insert a new goal
  INSERT INTO Goals(userID, exerciseID, goalType, targetValue, createdDate, completedDate)
  VALUES (
    p_userID,
    p_exerciseID,
    p_goalType,
    p_targetValue,
    p_createdDate,
    p_completedDate
  );
END //
DELIMITER ;

-- ---------------------------------------------------------
-- USERS
-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_create_user;

DELIMITER //
CREATE PROCEDURE sp_create_user(
  IN p_email VARCHAR(255),
  IN p_username VARCHAR(255),
  IN p_password VARCHAR(255)
)
BEGIN
  -- insert a new user
  INSERT INTO Users(email, username, password)
  VALUES (
    p_email,
    p_username,
    p_password
  );
END //
DELIMITER ;