# REQUIRE jquery
# REQUIRE ../utils.coffee

$ = jQuery

WIDTH = 800
HEIGHT = 600

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
    constructor: (@path, @afterLoad) ->
        @load()

    onLoad: () =>
        @width = @img.naturalWidth
        @height = @img.naturalHeight
        @afterLoad()

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

class Tile extends LoadingSprite
    render: (ctx, i, j) ->
        x = i * @width * 0.75
        y = j * @height
        if i % 2
            y += @height / 2.0
        ctx.drawImage(@img, x, y)

class Character extends LoadingSprite
    render: (ctx, x, y, dir, frame) ->
        sW = @width / 4.0
        sH = @height / 4.0
        sX = sW * ((frame % 8) / 2 | 0)
        sY = sH * dir

        ctx.drawImage(@img, sX, sY, sW, sH, x, y, sW, sH)

    setAnimation: (direction) ->
        @frame = 0
        @speed = 1
        @direction = direction

    move: () ->
        switch direction
            when 0 # down
                sH = @height / 4.0
                if @y < HEIGHT - sH
                    @frame = @frame + 1
                    @y += @speed
            when 1 # left
                if @x > 0
                    @frame = @frame + 1
                    @x -= @speed
            when 2 # right
                sW = @width / 4.0
                if @x < WIDTH - sW
                    @frame = @frame + 1
                    @x += @speed
            when 3 # up
                if @y > 0
                    @frame = @frame + 1
                    @y -= @speed

    animate: (ctx) ->
        @move()
        @render(ctx, @x, @y, @direction, @frame)


get_random_sprite = (type) ->
    sprite = new MovingSprite(type)
    sprite.x = _.random(750)
    sprite.y = _.random(550)
    sprite.current_animation = 'idle'
    sprite.frame = 0
    return sprite

load_tiles = (list, done) ->
    allready = new AllReady(done)

    new Tile(
        wesnoth_image('terrain/' + fn),
        allready.wait()
    ) for fn in list

load_characters = (list, done) ->
    allready = new AllReady(done)

    new Character(
        'images/characters/' + fn,
        allready.wait()
    ) for fn in list


$(() ->

    canvas = $('<canvas style="border: solid black 1px;"></canvas>')
        .appendTo('#content')
    canvas = canvas[0]
    canvas.width = WIDTH
    canvas.height = HEIGHT

    ctx = canvas.getContext('2d')

    start = () ->
        console.log('Loaded!')

        mills = (get_random_sprite(windmill) for i in [0 .. 10])
        fires = (get_random_sprite(fire) for i in [0 .. 20])

        character = characters[3]
        character.x = 100
        character.y = 100
        character.setAnimation(0)

        animate = () ->
            requestAnimationFrame(animate)
            for i in [0 .. 13]
                for j in [0 .. 8]
                    terrain[1].render(ctx, i, j)

            character.animate(ctx)

            for mill in mills
                mill.animate(ctx)
            for fire in fires
                fire.animate(ctx)

        animate()

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
    terrain = load_tiles([
        'darken.png',
        'sand/desert.png',
        'grass/green.png',
        'water/coast-tile.png',
    ], allready.wait())

    characters = load_characters([
        'astromechdroid.png',
        'cat.png',
        'chewie.png',
        'hulk.png',
        'indianajones.png',
        'indianajones_whip.png',
        'luggage.png',
        'nazi.png',
        'princessleia.png',
        'rincewind.png',
        'scottish_m1.png',
        'stormtrooper.png',
        'yoda.png',
    ], allready.wait())
)
