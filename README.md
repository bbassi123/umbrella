# Umbrella

In this project, we'll write a Ruby program that uses the Google Maps API and Dark Sky API to tell the user whether or not they need to carry an umbrella with them.

## Solution

There is a solution in the file called `solution.rb`.

- You can run it to see how the program should behave:

    ```
    ruby solution.rb
    ```
- Try it out with some rainy locations — [you should be able to find some using this live radar](https://www.rainviewer.com/weather-radar-map-live.html).
- Don't peek at the solution until you've tried things yourself.

## Program outline

Here is a suggested outline for your program:

- Ask the user for their location.
- Get and store the user's location.
- Get the user's latitude and longitude from the Google Maps API.
- Get the weather at the user's coordinates from the Dark Sky API.
- Display the current temperature and summary of the weather for the next hour.
- For each of the next twelve hours, check if the precipitation probability is greater than 10%.
    - If so, print a message saying how many hours from now and what the precipitation probability is.
- If any of the next twelve hours has a precipitation probability greater than 10%, print "You might want to carry an umbrella!"

    If not, print "You probably won't need an umbrella today."

## Useful links

Some handy links:

 - [JSONView Chrome extension](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en)
 - [Dark Sky forecast at the Merchandise Mart for humans](https://darksky.net/forecast/41.8887,-87.6355/us12/en)
 - Dark Sky forecast at the Merchandise Mart for machines:
 
     ```
     https://api.darksky.net/forecast/REPLACE_THIS_PATH_SEGMENT_WITH_YOUR_API_TOKEN/41.8887,-87.6355
     ```

     **You'll need an access token to view this page. Find it in the assignment on Canvas.**
 - [Dark Sky API docs](https://darksky.net/dev/docs)
 - [Map of Merchandise Mart for humans](https://goo.gl/maps/2mXdvBnHSGuMq98m6)
 - Map of Merchandise Mart for machines:

    ```
    https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=REPLACE_THIS_QUERY_STRING_PARAMETER_WITH_YOUR_API_TOKEN
    ```

    **You'll need an access token to view this page. Find it in the assignment on Canvas.**
 - [Google Geocoding API docs](https://developers.google.com/maps/documentation/geocoding/start)
 - [How to store secrets securely on Gitpod](https://chapters.firstdraft.com/chapters/792)

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
- You can use [a `Range`](https://www.rubyguides.com/2016/06/ruby-ranges-how-do-they-work/) along with the `[]` method to access a specific set of elements within an `Array`:

    ```ruby
    array = [8, 3, 1, 19, 23, 3]

    p array[2..4] # => [1, 19, 23]
    ```
