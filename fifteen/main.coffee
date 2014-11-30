# REQUIRE jquery
# REQUIRE d3
# REQUIRE underscore

$ = jQuery

FIELD_SIZE = 400
TILE_SIZE = FIELD_SIZE / 4
TILE_MARGIN = 4

$(() ->
    $('.widget_block').show()
    svg = get_svg()
    field = new Field
    draw_field(svg, field)

    d3.select("body").on("keydown", () ->
        onkeydown(d3.event.keyCode, field, svg)
    )
)


onkeydown = (keyCode, field, svg) ->
    if keyCode == 32 # space
        field.shuffle()
        draw_field(svg, field)


draw_field = (svg, field) ->
    tiles = svg.selectAll('.tile')
        .data(field.get_tiles_data())

    # append
    tileenter = tiles.enter().append('g')
    tileenter.attr('class', 'tile')
    tileenter.append('rect')
        .attr('y', TILE_MARGIN)
        .attr('x', TILE_MARGIN)
        .attr('width', TILE_SIZE - TILE_MARGIN*2)
        .attr('height', TILE_SIZE - TILE_MARGIN*2)
        .attr('ry', 10)
        .attr('rx', 10)
        .attr('stroke-width', 5)
        .attr('stroke', '#000')
        .attr('fill', '#ccc')
    tileenter.append('text')
        .attr('x', TILE_SIZE / 2)
        .attr('y', TILE_SIZE / 2)
        .attr('font-size', 47)
        .attr('font-family', "Cursive")
        .attr('text-anchor', "middle")
        .attr('dominant-baseline', "middle")

    # append + update

    tiles.transition().attr('transform', (d) ->
        "translate(#{d.x}, #{d.y})" 
    )
    tiles.select('text').text((d) -> d.id)

    tiles.on('click', (d) ->
        field.move_tiles(d.id)
        draw_field(svg, field)
    )

    # remove
    tiles.exit().remove()

get_svg = () ->
    panel = d3.select('.widget_block')
    svg = panel.append('svg')
        .attr('width', FIELD_SIZE)
        .attr('height', FIELD_SIZE)
        .style('border', 'solid black 5px')


rand03 = () -> # random between 0 and 3 inclusively
    Math.floor(Math.random() * 4)

sign = (x) ->
    if x < 0 then -1 else 1

class Field
    constructor: () ->
        @tiles = [
            [ 1,  2,  3,  4],
            [ 5,  6,  7,  8],
            [ 9, 10, 11, 12],
            [13, 14, 15,  0]
        ]

    shuffle: () ->
        # TODO: rewrite using allowed moves
        for i in [0..100]
            a_x = rand03()
            a_y = rand03()
            b_x = rand03()
            b_y = rand03()
            [@tiles[a_y][a_x], @tiles[b_y][b_x]] = [
             @tiles[b_y][b_x], @tiles[a_y][a_x]]

    get_tile_coords: (id) ->
        for y in [0..3]
            for x in [0..3]
                if @tiles[y][x] == id
                    return {
                        x: x
                        y: y
                    }

    get_tiles_data: () ->
        data = []
        for y in [0..3]
            for x in [0..3]
                if @tiles[y][x]
                    data.push({
                        x: x * TILE_SIZE,
                        y: y * TILE_SIZE,
                        id: @tiles[y][x],
                    })
        _.sortBy(data, (d) -> d.id)

    move_tiles: (id) ->
        empty_cell = @get_tile_coords(0)
        move_cell = @get_tile_coords(id)
        move_x = empty_cell.x - move_cell.x
        move_y = empty_cell.y - move_cell.y

        if move_x == 0
            # move column
            x = empty_cell.x
            for y in [empty_cell.y...move_cell.y]
                @tiles[y][x] = @tiles[y - sign(move_y)][x]
            @tiles[move_cell.y][x] = 0
            return 

        if move_y == 0
            # move row
            y = empty_cell.y
            for x in [empty_cell.x...move_cell.x]
                @tiles[y][x] = @tiles[y][x - sign(move_x)]
            @tiles[y][move_cell.x] = 0
            return
