**What is this?**  
  
Fitbit Goal Incrementer does exactly what it says on the tin - it's a script you can set up to increment your Fitbit goal(s) each day.  
  
By default, it's set up to increment your steps goal by 10 steps per day. Assuming you're starting off with the default goal of 10,000 steps/day, tomorrow your goal would be raised to 10,010 steps, and two days from now it would be 10,020 steps, &c.  
  
The point is to nudge yourself to keep pushing yourself more and more, and not grow complacent when your goals become easy for you.
  
**Setup**  
  
Clone this repository. 
  
Go to https://dev.fitbit.com/apps/new and register a new application. Make sure your application type is set to 'Desktop'.

Create a file called 'env.yml' in this project's directory, and set it up with the values from your new Fitbit application and your account:

\---  
consumer_key: YOUR_FITBIT_CONSUMER_KEY  
consumer_secret: YOUR_FITBIT_CONSUMER_SECRET  
user_id: YOUR_FITBIT_USER_ID

run \`bundle install`

run \`ruby fitbit_goal.rb` to go through the verification process and do your first goal increment.

run \`chmod a+x fitbit_goal.rb`

To add it as a daily cron, add some version of the following line to your crontab:  
  
*/10 * * * * . ~/.bash_profile; cd PATH_TO_THE_DIRECTORY_FOR_REPOSITORY; ./fitbit_goal.rb