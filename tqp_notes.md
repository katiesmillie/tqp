July 8

#Javascript checklist
- check the js file in sources
- always wrap the js code in "ready"
- use an alert to verify js has loaded

Understand
- Events (.on) (.ready)
- Selector ( how to access elements, use console to find the right one)
- Manipulators (what you want to do to the element)
- Traversal http://api.jquery.com/category/traversing/


- try making document.scroll on expand


- plugins for image gallerys, carousels, music, etc.

- ajax (eg post a comment, edit in line, other stuff without reloading page...)

------------

- export nathan's setting
- tomorrow night for sublime text
- squeel --> for longer query types


#NEW idea
- branch of the question project where you answer the same questions every week and the chart is displayed. More like a "rate your week" type of idea

- Add ability for users to make their own questions


#NEW TO DO
- Group answers by month (expandable) and 


-----------------------
#nathan 
- questions controller --> #want to compare these lists to @recent_question array and eliminate any ids that match ids in the array?

- when you are doing SQL search with two params do you also use this syntax @recent_rounds=Rounds.where("created_at < ? AND pair_id = ?", 30.days.ago.midnight, @pair.id)
- add search terms inside the box


# product notes

- I want it to have more of a journal or scrapbook feel. The user should feel like they are creating an artifact that looks nice that they own with their friend. Could potentially hook up to Day One or have ability to export journal entries or back up in dropbox as text file etc. 
- Both me and Christi using it in a "catch up" style.

- write blog post about cloud mailin?

#To do:

- EDGE CASE disable ability to scroll to next round, if current time less than round date (in case where round is created manually before midnight)

- clump by months in main index view?

- encrypt answers for privacy (strongbox)
- finish work on FB login - add profile pic (maybe just use fb connect)

- add some css styling to emails
- email copy should have more variety
- write a welcome email (as part of devise email?)

- set up google analytics for email (tracking links?)
- figure out mixpanel for events

- add question types
- Make it so pairs only get questions from me and questions from themselves?

- hide secret token
- support multiple pairs

- create a favicon and a logo?
- would be nice to badge new activity somewhere in a notification
- add a way to disable the email messages or just get once a week
- use user's personal timezone instead of pacific (user column for timezone) http://spilth.org/notes/rails3-date-time/
- add emoticon with each answer
- how to access past answers to same question? 
- inline editing
- let users save answers in day one or evernote (api)

# NOTES:

#generate
DONT USE TYPE - it's reserved for some other shit

rails g migration add_first_name_to_users first_name:string
rails g migration add_round_date_to_rounds round_date:date
rails g migration add_score_to_dish score:string
rails g migration add_user_id_to_answers user_id:integer
rails g mailer questions_mailer

rails g migration add_accepted_to_invites accepted:boolean
rails g migration remove_user_id_to_invites user_id_:integer

rails g model comment (singular)
rails g controller comments (plural)

rails g migration remove_round_id_from_rounds round_id:date
rails g migration remove_body_from_people body:string:index
rake db:migrate

change_column :dishes, :score, :integer


#tasks
rake email_question

#console
p = Pair.create (:user1_id => 1, :user2_id =>2)
p = Pair.first
p.user1
p.rounds
r = p.rounds.create
r = p.rounds.create :question_id => 22
r = p.rounds.second
r.question
p.rounds.create :pair_id => 1, :question_id => 3
1.day.ago
1.day.from_now
Time.zone.now
Time.zone = -8
Time.zone.now

c = Comment.create(:body => "whats up", :author_id =>1, :round_id => 1)
round=Round.where(:round_date => 1.day.from_now.midnight).first_or_create(:question_id => 3, :pair_id => 1)
round=Round.where(:round_date => 2.day.from_now.midnight).first_or_create(:question_id => 3, :pair_id => 1)

$ rails c
u = User.find_by_email('katiesmillie@gmail.com')
User.mail_answer(u)

#heroku
heroku config (see all add on keys, etc)
heroku run rake email_question
heroku run rake db:migrate

git push heroku master
heroku run console
heroku addons:open scheduler

heroku run rake db:drop  / heroku run rake db:reset --> heroku does not allow persmissions for either of these, try running: heroku pg:reset DATABASE

