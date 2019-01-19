# StudioFinder
Application implements searches for places used for performance or production of music.

Input would be a search term for places used for performing or producing music
Output would be places as pins on a map
Requirements Must be written in Objective-C or Swift
Use MusicBrainz API (https://wiki.musicbrainz.org/Development)
Places returned per request should be limited, but all places must be displayed on map. For example there 100 places for search term, but limit is 20, so you need 5 request to get all the places
Make this limit easy to tune in code
Displayed places should be open from 1990
Every pin has a lifespan, meaning that after that time, they will have to be wiped out from the map
Lifespan is calculated like this: open_year - 1990 = lifespan_in_seconds. Example 2017 - 1990 = 27 seconds
Use stock Cocoa UI elements
Do not use any third party libraries
Produce clean code
Karma for Following the best OOP practices
Using the most up­to­date conventions you are aware of
Employing multithreading wherever it suits and making sure the UI is fluid and responsive during the entire execution of the application
