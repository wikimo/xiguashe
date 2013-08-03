$(document).ready (e) ->
  if $(".fixed").length > 0
    t = $(".fixed").offset().top
    mh = $("#main").height()
    fh = $(".fixed").height()

    $(window).scroll (e) ->
      s = $(document).scrollTop()
      if s > t - 59
        $(".fixed").css "position", "fixed"
        #$(".fixed").css "top", mh - s - fh - 49 + "px"  if s + fh > mh
      else
        $(".fixed").css "position", ""