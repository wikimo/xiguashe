$(function(){

  $(".alert").hide();

  $('a[name="del_img"]').click(function(){

    $(this).parent().remove();

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
         $('.alert').show();
         if ( obj['text'] == 0 ) {
           $('.alert > strong').html(obj['msg']);
         }
         else if ( obj['text'] == 1 ) {
           $('.alert > strong').html(obj['msg']);
         }
         else if ( obj['text'] == 2 ) {
           $('.alert > strong').html(obj['msg']);

           $.ajax({
             type: 'get',
             url: '/products/exist',
             data: 'really_id=' + obj['really_id'],
             cache: false,
             dataType: 'json',
             success: function(obj) {

               $('#exist-product').prepend('点击查看：<a href="/products/' + obj['product']['id'] + '">[' + obj['product']['title'] + ']</a>');
               //$('#exist-product').prepend('<a href="/products/' + obj['product']['id'] + '"><img src="' + obj['product']['img'] + '"/></a>');

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

  function setTime() {
    setTimeout(function(){
      $(".alert").hide();
    }, 3000);
  }


});
        
        
