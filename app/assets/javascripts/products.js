$(function(){

  $(".alert").hide();

  $('a[name="del_img"]').click(function(){

    $(this).parent().remove();

  });

  $("#photo_").change(function(){
    var data = new FormData();

    var arr = [];
    $.each($('#photo_')[0].files, function(i, file) {

      if (file.type.indexOf("image") != 0) {
        $('#error').prepend(file.name + ':不是图片')
        return false;
      }

      if (file.size >= 5120000) {
        $('#error').prepend( file.name + ':大于5M');
        return false;
      }

      data.append('photo', file);
      data.append('auth_token', '#{cookies[:auth_token]}');

      $(".loading").show();

      $.ajax({
        type: 'post',
        url: '/photos',
        data: data,
        cache: false,
        dataType: 'json',
        contentType: false,       
        processData: false,
        success: function(obj) {

          if (obj['msg'] == 'ok') {
            $('.good-img-list').append('<li id="new-photo-' + obj['id'] + '"></li>');
            $('#new-photo-' + obj['id']).prepend('<input type="hidden" name="photo_path_url[]" value="' + obj['photo'] + '"/>')
            $('#new-photo-' + obj['id']).prepend('<input type="hidden" name="photo_id[]" value="' + obj['id'] + '" />')
            $('#new-photo-' + obj['id']).prepend('<a  class ="glyphicon glyphicon-remove-circle" id="del-' + obj['id'] + '" href="javascript:del_photo(' + obj['id'] + ')"></a>');
            $('#new-photo-' + obj['id']).prepend('<input type="radio" name="radio_img" value=' + obj['photo'] +' /> 选择封面')
            $('#new-photo-' + obj['id']).prepend('<img src=' + obj['photo'] + ' alt="" /><br/>');
          }
          
          $(".loading").hide();
        },
        error: function() {
          $('#error').prepend('<li>出错</li>');
          $(".loading").hide();
        }
      });
    });
    $('#photo_').val('');
  }); 

  $('#get-product').click(function(){

     var link = $('input[name="link"]').val();

     var data = new FormData();

     data.append('link', link);

     $('.loading').show();


     $.ajax({
       type: 'post',
       url: '/products/get',
       data: data,
       cache: false,
       contentType: false,
       processData: false,
       dataType: 'json',
       success: function(obj) {
         if ( obj['text'] == 0 ) {
           $('.alert').show();
           $('.alert > strong').html(obj['msg']);
         }
         else if ( obj['text'] == 1 ) {
           $('.alert').show();
           $('.alert > strong').html(obj['msg']);
         }
         else if ( obj['text'] == 2 ) {
           $('.alert').show();
           $('.alert > strong').html(obj['msg']);

           $.ajax({
             type: 'get',
             url: '/products/exist',
             data: 'really_id=' + obj['really_id'],
             cache: false,
             dataType: 'json',
             success: function(obj) {

               $('#exist-product').prepend('点击查看：<a href="/products/' + obj['product']['id'] + '">[' + obj['product']['title'] + ']</a>');

             }
           });
         }
         else if ( obj['text'] == 3 ) {
           $("#item-form").prepend("<input type='hidden' name='title' value='"   + obj['item']['title']  + "'/>");
           $("#item-form").prepend("<input type='hidden' name='price' value='"   + obj['item']['price']  + "'/>");
           $("#item-form").prepend("<input type='hidden' name='url' value='"     + obj['item']['url']    + "'/>");
           $("#item-form").prepend("<input type='hidden' name='source' value='"  + obj['item']['source'] + "'/>");
           $("#item-form").prepend("<input type='hidden' name='really_id' value='"  + obj['item']['really_id'] +"'/>");

           for (var i = 0; i < obj['item']['images'].length; i ++) {
             $("#item-form").prepend("<input type='hidden' name='images[]' value='" + obj['item']['images'][i] + "'/>");
           }
           $("#item-form").submit();

         }
         else {
           console.log('error');
         } 

         $('.loading').hide();
         setTime();
       }
        
     }); 

   });

  

  $("#submit_btn").click(function(){

    if ($("input[name='radio_img']").length == 0) {

      alert_msg("没有上传图片");

      return false;

    }
    else if ($("input[name='radio_img']").length > 5) {
      alert_msg("最多能上传5张图片")
      return false;
    }
    else {
      var checked = $("input[name='radio_img']:checked");

      if(checked.length == 0) {

        $("input[name='radio_img']:first").attr("checked", 'true');

      }
      return true;
    }
  });

  
  $("#batch_del_products_btn").click(function(){

    var str = "";

    $('input[name="checkbox_name"]:checked').each(function(){
      str += $(this).val() + ",";
    });


    window.location.href = '/cpanel/products/batch_destroy?ids='+ str;

  });

  $(window).scroll(function(){
    if($(window).scrollTop() == $(document).height() - $(window).height()) {
      if ($("#offset").val() != null) {
        load_products();
      }
    }
  });

});

function load_products(){

  $(".loading").show();

  console.log($("#offset").val());

  $.ajax({
    type: "get",
    url : "/products/scroll",
    data : "offset=" + $("#offset").val(),
    success : function(msg) {
      if(msg["text"] == 0) {
        $(".loading").css('display','none');
      }
      else if (msg["text"] == 1) {
        generate_html(msg);
        $(".message").show();
        $(".message").html("貌似木有其它东西了……");
        $(".loading").css('display','none');
      }
      else if (msg["text"] == 2) {
        generate_html(msg);
      }
    }
  });
}

function generate_html(msg) {

   $("#offset").val(msg["offset"]);
   $(".loading").hide();

   var html = "";

   for (var i = 0; i < msg["products"].length; i ++) {

      html += '<li>' + 
              '<div class="good-img"><a href="/products/' + msg["products"][i].id + '"><img src="' + msg["products"][i].img + '"/></a>' +
              '<span></span>' + 
              '<em>' + msg["products"][i].money_logo + ' ' + msg["products"][i].price + '</em>' + 
              '</div>'  +
              '<div class="good">' + 
              '<h3><a href="/products/' + msg["products"][i].id + '">' + msg["products"][i].title + '</a></h3>' +
              '<blockquote>' +
              '<a href="/users/' + msg["products"][i].user_id + '"><img src="' + msg["products"][i].img + '"/></a>' + msg["products"][i].appraisal.substr(0, 30) + 
              '</blockquote>';

      var footer = '<footer class="cc">';

      if (msg["products"][i].reply_num > 0) {

        footer += "<cite>评论" + msg["products"][i].reply_num + "</cite>";

      }
      footer+= "</footer></div></li>";
      
      html += footer;
   }

   $("#products").append(html);
}

function del_photo(id) {
  $.ajax({
    type: 'DELETE',
    url: '/photos/' + id,
    success: function(obj) {
      if (obj['msg'] == 'ok') {
        $('#del-'+id).parent().remove();
      }
    }
  });
}


function alert_msg(content) {
   $("#message").append('<div class="alert alert-warning show">' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                        '<strong>' + content + '</strong>' +
                        '</div>')

  setTimeout(function(){
    $('.alert').alert('close');
  }, 3000);
}

        
function setTime() {
    setTimeout(function(){
      $('.alert').alert('close');
    }, 3000);
}



        
