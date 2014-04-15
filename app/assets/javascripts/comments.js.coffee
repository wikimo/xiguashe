window.CommentApp = 
  comment : (user_id,user_nickname) -> 
    comment_body = $("#comment-textarea")
    new_text = "@" + user_nickname + " "
    if comment_body.val().trim().length is 0
      new_text += ""
    else
      new_text = "\n" + new_text
    comment_body.focus().val comment_body.val() + new_text
    false

  put_nickname : (name, name_array, nickname) ->
    if name != nickname
      name_array.push name


$(document).ready ->
  item_id = $("#item_id").val()

  current_nickname = $("#current_name").val()

  item_type = $("#item_type").val()


  if item_id
    $.ajax
      type: "get"
      url: "/comments/get_comment_user/#{item_id}/#{item_type}"
      success:(data) ->
        data = eval(data)
        name_array = new Array()
        
        CommentApp.put_nickname(obj[1], name_array, current_nickname) for obj in data

        $("#comment-textarea").atwho
          at: "@"
          data: name_array


