# REQUIRE jquery
# REQUIRE exercises.coffee

$ = jQuery

$(()->
    $('.drag_exercise').each(()->
       $(this).dragExcercise()
    )
)
