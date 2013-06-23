# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
window.LikeApp =
  loading : () ->
    console.log "loading..."

  # 警告信息显示, to 显示在那个dom前(可以用 css selector)
  alert : (msg,to) ->
    #$(to).before("<div data-alert class='alert-message'><a class='close' href='#'>X</a>#{msg}</div>")
    $(to).before("<div class='alert'><a class='close' data-dismiss='alert'>×</a>#{msg}</div>")
    
  likeable : (el) ->
    likeable_type = $(el).data("type")
    
    
    likeable_id = $(el).data("id")
   	likeable_state = $(el).data("state")
    if $(el).data("state") != "liked"	
      $.ajax
        url : "/likes"
        type : "POST"
        data : 
          type : likeable_type
          id : likeable_id
        success : (re) ->
          if parseInt(re) >= 0
            $(el).data("state","liked").attr("title", "取消喜欢")
            $('span',el).text("#{re}人喜欢")
            $("i.icon",el).attr("class","icon small_liked")
          else
            LikeApp.alert("抱歉，系统异常，提交失败。")
    else
    	
      $.ajax
        url : "/likes/#{likeable_id}"
        type : "DELETE"
        data : 
          type : likeable_type
        success : (re) ->
          if parseInt(re)  >= 0
            $(el).data("state","").attr("title", "喜欢")
            $('span',el).text("#{re}人喜欢")
            $("i.icon",el).attr("class","icon small_like")
          else
            LikeApp.alert("抱歉，系统异常，提交失败。")
    false