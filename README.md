# Lift Log

CS340 project by Nathan Anderson and Logan Jordan (The Query Crew).

## Setup

1. Install dependencies:
   ```
   npm install
   ```

2. Create your `.env` file from the template:
   ```
   cp .env.example .env
   ```

3. Open `.env` and fill in your real database credentials:
   ```
   DB_HOST=classmysql.engr.oregonstate.edu
   DB_USER=cs340_your_onid
   DB_PASSWORD=your_db_password
   DB_NAME=cs340_your_onid
   ```

4. Import `DDL.sql`, then `PL.sql` and finally `DML.sql` into your OSU database before running the app.

## Running in development

Use this while you're actively building and testing changes.

```
npm run development
```

## Running in production

Use this only when you're ready to submit for grading or peer review, since the server keeps running after you log out.

1. Stop any development server first (`Ctrl+C`).

2. From the project root, start production mode:
   ```
   npm run production
   ```

3. View the app at the same URL:
   ```
   http://classwork.engr.oregonstate.edu:63360
   ```

4. Once grading or review is done, stop the production server:
   ```
   npm run stop_production
   ```

---

### Acknowledgements

Each citation below also appears as a comment at the top of the file it refers to.

#### AI tool citations

**`README.md`**

```
Citation for use of AI Tools:
Date: 8/9/2026
Adapted document generated from the following prompt:
"Create a README.md file with instructions on how to run development and production."
AI Source URL: https://openai.com/codex/
```

**`README.md`** — applies to the Acknowledgements and Original work sections below.

```
Citation for use of AI Tools:
Date: 8/11/2026
Adapted document generated from the following prompt:
"Of all the files with AI citations, add those citations to the bottom of the README in the same
way. Those without citations should be known as my original work. Also cite the starter code;
only files with no citations are able to be used as our own work."
Claude read every file in the repository, identified which ones carried AI or starter code
citations, and wrote the citation sections below from what it found.
AI Source URL: https://claude.ai/
```

**`project/public/style.css`**

```
Citation for use of AI Tools:
Date: 8/11/2026
Adapted code generated from the following prompt:
"Update our style.css to a clean, modern fitness-tracking web app UI. Use a dark navy nav bar with
blue and mint accents, a light gray background, white card-based tables and forms, rounded corners,
subtle shadows, and clear responsive spacing. Keep the homepage simple: a page title, short
description, and two action buttons. Use a professional, minimal style with accessible contrast
and readable typography."
AI Source URL: https://openai.com/codex/
```

**`project/app.js`** — applies to the `/workout-exercises-create`, `/workout-exercises-update`,
and `/workout-exercises-delete` routes.

```
Citation for use of AI Tools:
Date: 8/9/2026
Written by the authors and reviewed with Claude (Anthropic), which
corrected the CALL argument order and empty-string-to-NULL handling.
Prompt topic: wiring the WorkoutExercises forms to stored procedures.
AI Source URL: https://claude.ai/
```

#### Starter code citations

The following files are adapted from course-provided starter code, as noted by the
"Module is adapted from: Exploration - Web Application Technology Node.js starter code"
comment at the top of each:

```
Citation for starter code:
Source: CS 340 Exploration - Web Application Technology, Node.js starter code
Scope: Express/Handlebars app scaffolding, the MySQL connection pool, and the
       base structure of the .hbs table and form templates.
```

* `project/app.js`
* `project/database/db-connector.js`
* `project/views/layouts/main.hbs`
* `project/views/users.hbs`
* `project/views/exercises.hbs`
* `project/views/workouts.hbs`
* `project/views/workout-exercises.hbs`
* `project/views/goals.hbs`

### Original work

The following files carry no citation and are entirely our own original work:

* `DDL.sql`
* `DML.sql`
* `PL.sql`