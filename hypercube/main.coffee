# REQUIRE jquery
# REQUIRE svglib.js
# REQUIRE hypercube.js

$ = jQuery

$(() ->
    dimensions = 5
    svg = new svglib.SVG(
        '#surface', 300, 300,
        Math.sqrt(dimensions) # diagonal of n-hypercube = sqrt(d)
    )
    cube = new hypercube.Hypercube(dimensions)
    cube.reset(svg)

    $('#matrix').html(cube.matrix.html())

    ad = 0
    bd = 1
    play = true
    animate = () ->
        cube.rotate(ad, bd, 5)
        $('#matrix').html(cube.matrix.html())
        if Math.random() < 0.05
            ad = Math.floor(Math.random() * 2)
            bd = Math.floor(Math.random() * (dimensions - 2)) + 2
        if play
            setTimeout(animate, 40)
    animate()

    $('#reset').click(() ->
        cube.reset(svg)
    )

    $play = $('#play_pause .play');
    $pause = $('#play_pause .pause');
    $('#play_pause').click(() ->
        play = not play
        if play
            setTimeout(animate, 40)
            $play.hide()
            $pause.show()
        else
            $play.show()
            $pause.hide()
    )

    $('#play_pause .play').hide()
    $('.widget_block').show()
)
