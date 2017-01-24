# postgres-template
Template for starting vapor applications with postgresql included

To start a new project using this template, run this command

    vapor new [app name here] --template=https://github.com/wpuricz/postgres-template

Then update the credentials stored in /Config/secrets/postgresql.json

Additionally, there is a dummy route in main.swift to test the database connection which can be tested by putting the url below in the browser:

    http://localhost:8080/version
