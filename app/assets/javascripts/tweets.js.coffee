# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
source = new EventSource('/tweets/events')
source.addEventListener 'message', (e) ->
	tweet = $.parseJSON(e.data)
	console.log(tweet.content)
	$('#tweets').append($('<li>').text("#{tweet.content}: #{tweet.sentiment}"))
