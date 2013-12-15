# REQUIRE jquery
# REQUIRE ../utils.coffee

$ = jQuery

wesnoth_image = (path) ->
    'https://raw.github.com/wesnoth/wesnoth-old/master/data/core/images/' + path


class LoadingSpriteSet
    constructor: (@path, @animations, @onLoad) ->
        @load()

    load: () ->
        allready = new AllReady(_.bind(@onLoad, @))

        for name, data of @animations
            console.log "loading #{name}"
            data.frames = []
            for x in [0 .. data.count - 1]
                img = new Image()

                img.onload = allready.wait()

                path = "#{@path}#{data.pattern(x + data.first_index)}"
                img.src = path
                data.frames[x] = img


class LoadingSprite
    constructor: (@path, @onLoad) ->
        @load()

    load: () ->
        @img = new Image()
        @img.onload = @onLoad
        @img.src = @path

class MovingSprite
    constructor: (@spriteSet) ->
        @setAnimation(
            _.keys(@spriteSet.animations)[0]
        )

    setAnimation: (name) ->
        @frame = 0
        @animation_name = name
        @animation = @spriteSet.animations[name]

    animate: (ctx) ->
        @frame = (@frame + 1) % @animation.count
        img = @animation.frames[@frame]
        if img
            ctx.drawImage(img, @x, @y)

class Tile
    constructor: (@sprite) ->
        @width = @sprite.img.naturalWidth
        @height = @sprite.img.naturalHeight
        console.log(@width, @height)

    render: (ctx, i, j) ->
        x = i * @width * 0.75
        y = j * @height
        if i % 2
            y += @height / 2.0
        console.log(x, y)
        ctx.drawImage(@sprite.img, x, y)

get_random_sprite = (type) ->
    sprite = new MovingSprite(type)
    sprite.x = _.random(750)
    sprite.y = _.random(550)
    sprite.current_animation = 'idle'
    sprite.frame = 0
    return sprite

$(() ->
    canvas = $('#canvas')[0]
    ctx = canvas.getContext('2d')

    start = () ->
        console.log('Loaded!')
        desert = new Tile(desert_sprite)
        coast = new Tile(coast_sprite)
        flowers = new Tile(flowers_sprite)

        mills = (get_random_sprite(windmill) for i in [0 .. 20])
        fires = (get_random_sprite(fire) for i in [0 .. 80])

        animate = () ->
            requestAnimationFrame(animate)
            for i in [0 .. 13]
                for j in [0 .. 8]
                    (switch (i + j) % 3
                        when 0 then desert
                        when 1 then coast
                        when 2 then flowers
                    ).render(ctx, i, j)

            for mill in mills
                mill.animate(ctx)
            for fire in fires
                fire.animate(ctx)

        animate()

        # setInterval(animate, 50)

    allready = new AllReady(start);
    windmill = new LoadingSpriteSet(
        wesnoth_image('scenery/'),
        { 
            'idle':
                pattern: (n) -> "windmill-#{_.zfill(n, 2)}.png"
                first_index: 1
                count: 18
        },
        allready.wait()
    )
    fire = new LoadingSpriteSet(
        wesnoth_image('scenery/'),
        { 
            'idle':
                pattern: (n) -> "fire#{n}.png"
                first_index: 1
                count: 8
        },
        allready.wait()
    )

    desert_sprite = new LoadingSprite(
        wesnoth_image('terrain/sand/desert.png'),
        allready.wait()
    )
    flowers_sprite = new LoadingSprite(
        wesnoth_image('terrain/grass/green.png'),
        allready.wait()
    )
    coast_sprite = new LoadingSprite(
        wesnoth_image('terrain/water/coast-tile.png'),
        allready.wait()
    )
)