heroku run rake db:migrate
heroku restart

it remote rm heroku
heroku git:remote -a the-question-project

#git
git diff
git status
git reset --soft
git reset --hard
git revert 290f2e208a655f3df2673bc46ef2a65d26618a75
git branch choose_question
git checkout master
git checkout choose_question
git merge choose_question

git revert 2f783a47007e3526be78041054da38b22ac87285
38827ab314ac322078bf8d9e9a8ddd16416e4278

#helpful
rake time:zones:all  --> displays list of all available timezones

@intro=["a", "b", "c"].sample

YAML.load_file("config/emails.yml")["intro"].sample
gem yaml_record

#ruby
.blank
.present
.empty

-%>  (this stops the html from adding a new line)

#rails
hooks/callbacks
- before or after
- create, update, save ,delete
eg. after_create

self.mail (class method) 
@user.mail_accepted
User.mail_accepted(@user)
 
#guard
 @partner=@pair.try(:partner, @user.id)
 return redirect_to new_pair_path unless @partner
 
 return unless @invite
 next unless @round (within a loop, goes to next item)
 
#ternary operator
 @user ? @user.name : "unknown"

# COMPLETED TASKS
x- use different colors for differen months
x- Add a confirmation message to the top of rounds index when someone answrs a question, then on next visit show them the I already answered message. 
x- Add styling to emails
x- More styling fixes throughout the app
x- custom button
x- fix padding
x- research and fix icon issue


x- recent questions is working in the console but not actually omitting the ids in display on questions#new page
x- scope question sample should not duplicate questions
x- make random not pick questions that have been seen in past 20-30 days

