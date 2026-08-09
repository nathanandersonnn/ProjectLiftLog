/*
    Module is adapted from:
    Exploration - Web Application Technology Node.js starter code

 * Citation for /workout-exercises-create, -update, -delete routes:
 * Date: 2026-08-09
 * Written by the authors and reviewed with Claude (Anthropic), which
 * corrected the CALL argument order and empty-string-to-NULL handling.
 * Prompt topic: wiring the WorkoutExercises forms to stored procedures.
*/

// ######## SETUP ########

// Express
const express = require('express');
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

const PORT = 63360;

// Database
const db = require('./database/db-connector');

// Handlebars
const { engine } = require('express-handlebars'); // Import express-handlebars engine
app.engine('.hbs', engine({ extname: '.hbs' })); // Create instance of handlebars
app.set('view engine', '.hbs'); // Use handlebars engine for *.hbs files.

// ######## ROUTE HANDLERS ########

// READ ROUTES
app.get('/', async function (req, res) {
    try {
        res.render('home'); // Render the home.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        res.status(500).send('An error occurred while rendering the page.');
    }
});

// USERS
app.get('/users', async function (req, res) {
    try {
        const query1 = `SELECT userID, email, username FROM Users
            ORDER BY username;`;
        const [users] = await db.query(query1);

        res.render('users', { users: users });
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

// EXERCISES
app.get('/exercises', async function (req, res) {
    try {
        const query1 = `SELECT exerciseID, name, muscleGroup, equipment FROM Exercises
            ORDER BY name;`;
        const [exercises] = await db.query(query1);

        res.render('exercises', { exercises: exercises });
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

// WORKOUTS
app.get('/workouts', async function (req, res) {
    try {
        // query1: workouts joined with the owning user for display
        const query1 = `SELECT Workouts.workoutID, Users.username, Workouts.workoutDate, Workouts.notes
            FROM Workouts
            INNER JOIN Users ON Workouts.userID = Users.userID
            ORDER BY Workouts.workoutDate DESC;`;
        // query2: users for the create/update dropdown
        const query2 = `SELECT userID, username FROM Users ORDER BY username;`;

        const [workouts] = await db.query(query1);
        const [users] = await db.query(query2);

        res.render('workouts', { workouts: workouts, users: users });
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

// WORKOUT EXERCISES
app.get('/workout-exercises', async function (req, res) {
    try {
        // query1: workoutExercises joined with exercise name and workout for display
        const query1 = `SELECT WorkoutExercises.workoutExerciseID,
            Exercises.name,
            WorkoutExercises.workoutID,
            WorkoutExercises.repCount,
            WorkoutExercises.weight,
            WorkoutExercises.durationSeconds
        FROM WorkoutExercises
        INNER JOIN Exercises ON WorkoutExercises.exerciseID = Exercises.exerciseID
        INNER JOIN Workouts ON WorkoutExercises.workoutID = Workouts.workoutID
        ORDER BY WorkoutExercises.workoutID;`;
        // query2: workouts for the dropdown
        const query2 = `SELECT workoutDate, workoutID FROM Workouts
            ORDER BY workoutDate DESC;`;
        // query3: exercises for the dropdown
        const query3 = `SELECT exerciseID, name FROM Exercises
            ORDER BY name;`;

        const [workoutExercises] = await db.query(query1);
        const [workouts] = await db.query(query2);
        const [exercises] = await db.query(query3);

        res.render('workout-exercises', {
            workoutExercises: workoutExercises,
            workouts: workouts,
            exercises: exercises
        });
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

// GOALS
app.get('/goals', async function (req, res) {
    try {
        // query1: goals left joined with exercise name, since exerciseID can be NULL
        const query1 = `SELECT Goals.goalID, Goals.userID, Goals.goalType, Goals.targetValue, Goals.createdDate, Goals.completedDate, Exercises.name
            FROM Goals LEFT JOIN Exercises ON Goals.exerciseID = Exercises.exerciseID
            ORDER BY Goals.goalType;`;
        // query2: exercises for the dropdown
        const query2 = `SELECT exerciseID, name FROM Exercises
            ORDER BY name;`;
        // query3: users for the dropdown
        const query3 = `SELECT userID, email, username FROM Users
            ORDER BY username;`;

        const [goals] = await db.query(query1);
        const [exercises] = await db.query(query2);
        const [users] = await db.query(query3);

        res.render('goals', { goals: goals, exercises: exercises, users: users });
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

// PL/SQL DEMO ROUTE

/*
app.get('/goals/delete-jsmith-bodyweight-demo', async function (req, res) {
    try {
        const query1 = 'CALL sp_delete_jsmith_bodyweight_goal();';
        await db.query(query1);
        res.redirect('/goals');
    } catch (error) {
        console.error('Error executing PL/SQL:', error);
        res.status(500).send('An error occurred while executing the PL/SQL.');
    }
});
*/
// RESET ROUTE

app.get('/reset', async function (req, res) {
    try {
        await db.query('CALL sp_load_liftlog();');
        res.redirect('/');
    } catch(error){
        console.error('Error on reset:', error);
        res.status(500).send('An error occurred while resetting the database.');
    }
})

// creating workoutexercises route
app.post('/workout-exercises-create', async function (req, res) {
    try {
        const {
            create_workoutExercise_workoutID,
            create_workoutExercise_exerciseID,
            create_workoutExercise_repCount,
            create_workoutExercise_weight,
            create_workoutExercise_durationSeconds
        }   = req.body;

        // check if these should be null
        const reps = create_workoutExercise_repCount === '' ? null : create_workoutExercise_repCount;
        const weight = create_workoutExercise_weight     === '' ? null : create_workoutExercise_weight;
        const dur = create_workoutExercise_durationSeconds === '' ? null : create_workoutExercise_durationSeconds;

        await db.query(
            // pass params
            'CALL sp_create_workoutexercise(?, ?, ?, ?, ?);',
            [
                create_workoutExercise_workoutID,
                create_workoutExercise_exerciseID,
                reps,
                weight,
                dur
            ]
        );  // redirect to workoutexercises
        res.redirect('/workout-exercises');
    } catch(error){
        console.error('Error on create:', error);
        res.status(500).send('An error occurred while creating the workoutexercise.');
    }
})

// delete workout exercises

app.post('/workout-exercises-delete', async function (req, res) {
    try {
        await db.query(
            'CALL sp_delete_workoutexercise(?);',
            [
                req.body.delete_workoutExercise_id
            ]
        );
        res.redirect('/workout-exercises');
    } catch (error) {
        console.error('Error on delete:', error);
        res.status(500).send('An error occurred while deleting the workoutexercise.');
    }
});

// updating workoutexercises route
app.post('/workout-exercises-update', async function (req, res) {
    try {
        const {
            update_workoutExercise_id,
            update_workoutExercise_workoutID,
            update_workoutExercise_exerciseID,
            update_workoutExercise_repCount,
            update_workoutExercise_weight,
            update_workoutExercise_durationSeconds
        }   = req.body;

        // check if these should be null
        const reps = update_workoutExercise_repCount === '' ? null : update_workoutExercise_repCount;
        const weight = update_workoutExercise_weight     === '' ? null : update_workoutExercise_weight;
        const dur = update_workoutExercise_durationSeconds === '' ? null : update_workoutExercise_durationSeconds;

        await db.query(
            // pass params
            'CALL sp_update_workoutexercise(?, ?, ?, ?, ?, ?);',
            [
                update_workoutExercise_id,
                update_workoutExercise_workoutID,
                update_workoutExercise_exerciseID,
                reps,
                weight,
                dur
            ]
        );  // redirect to workoutexercises
        res.redirect('/workout-exercises');
    } catch(error){
        console.error('Error on update:', error);
        res.status(500).send('An error occurred while updating the workoutexercise.');
    }
})

// ######## LISTENER ########

app.listen(PORT, function () {
    console.log(
        'Express started on http://localhost:' +
            PORT +
            '; press Ctrl-C to terminate.'
    );
});
