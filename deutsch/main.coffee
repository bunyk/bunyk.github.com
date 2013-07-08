# REQUIRE /jslibs/jquery-2.0.2.min.js
# REQUIRE exercises.coffee

$ = jQuery

$('.drag_exercise').each(()->
   $(this).dragExcercise()
)
