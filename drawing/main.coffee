# REQUIRE jquery

$ = jQuery


$(() ->
    $('.widget_block').show()
    $('svg line').attr('stroke-dasharray', 30)
    
    i = 0
    animate = () ->
        i -= 2
        $('svg line').attr('stroke-dashoffset', i)
    setInterval(animate, 40)
)
