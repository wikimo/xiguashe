/*textarea 在光标点插入相应内容*/
(function($){
	$.fn.extend({
	  insertAtCursor : function(myValue) {
	      var $t = $(this)[0];
	      var ele =  $($t)
	      if (document.selection) {
	          this.focus();
	          sel = document.selection.createRange();
	          sel.innerHTML = myValue;
	          this.focus();
	      } else if ($t.selectionStart || $t.selectionStart == '0') {

	         var startPos = $t.selectionStart;
	         var endPos = $t.selectionEnd;
	         var scrollTop = $t.scrollTop;
	         $t.value = $t.value.substring(0, startPos) + myValue + $t.value.substring(endPos, $t.value.length);
	         this.focus();
	         $t.selectionStart = startPos + myValue.length;
	       $t.selectionEnd = startPos + myValue.length;
	         $t.scrollTop = scrollTop;
	     } else {
	        ele.html(ele.html() + myValue)
	        ele.focus();
	     }
	 }
	});
})(jQuery);