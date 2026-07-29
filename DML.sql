-- ---------------------------------------------------------
-- Project Lift Log — Group 16
-- Nathan Anderson, Logan Jordan
-- CS340 Project Step 3
-- ---------------------------------------------------------
-- Variables to be supplied by the backend are denoted with a
-- leading colon, e.g. :userID, :workoutDate
-- ---------------------------------------------------------

-- users interactions

-- get all users
SELECT userID, email, username FROM Users
ORDER BY username;

-- get a specific user
SELECT userID, email, username FROM Users
WHERE userID = :id;

-- insert new user
INSERT INTO Users(email, username, password)
VALUES (:email, :username, :password);


-- update a current user
UPDATE Users 
SET email = :email, username = :username, password = :password
WHERE userID = :id;

-- delete a user
DELETE FROM Users WHERE userID = :id;


-- exercises interactions

-- get all exercises
SELECT exerciseID, name, muscleGroup, equipment FROM Exercises
ORDER BY name;

-- get a specific exercise
SELECT exerciseID, name, muscleGroup, equipment FROM Exercises
WHERE exerciseID = :id;

-- insert new exercise
INSERT INTO Exercises(name, muscleGroup, equipment)
VALUES (:name, :muscleGroup, :equipment);


-- update a current exercise
UPDATE Exercises 
SET name = :name, muscleGroup = :muscleGroup, equipment = :equipment
WHERE exerciseID = :id;

-- delete a exercise
DELETE FROM Exercises WHERE exerciseID = :id;


-- workout interactions

-- select all workouts
SELECT Workouts.workoutID, Users.username, Workouts.workoutDate, Workouts.notes
FROM Workouts
INNER JOIN Users ON Workouts.userID = Users.userID
ORDER BY Workouts.workoutDate DESC;

-- select a specific workout
SELECT workoutID, userID, workoutDate, notes FROM Workouts
WHERE workoutID= :workoutID;

-- select userid and username for use in workouts
SELECT userID, username FROM Users ORDER BY username;

-- insert a new workout
INSERT INTO Workouts(userID, workoutDate, notes)
VALUES (:userID, :workoutDate, :notes);

-- update a workout
UPDATE Workouts
SET userID = :userID, workoutDate = :workoutDate, notes = :notes
WHERE workoutID = :id;

-- delete a workout
DELETE FROM Workouts WHERE workoutID = :id;


-- WorkoutExercises interactions

-- 
SELECT WorkoutExercises.workoutExerciseID,
       Exercises.name,
       WorkoutExercises.workoutID,
       WorkoutExercises.repCount,
       WorkoutExercises.weight,
       WorkoutExercises.durationSeconds
FROM WorkoutExercises
INNER JOIN Exercises ON WorkoutExercises.exerciseID = Exercises.exerciseID
INNER JOIN Workouts ON WorkoutExercises.workoutID = Workouts.workoutID
ORDER BY WorkoutExercises.workoutID;

-- select one workoutexercise
SELECT workoutExerciseID, workoutID, exerciseID, repCount, weight, durationSeconds
FROM WorkoutExercises
WHERE workoutExerciseID = :id;

-- get all workouts for the workoutExercise dropdown
SELECT workoutDate, workoutID FROM Workouts
ORDER BY workoutDate DESC;

-- get all exercises for the workoutExercise dropdown
SELECT exerciseID, name FROM Exercises
ORDER BY name;

-- inserting a new workoutexercise
INSERT INTO WorkoutExercises(workoutID, exerciseID, repCount, weight, durationSeconds)
VALUES (:workoutID, :exerciseID, :repCount, :weight, :durationSeconds);

-- updating an existing workoutexercise
UPDATE WorkoutExercises
SET workoutID = :workoutID, exerciseID = :exerciseID, repCount = :repCount, weight = :weight, durationSeconds = :durationSeconds
WHERE workoutExerciseID = :id;

-- delete a workout exercise
DELETE FROM WorkoutExercises WHERE workoutExerciseID = :id;


-- goal interactions

-- select all goals
SELECT Goals.goalID, Goals.userID, Goals.goalType, Goals.targetValue, Goals.createdDate, Goals.completedDate, Exercises.name
FROM Goals LEFT JOIN Exercises ON Goals.exerciseID = Exercises.exerciseID
ORDER BY Goals.goalType;

-- select one goal
SELECT goalID, userID, exerciseID, goalType, targetValue, createdDate, completedDate
FROM Goals
WHERE goalID = :id;

-- get all exercises for the goals dropdown
SELECT exerciseID, name FROM Exercises
ORDER BY name;

-- get all users for goals dropdown
SELECT userID, email, username FROM Users
ORDER BY username;

-- insert a goal
INSERT INTO Goals(userID, exerciseID, goalType, targetValue, createdDate, completedDate)
VALUES (:userid, :exerciseID, :goalType, :targetValue, :createdDate, :completedDate);

-- update a goal
UPDATE Goals
SET userID = :userID, exerciseID = :exerciseID, goalType = :goalType, targetValue = :targetValue, createdDate = :createdDate, completedDate = :completedDate
WHERE goalID = :id;

-- delete a goal
DELETE FROM Goals WHERE goalID = :id;