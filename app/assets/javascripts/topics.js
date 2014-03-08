$(function(){
  $("#photo_").change(function(){
    var data = new FormData();

    $.each($('#photo_')[0].files, function(i, file) {

      data.append('photo', file);


      $.ajax({
        type: 'post',
        url: '/photos',
        data: data,
        cache: false,
        contentType: false,       
        processData: false,
        success: function(obj) {
          if (obj['msg'] == 'ok') {
            $('#photo-list').append('<div class="new-photo"></div>');
            $('.new-photo').prepend('<a id="del-' + obj['id'] + '" href="javascript:del_photo(' + obj['id'] + ')">删除</a></div>');
            $('.new-photo').prepend('<input type="hidden" name="photo_id[]" value="' + obj['id'] + '" />')
            $('.new-photo').prepend('<img src=' + obj['photo'] + ' alt="" />');
          }
          else {
          }
        }
      });

    });
  });

});

function del_photo(id) {

  $.ajax({
    type: 'DELETE',
    url: '/photos/' + id,
    success: function(obj) {
      if (obj['msg'] == 'ok') {
        $('#del-' + id).parent().remove();
      }
    }
  });

}




