# REQUIRE jquery
# REQUIRE radio

class Point
    constructor: (x, y) ->
        @_x = x
        @_y = y
        Object.defineProperty(@, 'x',
            configurable: true,
            get: () -> @_x
            set: (value) ->
                @_x = value
                radio('move_x').broadcast(@)
        )
        Object.defineProperty(@, 'y',
            configurable: true,
            get: () -> @_y
            set: (value) ->
                @_y = value
                radio('move_y').broadcast(@)
        )
    onMoveX: (cb) ->
        that = @
        radio('move_x').subscribe (point) ->
            if point is that then cb()
    onMoveY: (cb) ->
        that = @
        radio('move_y').subscribe (point) ->
            if point is that then cb()

class Line
    constructor: (svg, @a, @b) ->
        @element = document.createElementNS('http://www.w3.org/2000/svg','line')
        @element.setAttribute('style', 'stroke:rgb(0,0,0);stroke-width:2')
        @element.setAttribute('x1', svg.x(@a.x))
        @element.setAttribute('y1', svg.y(@a.y))
        @element.setAttribute('x2', svg.x(@b.x))
        @element.setAttribute('y2', svg.y(@b.y))

        that = @

        @a.onMoveX () -> 
            that.element.setAttribute('x1', svg.x(that.a.x))
        @a.onMoveY () ->
            that.element.setAttribute('y1', svg.y(that.a.y))
        @b.onMoveX () ->
            that.element.setAttribute('x2', svg.x(that.b.x))
        @b.onMoveY () ->
            that.element.setAttribute('y2', svg.y(that.b.y))

        svg.$element.append(@element)

class SVG
    constructor: (selector, @width, @height, @a=2.0) ->
        @$element = $("<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" height=\"#{height}\" width=\"#{width}\"></svg>")
        $(selector).append(@$element)

    clear: () -> @$element.html('')
    line4: (ax, ay, bx, _by) -> @line2(
        new Point(ax, ay), new Point(bx, _by)
    )
    line2: (a, b) -> new Line(@, a, b)
    line: () ->
        if arguments.length == 2
            @line2.apply(@, arguments)
        if arguments.length == 4
            @line4.apply(@, arguments)

    x: (val) -> (val / @a + 0.5) * @width
    y: (val) -> (val / @a + 0.5) * @height


window.svglib = 
    'SVG': SVG,
    'Point': Point
