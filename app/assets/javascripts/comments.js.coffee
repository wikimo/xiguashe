# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
window.CommentApp = 
	comment : (user_id, user_nickname) ->
	  comment_body = $("#comment-textarea")
	  new_text = "@" + user_nickname
	  if comment_body.val().trim().length is 0
	    new_text += ""
	  else
	    new_text = "\n" + new_text
	  comment_body.focus().val comment_body.val() + new_text
	  false

$(document).ready -> 
	topic_id = $("#topic_id").val()
	if topic_id
		$.ajax
		    type: "get"
		    url: "/groups/members"
		    data: 
		    	topic_id : topic_id
		    success: (data) ->
		      data = eval(data)
		      name_array = new Array()
		      i = 0

		      while i < data.length
		        name_array.push data[i].nickname
		        i++
		      $("#comment-textarea").atwho
		        at: "@"
		        data: name_array
