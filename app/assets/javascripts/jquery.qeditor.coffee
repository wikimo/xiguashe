###
jquery.qeditor
==============

This is a simple WYSIWYG editor with jQuery.

## Author:

    Jason Lee <huacnlee@gmail.com>

## Requirements:

    [jQuery](http://jquery.com)
    (Font-Awesome)[http://fortawesome.github.io/Font-Awesome/] - Toolbar icons

## Usage:

    $("textarea").qeditor();

and then you need filt the html tags,attributes in you content page.
In Rails application, you can use like this:

    <%= sanitize(@post.body,:tags => %w(strong b i u strike ol ul li address blockquote pre code br div p), :attributes => %w(src)) %>
###

QEDITOR_TOOLBAR_HTML = """
<div class="qeditor_toolbar">
  <a href="#" data-action="bold" class="qe-bold"><span class="icon-bold" title="Bold"></span></a> 		 
  <span class="vline"></span>
  <a href="#" data-action="insertorderedlist" class="qe-ol"><span class="icon-list-ol" title="Insert Ordered-list"></span></a> 
  <a href="#" data-action="insertunorderedlist" class="qe-ul"><span class="icon-list-ul" title="Insert Unordered-list"></span></a> 
  <span class="vline"></span> 
  <a href="#" data-action="insertHorizontalRule" class="qe-hr"><span class="icon-minus" title="Insert Horizontal Rule"></span></a> 
  <a href="#" data-action="createLink" class="qe-link"><span class="icon-link" title="Create Link" title="Create Link"></span></a> 
  <a href="#" data-action="insertimage" class="qe-image"><span class="icon-picture" title="Insert Image"></span></a> 
</div>
"""
QEDITOR_ALLOW_TAGS_ON_PASTE = "div,p,ul,ol,li,hr,br,b,strong,i,em,img,h2,h3,h4,h5,h6,h7"
QEDITOR_DISABLE_ATTRIBUTES_ON_PASTE = ["style","class","id","name","width","height"]

window.QEditor = 
  actions : ['bold','insertunorderedlist','insertorderedlist']
  
  action : (el,a,p) ->
    editor = $(".qeditor_preview",$(el).parent().parent())
    editor.find(".qeditor_placeholder").remove()
    editor.focus()
    p = false if p == null
    
    if a == "createLink"
      p = prompt("Type URL:")
      # return false if p.trim().length == 0
    else if a == "insertimage"
      p = prompt("Image URL:")
      # return false if p.trim().length == 0   
    
    if QEditor.state(a)
      # remove style
      document.execCommand(a,false,null)
    else
      # apply style
      document.execCommand(a, false, p)
    QEditor.checkSectionState(editor)
    editor.change()
    false    
    
  state: (action) ->
    if document.queryCommandEnabled(action)
      document.queryCommandState(action) == true
  
  prompt : (title) ->
    val = prompt(title)
    if val
      return val
    else
      return false
    
  getCurrentContainerNode : () ->
    if window.getSelection
      node = window.getSelection().anchorNode
      containerNode = if node.nodeType == 3 then node.parentNode else node
    return containerNode
    
  checkSectionState : (editor) ->
    for a in QEditor.actions
      link = editor.parent().find(".qeditor_toolbar a[data-action=#{a}]")
      if QEditor.state(a)
        link.addClass("qe-state-on")
      else
        link.removeClass("qe-state-on")
    
  version : ->
    "0.2.0"

do ($=jQuery)->
  $.fn.qeditor = (options) ->
    this.each ->
      obj = $(this)
      obj.addClass("qeditor")
      editor = $('<div class="qeditor_preview clearfix" contentEditable="true"></div>')
      placeholder = $('<div class="qeditor_placeholder"></div>')
    
      
      # use <p> tag on enter by default
      #document.execCommand('defaultParagraphSeparator', false, 'p')
    
      currentVal = obj.val()
      # if currentVal.trim().lenth == 0
        # TODO: default value need in paragraph
        # currentVal = "<p></p>"
    
      editor.html(currentVal)
      editor.addClass(obj.attr("class"))
      obj.after(editor)
    
      # add place holder
      placeholder.text(obj.attr("placeholder"))
      editor.attr("placeholder",obj.attr("placeholder") || "")
      editor.append(placeholder)
      editor.focusin ->
        QEditor.checkSectionState(editor)
        $(this).find(".qeditor_placeholder").remove()
      editor.blur ->
        t = $(this)
        QEditor.checkSectionState(editor)
        if t.html().length == 0 or t.html() == "<br>" or t.html() == "<p></p>" 
          $(this).html('<div class="qeditor_placeholder">' + $(this).attr("placeholder") + '</div>' )
    
      # put value to origin textare when QEditor has changed value
      editor.change ->
        pobj = $(this);
        t = pobj.parent().find('.qeditor')
        t.val(pobj.html())
    
      # watch pasite event, to remove unsafe html tag, attributes
      editor.on "paste", ->
        txt = $(this)
        setTimeout ->
          els = txt.find("*")
          for attrName in QEDITOR_DISABLE_ATTRIBUTES_ON_PASTE
            els.removeAttr(attrName)
          els.find(":not(#{QEDITOR_ALLOW_TAGS_ON_PASTE})").contents().unwrap()
          txt.change()
          true
        ,100
    
      # attach change event on editor keyup
      editor.keyup (e) ->
        QEditor.checkSectionState(editor)
        $(this).change()
      
      editor.on "click", (e) ->
        QEditor.checkSectionState(editor)
        e.stopPropagation()
             
      obj.hide()
      obj.wrap('<div class="qeditor_border"></div>')
      obj.after(editor)
    
      # render toolbar & binding events
      toolbar = $(QEDITOR_TOOLBAR_HTML)

      toolbar.find("a[data-action]").click ->
        QEditor.action(this,$(this).attr("data-action"))
      editor.before(toolbar)