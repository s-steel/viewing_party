# Viewing Party
BE Mod 3 Group Project

Forked repository from the [Turing School](https://turing.io/) viewing_party project.


![Viewing Party!](https://media1.giphy.com/media/F47qASXDMJcOY/100.webp?cid=5a38a5a2xx88e5fr1rrpuiewzlzxt6bp8352tvkzabpu3bb8&rid=100.webp)




Collaboration between: [Joshua Carey](https://github.com/jdcarey128), [Aidan Murray](https://github.com/TeknoServal), and [Sean Steel](https://github.com/s-steel)


## Check it out [Here!](https://viewing-party-2008-jas.herokuapp.com/)


## Background and Description

"Viewing Party" is an application to explore movies and create a viewing party event for you and your friends to watch a movie together.  All movie data was taken from [The Movie Database API](https://www.themoviedb.org/).  The main technical skills we used for this project was to consume a JSON API with multiple endpoints, build an application that requires basic authentication, implement a self-referential relationship, and utilize TravisCI for continuous integration, amoung other explicit and implicit skills.  For this project, we held true to the principles of Object Oriented Programming, and our development strategy centered around Test-Driven Development.  We used Heroku to delpoy our app and Rubocop to enforce style guidlines.

This is a short explaination of each piece of functionality that we implemented.


### Table of Contents
***
**[Database Schema](#database-schema)**<br>
**[Welcome](#welcome)**<br>
**[Registration](#registration)**<br>
**[Dashboard](#dashboard)**<br>
**[Discover](#discover)**<br>
**[Movies](#movies)**<br>
**[Movie Details](#movie-details)**<br>
**[Viewing Parties](#viewing-parties)**<br>
**[Next Time](#next-time)**<br>
**[Try it Yourself](#try-it-yourself)**<br>

***

## Database Schema

![Database Schema](https://user-images.githubusercontent.com/65255478/101717251-2a89ac80-3a5c-11eb-9bab-2716fcf09457.png)

***

## Welcome

For the welcome page we created a welcome message and a brief description of the project.  This is also the page that has a form to log in and a link to register with our app.  Logging in and registering uses `BCrypt` to encript a user's password so that their actual password is not stored in the database.

## Registration

After clicking on the `register` link within the welcome page a user is taken to a new page with a form that they will need to fill out inorder to register with the app.  After a user fills in the form they are redirected to the dashboard page.  If the user does not completely fill out the form, or fills out the form with invalid information then they will see a flash message explaining what they did wrong and the form will be refreshed on the current page.  A user must be authenticated before they can go to any of the other pages.

## Dashboard

This is the page that the user is redirected to once they have registered or logged in.  Here they will see a welcome message with their username.  There is also a button to discover movies, and if they click it they will be taken to the discover page which we will discuss in the next section.  There will also be a section to see their friends and a field to add in friends, and any viewing parties that they have been invited too.  If the user fills in the text field with the email address of a friend then that user will be added to their friend list.  They can only add a friend that is a user of the application and is in the database.  Here is where the self referential relationship comes into play.  A user can have many friends and they can also have many followers.  These are tied together through a friendship class that allows us to see followers and followed of a user.

## Discover

Here is where the user can really explore the movies available through the API.  One feature on this page is the `Discover Top 40 Movies`.  This will redirect the user to the movie page where they are shown a list of 40 movies that have the best rating.  The user is also able to search for a movie by the movie title.  Entering keywords into the text field and clicking search will bring the user to the movie page that displays up to 40 search results.  This funtionality consumes two endpoints for out API, between the top movies and the movie search.

## Movies

This movies page is where the top 40 movie list is displayed or the movie search results.  From here, all of the movie titles displayed are links that the user can click.  They will then be taken to a page with the details of that movie.  Next to each movie title on this page you will also see the average rating.

## Movie Details

Here is where the details are show for an individual movie.  The user will see the movie title, average rating, run time, genres associated with that movie, a summary, list of cast members including their character name(s), reivews with the author name, and a list of similar movies.  The information on this page consumes four different API endpoints (reviews, cast, similar movies, and the rest of the movie details).  After receiving the data from the endpoints we then needed to manipulate it to present it in the format we were looking for.  Also on this page is a button to create a viewing party.  

## Viewing Parties

From the page with the movie details the user can click the button to create a new viewing party.  They will then be taken to a new page to create a viewing party.  Here the user can fill in the form with the date and time for the party and they will see check boxes next to the names of any friends.  By checking a box they add that friend to the party.  After creating the party the user will be taken back to their dashboard will they will see the viewing party listed with the details along with if they are the host or if they are invited to the party.  We also used `ActionMailer` to send an email to any friends that are invited to a viewing party with the date, time, movie title, and the name of their friend that is hosting.

## Next Time

If we had more time we would have attempted to tackle all of the advanced exploration cards on the project board.  This includes writing front-end javascript, and implementing chat functionality with ActionCable.  Besides these objectives there is always room to refactor and clean up our code!

## Try It Yourself

Visit this [repo](https://github.com/turingschool-examples/viewing_party), and follow along with the Viewing Party project board!  Use each of these cards as a guide to build out tests, then develop functioning parts of the project from there.