x- Check on code for displaying old answers. I don't think it's working
x- put the date on the question
x-stoppped happening- add next and back buttons to rotate through rounds easily (I'm getting nil for queries that shouldn't be nil -->  Round Load (0.4ms)  SELECT "rounds".* FROM "rounds" WHERE "rounds"."pair_id" = 11 AND "rounds"."round_date" = '2013-04-08' LIMIT 1
=> nil)
x- fix bug "delete partnership" redirect
x- angie email bug
x- next unless pair, [PROJECT_ROOT]/app/models/user.rb, line 38
x- Users.each do vs Users.all.each do
x- there needs to be a way to reflect back on past answers, OHLife puts theirs in the email. 
x- change scheduler to generate rounds at midnight
x- create a reminder email for invite
x- it must be easier to pair up
x- weekly digest of qs and as?
x- If you answer question from previous day before noon on current day should you get to create a round first for the current day and then for the next day? (answer - rounds should be automatically generated at midnnight)
x- maybe change the choose the next question not to be part of the flow, but just at the top as an option?
x- if i want to set up a list of different copy to rotate through emails, what is the best way to do this? 
x- what is -%>  (this stops the html from adding a new line)
x- how do I set rails admin access only on production? - change admin access to only apply in production
x- bug with comments, 
x- adding a lot of if logic to account for this error "undefined method `partner' for nil:NilClass"
example pages controller, new user  (.try)
x- gem 'better_errors', :group => :development
x- connect invites to create pairs  (click here to sign up and become a pair?)
x- let users edit profile before they chose a partner
x- after pair create need to email the other user, maybe email them both the round question?
x- style flash alert?
x- sign up flow, embed invite 
x- add confirmation message: your invite was sent!
x- protect new pairs page to only users who don't have a pair
x- add copy to rx- fix char count on edit answer/comment and comment
x- create landing page for new users - who their partner is, first question, etceply to email
x- fix bug where answers aren't showing up in Christi's emails to me
x- fix bug where rounds index says view round when it should say answer round (if you're parner has answered)
x- add flash error message when pair is not created because pair already exists
x- if they accept invitation and have existing account it will link them
x- display type of invite based on whether you have a partner or not
x- add column to invite, signed up?
x- replies to emails should create an answer for that round https://devcenter.heroku.com/articles/cloudmailin#getting-started-receiving-mail
x- don't go through new question flow unless you are answering TODAY's round - (or just go through it if the current day's round doesn't already have a question)
x- bug when editing answers, answer doesn't save and it redirects to answer page instead of round page
x- remove it from other places - like signed in successfully
x- can't save matt's answer cause it was too long (for now I wont let you type more than 255)
x- how to see trace of new email reply method
x- check on logic used to fix user.mail_question (the solution seems too heavy)
x- migration issues (why did I have to delete the two migration files to deploy on heroku?)
don't check in migrations that were mistakes (they cancelled each other out)
x- no results message only appear AFTER hitting search
x- add no search results
x- add blank states (answer history)
x- tell a friend from a profile page
x- add invite a friend
x- fix email bug, if partner has not answered
x- add new relic plugin on heroku
x- set up events in mixpanel  (got the basics started) -- should I use javascript or ruby library?
x- add remainder of questions in
x- add message about new questions
x- add refresh to question new
x- email when someone comments on a round
x- after user answers a question get error on heroku, does not display questions/new 
x- first user that answers, creates two answers --> doesn't seem to be happening anymore
x- rake round create -- round is created on UTC not PST --. this isn't an issue since scheduler is going at 11:30am PST
x- make sure future rounds don't show up on index --> because questions#new isn't working rounds aren't getting created in the future so not really worries about this right now.
x- check in other browsers
x- generate a round when a user first creates a pair -
x- style gravatar
x- fix emails with answers
x- only katie can be an admin
x- fix UTC issue on heroku
x- auto focus first name on sign up
x- fix email link 
x- hook up gravatar
x- on pairs new make input box smaller for email search
x- form styling fucked up devise forms. 
x- don't display box on create pair and create comment until there is content to go there
x- make some things look a little better
x- only display edit if it's YOUR content (filter? helper?)
x- add more on welcome and about page explaining the product
x- fix exception when answering a question from round that is before today's date (had to do with answer email, passed the round to the fix it)
x- remove the delete link from the answers index
x- emails should link to specific round for that day
x- change the profile page so users can edit their data and view their pairs and question history
x- after choosing a pair redirect user to their profile
x- how do you reset a single table in a database but not the whole database?- drop table in migration, then run individual migration
x- email should send question for today's round (--> need to test)
x- new email should tell user when pair answered a question
x- fix heroku  - reset and migrate
x- create rake task for create round for round_date if round isn't already created
x- edit user profile
x- prevent pair create if either person already has a pair
x- schedule a task to run each day at noon? OR should it create as part of the email (probably easier right -- but what if someone doesn't want email)
x- add fields to sign up 
x- when I sign in I'm redirected to new#pair even on users that have pairs
x- restrict users to only belong to 1 pair
x- finish pair#new and pair#create
x- add pair#show
x- delete a pair
x- move invite to filter in rounds controller
x- take out delete everything, edit only
x- edit comments (for fun!)
x- round index has the correct date in PST , on round show it's incorrect
x- set up google analytics for web
x- logic so you can't answer a round until today's date = or > round_date
x- add comments to round#show
x- view comments on round#show
x- clear out data (rake db:reset!)
x- add comment model
x- Convert all times to PST (in config/application file), had to do it in two places
x- add new migrations to models
x- add whether other user has answered question
x- logged out home page/welcome screen
x- display author's name in comment index (tried and failed)
--> - If using author_id as a column name, how do you tell the app that author_id = user_id, so that I can get the first_name of a user
x- how to create a pop up error message (eg try to answer a round before the round date) -- or I could just not have the link/round page accessible
x-  --> round ids are not unique to the pair. shouldn't the ULR be something like thequestionproject.com/rounds/2
x- replace your partner with first name --> How do I access the pair model from answers#new, so that I can get the first name of the user's partner?
x- user on home should see only their rounds (tried and this didn't work) --- Do rounds need to belong to a user? or is that redundant with pair? how come @answers=current_user.answers.order "created_at DESC" works but @rounds=current_user.rounds.order "created_at DESC" does not work. - Rounds don't have concept of user so current_user doesn't work, should i define current_pair
x- We moved @pair definition to the model, but then I couldn't get it to work in the controller, so I just repeated the code so it would work
x- set logic so there is only one round per day (tried a few ways to do this)
--> first or create method is not working -- was going to try to write and if statement, but this seems cleaner. what's the right way?
x- sign up flow including pair#create, do I need users controller? how do I work with devise
