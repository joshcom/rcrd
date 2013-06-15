<a href="https://codeclimate.com/github/jeffcarp/rcrd"><img src="https://codeclimate.com/github/jeffcarp/rcrd.png" /></a>
<a href="https://travis-ci.org/jeffcarp/rcrd/"><img src="https://travis-ci.org/jeffcarp/rcrd.png?branch=edge" /></a>

# rcrd

rcrd is a tool I built to track habits, like exercise or drinking.

## How Time Zones work

- The time zone of a record is determined by going back in time and finding the first most recent record that contains a "time zone" cat.
- A record with the cats "time zone", "Tokyo" - for instance, will set all subsequent records time zones to Tokyo (until another record containing "time zone" is entered).

## Ideas

- Instead of date field, sliding date picker? (specific enough to choose hours out of yesterday, today, yesterday, general enough to choose last/next week?).
