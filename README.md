# Baseball Stats

## What is it?
Some ruby code that computes baseball statistics from two files.  What statistics you ask:

* Player with the most improved batting average from one year to the next
* Slugging percentage for members of a given team
* Winner of the batting triple crown

## Original Requirements

Overview:  For this scenario, we have been asked to write an application that will be used to provide information about baseball player statistics.  Approach this problem as if it is an application going to production.  We don't expect it to be perfect (no production code is), but we also don't want you to hack together a throw-away script.  This should be representative of something that you would be comfortable releasing to a production environment.  Also, spend whatever amount of time you think is reasonable.  If you don't get all the requirements completed, that's ok.  Just do the best you can with the time that you have available.  You may use whatever gems, frameworks and tools that you think are appropriate, just provide any special setup instructions when you submit your solution.

Assumptions:  All requests currently are based on data in the hitting file.  Future requests of the system will require data from a pitching file as well.  Consider this in the design.

Requirements: When the application is run, use the provided data and calculate the following results and write them to STDOUT.

1. Most improved batting average( hits / at-bats) from 2009 to 2010.  Only include players with at least 200 at-bats.
2. Slugging percentage for all players on the Oakland A's (teamID = OAK) in 2007.
3. Who was the AL and NL triple crown winner for 2011 and 2012.  If no one won the crown, output "(No winner)"

## Formulas

* Batting average = hits / at-bats
* Slugging percentage = ((Hits – doubles – triples – home runs) + (2 * doubles) + (3 * triples) + (4 * home runs)) / at-bats
* Triple crown winner – The player that had the highest batting average AND the most home runs AND the most RBI in their league. It's unusual for someone to win this, but there was a winner in 2012. “Officially” the batting title (highest league batting average) is based on a minimum of 502 plate appearances. The provided dataset does not include plate appearances. It also does not include walks so plate appearances cannot be calculated. Instead, use a constraint of a minimum of 400 at-bats to determine those eligible for the league batting title.


## Data:
  All the necessary data is available in the two csv files in the data directory:

1. Batting-07-12.csv – Contains all the batting statistics from 2007-2012.
2. Column header key:
1.1. AB – at-bats
1.1. H – hits
2B – doubles
3B – triples
HR – home runs
RBI – runs batted in

Master-small.csv – Contains the demographic data for all baseball players in history through 2012.

asd
fa
sdf
asd
fasdf
* Fast and easy user entry of ideas to capture constructive input from a group of any size
* Intelligent prompting to guide users toward agreement and adoption of proposals by discovering where commonalities already exist
* Simple and elegant reporting back to the group to see where consensus stands at a glance
* Integration with Facebook and G+ to pull credentials and push user activity

The master instance work-in-progress instance is hosted <a href="http://spokenvote.herokuapp.com/">on Heroku</a>.

## Getting started

1. Setup your development environment. We recommend (develop and test) against ruby 1.9.3-p194 or higher.
2. Fork the <a href="https://github.com/railsforcharity/spokenvote" target="_blank">Spokenvote repo</a>.
3. Clone your fork locally.
4. Add the master repo as an upstream of yours (see instructions at https://help.github.com/articles/syncing-a-fork)

## Making Changes

Where possible please make your changes in small, cohesive commits. Send separate pull requests for each commit you feel is ready to be added to master.

When doing a larger piece of work, such as the following, please use a feature/topic branch so others can more easily review it.

* The commit includes the addition of, or significant version changes of, gems or libraries used
* The commit is a significant new feature or rewrite of an existing feature

The typical work flow for this is:

### One time setup
 - Add railsforcharity/spokenvote as your upstream using the command
 ```
  $ git remote add upstream https://github.com/railsforcharity/spokenvote.git
 ```
### Before starting a new feature
 - Fetch upstream changes to your local git
  ```
  $ git fetch --all
  ```
 - Merged upstream changes to your local
  ```
  $ git merge upstream/master
  ```
 - Create a new feature branch on local (example: may17_my_shiny_feature)
  ```
  $ git checkout -b may17_my_shiny_feature
  ```
 - Work on your feature
 - Commit your code

### Before pushing to remote master
 - Sync your local master branch from upstream master
  ```
  $ git checkout master
  $ git fetch upstream
  $ git merge upstream/master
  ```
 - Rebase your feature branch on your master
  ```
  $ git checkout may17_my_shiny_feature
  $ git rebase master
  ```
 - Push your changes to your remote
   ```
  $ git push origin checkout may17_my_shiny_feature
   ```

**Tests are always a welcome inclusion!**

## Environment

1. Edit database.example.yml and save as database.yml; this file is in .gitignore so don't worry about checking in your version. *NOTE:* Postgres is the database used in SpokenVote, you must have iit installed before taking the next step; in our experience installing through [homebrew](http://mxcl.github.com/homebrew/) is the easiest way.
2. Run <a href="http://gembundler.com/">Bundler</a> in the project's root directory to install any needed gems.
3. Create and update the database by running `rake db:setup`

## Rails for Charity Account

Participation is managed through the task system at http://RailsForCharity.org. Please create an account for yourself on that site and either pick your work from the existing tasks or add new tasks that you'd like to work on and assign to yourself.

## License

Spokenvote is a public good project distributed under the terms of either the MIT License or the GNU General
Public License (GPL) Version 2 or later.

See GPL-LICENSE and MIT-LICENSE for details.

## Developers

This project is an open source project of Spokenvote.org, supported in large measure by the efforts of RailsForCharity.org.

## FAQ

Q. Who is the intended audience for the Spokenvote web application?

A: At first small groups who need to reach consensus (e.g. non-profits); eventually envisioned to work at the national political level

## Contributing
Please see the <a href="https://github.com/railsforcharity/spokenvote/downloads/">current design wireframes here</a>.

Please ensure you read [the future] STYLE_GUIDELINES before making any contribution to this project.


[logo]: https://github.com/railsforcharity/spokenvote/blob/master/app/assets/images/bluefull.png "Logo"
