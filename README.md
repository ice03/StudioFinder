# StudioFinder
Application implements searches for places used for performance or production of music.

Input would be a search term for places used for performing or producing music<br/>
Output would be places as pins on a map<br/>
Requirements Must be written in Objective-C or Swift<br/>
Use MusicBrainz API (https://wiki.musicbrainz.org/Development)<br/>
Places returned per request should be limited, but all places must be displayed on map. For example there 100 places for search term, but limit is 20, so you need 5 request to get all the places<br/>
Make this limit easy to tune in code<br/>
Displayed places should be open from 1990<br/>
Every pin has a lifespan, meaning that after that time, they will have to be wiped out from the map<br/>
Lifespan is calculated like this: open_year - 1990 = lifespan_in_seconds. Example 2017 - 1990 = 27 seconds<br/>
Use stock Cocoa UI elements<br/>
Do not use any third party libraries<br/>
Produce clean code<br/>
Karma for Following the best OOP practices<br/>
Using the most up­to­date conventions you are aware of<br/>
Employing multithreading wherever it suits and making sure the UI is fluid and responsive during the entire execution of the application<br/>
