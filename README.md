**What is this?**

Fitbit Noodge does exactly what it says on the tin - it nudges you by incrementing your Fitbit goal(s) each day.

By default, it's set up to increment your steps goal by 10 steps per day. Assuming you're starting off with the default goal of 10,000 steps/day, tomorrow your goal would be raised to 10,010 steps, and two days from now it would be 10,020 steps, &c.

The point is to nudge yourself to keep pushing yourself more and more, and not grow complacent when your goals become easy for you.

**Setup**

Clone this repository.

Go to https://dev.fitbit.com/apps/new and register a new application.

Set the following environment variables: RAILS_SECRET_TOKEN, FITBIT_CONSUMER_KEY, and FITBIT_CONSUMER_SECRET.

run \`bundle install`

Set up a daily cron of Heroku scheduler to run \`rake increment_daily_goals`

Carry on as per usual with a Rails app.