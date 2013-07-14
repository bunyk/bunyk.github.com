# REQUIRE jquery
# REQUIRE svglib.coffee
# REQUIRE hypercube.js

$ = jQuery

window.hypercubeWidget = (selector, width, height, dimensions,
    rotation_speed=5, animation_timeout=30, callback=(() ->),
    line_style = 'stroke:rgb(0,0,0);stroke-width:2'
) ->
    svg = new svglib.SVG(
        selector, width, height,
        Math.sqrt(dimensions) # diagonal of n-hypercube = sqrt(d)
    )
    svg.line_style = line_style
    cube = new hypercube.Hypercube(dimensions)
    cube.reset(svg)
    ad = 0
    bd = 1
    play = true
    animate = () ->
        cube.rotate(ad, bd, 5)
        callback(cube)
        if Math.random() < 0.05
            ad = Math.floor(Math.random() * 2)
            bd = Math.floor(Math.random() * (dimensions - 2)) + 2
        if play
            setTimeout(animate, animation_timeout)
    animate()
    {
        reset: () -> cube.reset(svg)
        play_pause: () ->
            if not play then setTimeout(animate, animation_timeout)
            play = not play
    }

$(() ->
    hw = hypercubeWidget('#surface', 400, 400, 5, 5, 40, (cube) ->
        $('#matrix').html(cube.matrix.html())
    )

    $('#reset').click(hw.reset)

    $play = $('#play_pause .play');
    $pause = $('#play_pause .pause');
    $('#play_pause').click(() ->
        if hw.play_pause()
            $play.hide()
            $pause.show()
        else
            $play.show()
            $pause.hide()
    )

    $('#play_pause .play').hide()
    $('.widget_block').show()
)
