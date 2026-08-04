-- ---------------------------------------------------------
-- Project Lift Log — Group 16
-- Nathan Anderson, Logan Jordan
-- CS340 Project Step 2/4
-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_load_liftlog;

DELIMITER //
CREATE PROCEDURE sp_load_liftlog()
BEGIN
    SET FOREIGN_KEY_CHECKS = 0;

    -- Drop all tables if they exist (Child before parent)
    DROP TABLE IF EXISTS Goals;
    DROP TABLE IF EXISTS WorkoutExercises;
    DROP TABLE IF EXISTS Workouts;
    DROP TABLE IF EXISTS Exercises;
    DROP TABLE IF EXISTS Users; 

    -- Users entity: people who log workouts
    CREATE TABLE Users (
        userID INT AUTO_INCREMENT NOT NULL,
        email varchar(255) NOT NULL,
        username varchar(255) NOT NULL,
        password varchar(255) NOT NULL,
        PRIMARY KEY (userID),
        UNIQUE (username),
        UNIQUE (email)
    );

    -- Library of exercises
    CREATE TABLE Exercises (
        exerciseID INT AUTO_INCREMENT NOT NULL,
        name varchar(255) NOT NULL,
        muscleGroup varchar(255) NULL,
        equipment varchar(255) NULL,
        PRIMARY KEY (exerciseID),
        UNIQUE (name)
    );

    -- Workouts: Dated session belonging to one user
    CREATE TABLE Workouts (
        workoutID INT AUTO_INCREMENT NOT NULL,
        userID INT NOT NULL,
        workoutDate DATE NOT NULL,
        notes varchar(255) NULL,
        PRIMARY KEY (workoutID),
        FOREIGN KEY (userID) REFERENCES Users(userID)
            ON DELETE CASCADE ON UPDATE CASCADE
    );

    -- Intersection table linking workouts and exercises
    CREATE TABLE WorkoutExercises (
        workoutExerciseID INT AUTO_INCREMENT NOT NULL,
        exerciseID INT NOT NULL,
        workoutID INT NOT NULL,
        repCount INT NULL,
        weight DECIMAL(6,2) NULL,
        durationSeconds INT NULL,
        PRIMARY KEY (workoutExerciseID),
        FOREIGN KEY (exerciseID) REFERENCES Exercises(exerciseID)
            ON DELETE RESTRICT ON UPDATE CASCADE,
        FOREIGN KEY (workoutID) REFERENCES Workouts(workoutID)
            ON DELETE CASCADE ON UPDATE CASCADE
    );

    -- Goals: user targets, can be tied to a exercise
    CREATE TABLE Goals (
        goalID INT AUTO_INCREMENT NOT NULL,
        userID INT NOT NULL,
        exerciseID INT NULL,
        goalType varchar(255) NOT NULL,
        targetValue DECIMAL(6,2) NULL,
        createdDate DATE NOT NULL,
        completedDate DATE NULL,
        PRIMARY KEY (goalID),
        FOREIGN KEY (userID) REFERENCES Users(userID)
            ON DELETE CASCADE ON UPDATE CASCADE,
        -- SET NULL so deleting an exercise keeps the goal, just unlinks it
        FOREIGN KEY (exerciseID) REFERENCES Exercises(exerciseID)
            ON DELETE SET NULL ON UPDATE CASCADE
    );

    -- Sample data for all tables
    INSERT INTO Users (email, username, password)
    VALUES
        ('jdoe@example.com', 'jdoe', 'hashed_pw_1'),
        ('jsmith@example.com', 'jsmith', 'hashed_pw_2');

    INSERT INTO Exercises (name, muscleGroup, equipment)
    VALUES
        ('Bench Press', 'Chest', 'Barbell'),
        ('Shoulder Press', 'Shoulders', 'Dumbbell'),
        ('Tricep Pushdown', 'Triceps', 'Cable'),
        ('Deadlift', 'Back', 'Barbell'),
        ('Bicep Curl', 'Biceps', 'Dumbbell'),
        ('Plank', 'Core', 'Bodyweight'),
        ('Lat Pulldown', 'Back', 'Cable');

    INSERT INTO Workouts (workoutID, userID, workoutDate, notes)
    VALUES
        (101, (SELECT userID FROM Users WHERE username = 'jdoe'),   '2026-07-01', 'Push day'),
        (102, (SELECT userID FROM Users WHERE username = 'jdoe'),   '2026-07-03', 'Pull day'),
        (103, (SELECT userID FROM Users WHERE username = 'jsmith'), '2026-07-02', 'Full body');

    INSERT INTO WorkoutExercises (workoutID, exerciseID, repCount, weight, durationSeconds)
    VALUES
        (101, (SELECT exerciseID FROM Exercises WHERE name = 'Bench Press'),     10, 135.00, NULL),
        (101, (SELECT exerciseID FROM Exercises WHERE name = 'Shoulder Press'),   8,  50.00, NULL),
        (101, (SELECT exerciseID FROM Exercises WHERE name = 'Tricep Pushdown'), 12,  40.00, NULL),
        (102, (SELECT exerciseID FROM Exercises WHERE name = 'Deadlift'),         5, 225.00, NULL),
        (102, (SELECT exerciseID FROM Exercises WHERE name = 'Bicep Curl'),      10,  30.00, NULL),
        (103, (SELECT exerciseID FROM Exercises WHERE name = 'Bench Press'),      8,  95.00, NULL),
        (103, (SELECT exerciseID FROM Exercises WHERE name = 'Plank'),         NULL,   NULL,   60),
        (103, (SELECT exerciseID FROM Exercises WHERE name = 'Lat Pulldown'),    10,  80.00, NULL);

    INSERT INTO Goals (userID, exerciseID, goalType, targetValue, createdDate, completedDate)
    VALUES
        ((SELECT userID FROM Users WHERE username = 'jdoe'),
        (SELECT exerciseID FROM Exercises WHERE name = 'Bench Press'),
        '1 rep max', 225.00, '2026-01-01', NULL),
        ((SELECT userID FROM Users WHERE username = 'jsmith'),
        NULL, 'Bodyweight', 180.00, '2026-05-01', NULL);

    SET FOREIGN_KEY_CHECKS=1;
END //
DELIMITER ;