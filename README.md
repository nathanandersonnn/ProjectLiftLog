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

4. Import `DDL.sql` into your OSU database before running the app.

## Running in development

Use this while you're actively building and testing changes.

```
npm run development
```

This runs `app.js` through Nodemon, which restarts the server automatically whenever you save a file.

View the app at:
```
http://classwork.engr.oregonstate.edu:63360
```

Stop the server with `Ctrl+C`. Development mode stops running once you log out of the Classwork SSH session.

## Running in production

Use this only when you're ready to submit for grading or peer review, since the server keeps running after you log out.

1. Stop any development server first (`Ctrl+C`).

2. From the project root, start production mode:
   ```
   npm run production
   ```
   This uses Forever to keep `app.js` running in the background.

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

Portions of this document was generated using the OpenAI Codex coding assistant within VS Code. Prompt used: "Create a README.md file with instructions on how to run development and production."