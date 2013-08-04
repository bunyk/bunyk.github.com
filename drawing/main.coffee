# REQUIRE jquery
# REQUIRE raphael_src

$ = jQuery


$(() ->
    $('.widget_block').show()
    $('svg line').attr('stroke-dasharray', 30)
    
    i = 0
    animate = () ->
        i -= 2
        if i > 30
            i = 0
        $('svg line').attr('stroke-dashoffset', i)
    setInterval(animate, 100)
)
