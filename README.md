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


## Data
  All the necessary data is available in the two csv files in the data directory:

1. Batting-07-12.csv – Contains all the batting statistics from 2007-2012.
2. Master-small.csv – Contains the demographic data for all baseball players in history through 2012.

## How to Use
ruby performance.rb -p absolute_path_to_Batting-07-12.csv
                    -s absolute_path_to_Master-small.csv
                    -i 2010
                    -l 2007-OAK
                    -t 2011-AL:2011-NL:2012-AL:2012-NL

or just 
   ruby performance.rb -h
   
## Flexibility
The Record class provides some ActiveRecord like functionality, namely the ability to call obj.attribute and 
                    obj.attribute= through method_missing.  New record objects are created with a Hash argument.  The 
                    initialize method adds the hash keys and values to itself and registers the new object with the
                    Record class.  Subclasses of Record can be thought of as tables with primary keys.  Primary keys are
                    defined in the keys class instance variable.  All of the interesting class methods are defined in the
                    parent class Record.

## Summarizing Data
The data provided in Batting-07-12.csv is keyed by player, year, league and team.  As we all know players move from 
team to team and league to league during the season.  MLB probably has rules surrounding how to calculate slugging percentage
and triple crown eligibility for a player who changed teams or leagues.  For this exercise I simply aggregated the player's data for the 
key values that relate to the wanted statistic.  For example, to calculate the league triple crown I counted performance in the NL and AL separately.
Also, if a player switched teams calculating slugging percentage from that player on that team would not take into account the performance
the player had on the other team.

Data is summarized in the StatPlayerYear and StatPlayerYearLeague classes.
                    
## License

MIT-LICENSE
