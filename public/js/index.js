//jQuery.ajax
$(function(){
  'use strict';
  var gameWatcher;
//  var sa = '//localhost:3000';
  var sa = 'http://localhost:3000';

  $('#register').on('click', function(){
    // '/register' is tacked onto the end of the URL. Look at the 'API End-Points' table in documentation for clarification on what this does
    $.ajax(sa + '/users', {
      // in order to send this is json, we need to specify contentType - because we're sending json, the contentType is the string 'application/json'
      // http://api.jquery.com/category/ajax/ -- look up stuff about contentType and processData, etc.
      //because we're sending data, we have to specify a content type
      contentType: 'application/json',
      processData: false,
      // this is the data I want to send - for now just going to put an empty object
      // we do stringify - it takes the object and turns it into JSON
      // I want to send what's in the API (credentials). Going to specify credentials. From what the API says, there are two keys: email
      data: JSON.stringify({
        credentials: {
          // inside of val: what do I want to get out of email?
          email: $('#email').val(),
          // an extra step for us would be to verify a password confirmation. Can do this before Friday if I want.
          password: $('#password').val(),
          password_confirmation: $('#password').val()
        }
        // doing this so we can see what's actually been entered
      }),
      // what you expect to be returned
      dataType: 'json',
      method: 'POST'
      // .done takes a function - that function takes data, textStatus, and jqxhr
    }).done(function(data, textStatus, jqxhr){
      $('#result').val(JSON.stringify(data));
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('registration failed');
    });
  });

//this is adding a click handler for the login button
  $('#login').on('click', function(){
    $.ajax(sa + '/login', {
      contentType: 'application/json',
      processData: false,
      data: JSON.stringify({
        credentials: {
          email: $('#email').val(),
          password: $('#password').val(),
        }
      }),
      dataType: 'json',
      method: 'POST'
    }).done(function(data, textStatus, jqxhr){
      $('#token').val(data.token);
      // once we have a token, we can get a list of games
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('login failed');
    });
  });

// when you click on list, look at all the games, we expect json to come back. we've addeda header - if we have a valid token, allows us to see the list of games - we'll put that in a result box
  $('#list').on('click', function(){
    $.ajax(sa + '/users', { // doesn't require contenttype, processdata, or data because we're doing a GET
      dataType: 'json',
      method: 'GET',
      // specifying extra headers. The reason for the Authorization header - once you've logged in, you need a mechanism to tell the API that you have logged in / are a user. Don't want to keep storing username / password locally. The system generates a token when someone logs in (won't work next time, and has an expiry).
      headers: {
        Authorization: 'Token token=' + $('#token').val()
      }
    }).done(function(data, textStatus, jqxhr){
      $('#result').val(JSON.stringify(data));
      // once we have a token, we can get a list of games
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('list failed');
    });
  });

  // this should produce a JSON object. Figure out how to make the data type match my game.
  $('#create').on('click', function(){
    $.ajax(sa + '/games', {
      contentType: 'application/json',
      processData: false,
      data: JSON.stringify({}),
      dataType: 'json',
      method: 'POST',
      headers: {
        Authorization: 'Token token=' + $('#token').val()
      }
    }).done(function(data, textStatus, jqxhr){
      $('#result').val(JSON.stringify(data));
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('create failed');
    });
  });

  $('#show').on('click', function(){
    // grab the value of the ID box
    // 'show' expects us to pass in /games/:id
    $.ajax(sa + '/games/' + $('#id').val(), {
      dataType: 'json',
      method: 'GET',
      headers: {
        Authorization: 'Token token=' + $('#token').val()
      }
    }).done(function(data, textStatus, jqxhr){
      $('#result').val(JSON.stringify(data));
      // once we have a token, we can get a list of games
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('show failed');
    });
  });

// if you call patch, the system connects the user calling it to the game call on
// when you create a game, it sets player x equal to the person who created it. if a different user, then it calls patch (an update function) - for that same game, they will be added as player O.

// There's an update method - it has 2 modes (1. you send it no data (the uesr trying to update is really saying I want to join the game - it's a join function - only works if you're a different user than the X user and if there's no user already set. The user who calls create creates a new game and is player X. A different user can join that game, and that's what we're going to write out now.)

// if you try to join a game that's already appeared, you can't - it'll say join failed
  $('#join').on('click', function(){
    $.ajax(sa + '/games/' + $('#id').val(), {
      contentType: 'application/json',
      processData: false,
      data: JSON.stringify({}),
      dataType: 'json',
      method: 'PATCH',
      // expects an empty PATCH - should get the game back - (game with player O: a player)
      headers: {
        Authorization: 'Token token=' + $('#token').val()
      }
    }).done(function(data, textStatus, jqxhr){
      $('#result').val(JSON.stringify(data));
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('join failed');
    });
  });

// can change the game state
// there is an object that contains the single key state. There are 2 possible properties for that object (1: cell, 2: over- a boolean flag saying whether or not the game is over.)
// Will need to have a player ID- I need to write this - when a move has been made, update the array with the current player / player ID.
// this puts an X in one of the boxes
// going to need to capture an index and a value

  $('#move').on('click', function(){
    $.ajax(sa + '/games/' + $('#id').val(), {
      contentType: 'application/json',
      processData: false,
      data: JSON.stringify({
        // everything the same as join except for this - in the API docs
        game: {
          cell: {
            index: +$('#index').val(),
            value: $('#value').val()
          }
        }
      }),
      dataType: 'json',
      method: 'PATCH',
      // expects an empty PATCH - should get the game back - (game with player O: a player)
      headers: {
        Authorization: 'Token token=' + $('#token').val()
      }
    }).done(function(data, textStatus, jqxhr){
      $('#result').val(JSON.stringify(data));
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('move failed');
    });
  });

// allows a player to make a move, and then allows a player on a different machine to be informed of that move.
// your browser connects to a web server and your browser
// when you run the update, if you've attached to the thing that does streaming, it hears about the update and it sends data to you.
// Create a new var gamewatcher with an appropriate URL so the paths is games/id/watch - specify the token as we were doing before. Can also specify an optional timeout (default is 120 seconds) because streaming consumes resources - needs to eventually stop.
// eventsource allows for streaming of videos (in html5)

  $('#watch').on('click', function(){
    gameWatcher = resourceWatcher(sa + '/games/' + $('#id').val() + '/watch', {
      Authorization: 'Token token=' + $('#token').val()
    });
    gameWatcher.on('change', function(data){
// when I update a cell on one browser, I'll show that cell in a different browser
// Heroku's infrastructure displays an error when a timeout occurs
// Heroku routers report this as a 503, so this error I guess won't actually display
// if I click on watch, it'll set up this watcher
      var parsedData = JSON.parse(data);
      if (data.timeout) {
        gameWatcher.close();
        return console.warn(data.timeout);
      }
      // not parsing this out
      var gameData = parsedData.game;
      var cell = gameData.cell;
      $('#index').val(cell.index);
      $('#value').val(cell.value);
    });
    gameWatcher.on('error', function(e){
      console.log(e);
    });
  });



});
