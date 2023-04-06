# Umbrella

In this project, we'll write a Ruby program that uses the Google Maps API and Pirate Weather API to tell the user whether or not they should carry an umbrella with them when they leave home.

## Solution

There is a solution in the file called `solution.rb`.

- You can run it to see how the program should behave:

    ```
    ruby solution.rb
    ```
- Before it will work, you need to create two **environment variables** in your Gitpod dashboard.
    - [Read how to create environment variables here.](https://chapters.firstdraft.com/chapters/792)
    - You need to create env vars called `GMAPS_KEY` and `PIRATE_WEATHER_KEY`. You'll find the values to assign in the assignment in Canvas.
    - When asked for "Organization/Repository", say `*/*`. This will make the env vars available across all of your workspaces.
    - Don't forget to restart your workspace after the variables have been saved
        - In your [Gitpod dashboard](https://gitpod.io/workspaces), find the workspace.
        - Click on the three dots next to its name.
        - Stop.
        - Once it has shut down, Open it again.
- Then, try running `solution.rb` and enter some rainy locations — [you should be able to find some using this live radar](https://www.rainviewer.com/weather-radar-map-live.html).
- Don't peek at the solution until you've tried things yourself.

## Program outline

Here is a suggested outline for your program:

- Ask the user for their location.
- Get and store the user's location.
- Get the user's latitude and longitude from the Google Maps API.
- Get the weather at the user's coordinates from the Pirate Weather API.
- Display the current temperature and summary of the weather for the next hour.
- For each of the next twelve hours, check if the precipitation probability is greater than 10%.
    - If so, print a message saying how many hours from now and what the precipitation probability is.
- If any of the next twelve hours has a precipitation probability greater than 10%, print "You might want to carry an umbrella!"

    If not, print "You probably won't need an umbrella today."

## Useful links

Some handy links:

 - [Hoppscotch](https://hoppscotch.io/): a great, free, online tool that makes it easy to experiment with API calls and see the JSON reponses nicely formatted.
 - [How to store secrets securely on Gitpod](https://chapters.firstdraft.com/chapters/792)

### Pirate Weather links

 - [Pirate Wather forecast at the Merchandise Mart for humans](https://merrysky.net/forecast/merchandise%20mart/us)
 - Pirate Weather forecast at the Merchandise Mart for machines:
 
     ```
     https://api.pirateweather.net/forecast/REPLACE_THIS_PATH_SEGMENT_WITH_YOUR_API_TOKEN/41.8887,-87.6355
     ```

     **You'll need an access token to view this page. Find it in the assignment on Canvas.**
 - [Pirate Weather API docs](https://docs.pirateweather.net/en/latest/Specification/)
 
### Google Maps links

 - [Map of Merchandise Mart for humans](https://goo.gl/maps/2mXdvBnHSGuMq98m6)
 - Map of Merchandise Mart for machines:

    ```
    https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=REPLACE_THIS_QUERY_STRING_PARAMETER_WITH_YOUR_API_TOKEN
    ```

    **You'll need an access token to view this page. Find it in the assignment on Canvas.**
 - [Google Geocoding API docs](https://developers.google.com/maps/documentation/geocoding/start)

## Useful methods

Most of working with APIs boils down to working with [`Array`s](https://chapters.firstdraft.com/chapters/758) and [`Hash`es](https://chapters.firstdraft.com/chapters/767).

You will likely also need to use [`if` statements](https://chapters.firstdraft.com/) and [loops](https://chapters.firstdraft.com/chapters/764) (most useful programs do).

Here are some less familiar methods that will be useful:

- `URI.open()`: The argument to `URI.open` should be a `String` containing a URL. The method will then read the page at the provided URL and return it as a `Tempfile`.
    - In order to use this method, we must `require "open-uri"`.
- `Tempfile#read`: If you call `.read` on an instance of `Tempfile`, it will return the contents of the file as a `String`.
- `JSON.parse()`: The argument to `JSON.parse` should be a `String` containing valid JSON. The method will transform the JSON objects into Ruby objects.
    - In order to use this method, we must `require "json"`.
- `Time.at()`: The argument to `Time.at` should be an `Integer` representing the [Epoch time](https://en.wikipedia.org/wiki/Unix_time). The method will transform the `Integer` into an instance of `Time`.

    You could also try [this online epoch time converter](https://www.epochconverter.com/).
- You can use [a `Range`](https://www.rubyguides.com/2016/06/ruby-ranges-how-do-they-work/) along with the `[]` method to access a specific set of elements within an `Array`:

    ```ruby
    array = [8, 3, 1, 19, 23, 3]

    p array[2..4] # => [1, 19, 23]
    ```
    
## Stretch goal
  
Use [the ascii_charts gem](https://github.com/benlund/ascii_charts) to produce output that includes a chart, like this:
  
```
========================================
    Will you need an umbrella today?    
========================================

Where are you?
brooklyn
Checking the weather at Brooklyn....
Your coordinates are 40.6781784, -73.9441579.
It is currently 51.33°F.
Next hour: Possible light rain starting in 25 min.
 
Hours from now vs Precipitation probability
 
80|                                    
75| *                                  
70| *                                  
65| *                                  
60| *                                  
55| *                                  
50| *                                  
45| *                                  
40| *                                  
35| *                                  
30| *                                  
25| *                             *  * 
20| *                          *  *  * 
15| *              *  *  *  *  *  *  * 
10| *           *  *  *  *  *  *  *  * 
 5| *  *  *  *  *  *  *  *  *  *  *  * 
 0+-*--*--*--*--*--*--*--*--*--*--*--*-
    1  2  3  4  5  6  7  8  9 10 11 12 
 
You might want to take an umbrella!
```
