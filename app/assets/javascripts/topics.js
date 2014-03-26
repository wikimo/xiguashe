$(function(){
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
});


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




