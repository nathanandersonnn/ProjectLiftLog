/*
*  
* PROJECT LIFT LOG
*
*/

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;
START TRANSACTION;


DROP TABLE IF EXISTS Goals;
DROP TABLE IF EXISTS WorkoutExercises;
DROP TABLE IF EXISTS Workouts;
DROP TABLE IF EXISTS Exercises;
DROP TABLE IF EXISTS Users; 


CREATE TABLE Users (
    userID INT AUTO_INCREMENT NOT NULL,
    email varchar(255) NOT NULL,
    username varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    PRIMARY KEY (userID),
    UNIQUE (email)
);

CREATE TABLE Exercises (
    exerciseID INT AUTO_INCREMENT NOT NULL,
    name varchar(255) NOT NULL,
    muscleGroup varchar(255) NULL,
    equipment varchar(255) NULL,
    PRIMARY KEY (exerciseID),
    UNIQUE (name)
);

CREATE TABLE Workouts (
    workoutID INT AUTO_INCREMENT NOT NULL,
    userID INT NOT NULL,
    workoutDate datetime NULL,
    notes varchar(255) NULL,
    PRIMARY KEY (workoutID),
    FOREIGN KEY (userID) REFERENCES Users(userID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE WorkoutExercises (
    workoutExerciseID INT AUTO_INCREMENT NOT NULL,
    exerciseID INT NOT NULL,
    workoutID INT NOT NULL,
    repCount INT NULL,
    weight DECIMAL(6,2) NULL,
    durationSeconds INT NULL,
    PRIMARY KEY (workoutExerciseID),
    FOREIGN KEY (exerciseID) REFERENCES Exercises(exerciseID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (workoutID) REFERENCES Workouts(workoutID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Goals (
    goalID INT AUTO_INCREMENT NOT NULL,
    userID INT NOT NULL,
    exerciseID INT NULL,
    goalType varchar(255) NOT NULL,
    targetValue DECIMAL(6,2) NULL,
    createdDate datetime NOT NULL,
    completedDate datetime NULL,
    PRIMARY KEY (goalID),
    FOREIGN KEY (userID) REFERENCES Users(userID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (exerciseID) REFERENCES Exercises(exerciseID)
        ON DELETE SET NULL ON UPDATE CASCADE
);

SET FOREIGN_KEY_CHECKS=1;
COMMIT;