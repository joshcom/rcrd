<a href="https://codeclimate.com/github/jeffcarp/rcrd"><img src="https://codeclimate.com/github/jeffcarp/rcrd.png" /></a>

# rcrd

rcrd is a tool I built to track habits, like exercise or drinking.

- Time zones
X Authentication
X Clean up db schema

# How I think Time Zones should work:

- The time zone of a record is determined by going back in time and finding the first most recent record that contains a "time zone" cat.
- A record with the cats "time zone", "Tokyo" - for instance, will set all subsequent records time zones to Tokyo (until another record containing "time zone" is entered).

Record.target
- :target is stored as UTC
- Time zone is determined as above

# Ideas

- Instead of date field, logarythmic sliding date picker? (specific enough to choose hours out of yesterday, today, yesterday, general enough to choose last/next week?).
