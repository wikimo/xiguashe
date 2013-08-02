$(document).ready (e) ->
  t = $(".fixed").offset().top
  mh = $("#main").height()
  fh = $(".fixed").height()
  $(window).scroll (e) ->
    s = $(document).scrollTop()
    if s > t - 10
      $(".fixed").css "position", "fixed"
      $(".fixed").css "top", mh - s - fh - 40 + "px"  if s + fh > mh
    else
      $(".fixed").css "position", ""
