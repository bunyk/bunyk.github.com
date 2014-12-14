# REQUIRE jquery
# REQUIRE angular

$ = jQuery

$(() ->
    $('.widget_block').show()
)


d2r = (d) ->
    d / 180.0 * Math.PI

get_polygon_point = (cx, cy, r, n, startangle, i) ->
    a = startangle + (2 * Math.PI / n) * i
    x = cx + Math.cos(a) * r
    y = cy + Math.sin(a) * r
    [x, y]

get_polygon_points = (cx, cy, r, n, startangle) ->
    coords = (get_polygon_point(cx, cy, r, n, startangle, i).join(', ') for i in [0...n])
    coords.join(' ')

get_glue_triangle_points = (cx, cy, r, n, startangle, i) ->
    coords = [
        get_polygon_point(cx, cy, r, n, startangle, i).join(', '),
        get_polygon_point(cx, cy, r, n, startangle, i + 1).join(', '),
        get_polygon_point(cx, cy, r, n * 2, startangle, i * 2 + 1).join(', '),
    ]
    coords.join(' ')

app = angular.module('dodecahedronApp', [])
    .config(($sceProvider) ->
      $sceProvider.enabled(false)
    )

app.controller('DodecahedronController', () ->
    r_small = 100 * Math.cos(Math.PI / 5.0)

    months = [''' Січень          
нд пн вт ср чт пт сб   
             1  2  3   
 4  5  6  7  8  9 10   
11 12 13 14 15 16 17   
18 19 20 21 22 23 24   
25 26 27 28 29 30 31   
''',
    '''
       Лютий         
нд пн вт ср чт пт сб 
 1  2  3  4  5  6  7 
 8  9 10 11 12 13 14 
15 16 17 18 19 20 21 
22 23 24 25 26 27 28 
''',
    '''
      Березень      
нд пн вт ср чт пт сб
 1  2  3  4  5  6  7
 8  9 10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
29 30 31            
''']

                                                                                    

    this.get_glue = (i) -> 
        get_glue_triangle_points(100, 100, 100, 5, d2r(-90), i)

    move_to_the_edge_transform = (edge_id) ->
        "transform: rotate(#{36 + 72*edge_id}deg) translate(0, -#{r_small * 2}px)"


    common_points = get_polygon_points(100, 100, 100, 5, d2r(-90))
    this.faces = [{
        id: 'face0',
        style: '',
        background: 'https://upload.wikimedia.org/wikipedia/uk/b/b7/Frankivsk455.jpg',
        background_pos: [-100, -100],
        background_size: [400, 400],
        points: common_points,
        glue_triangles: [],
        content: months[0],
        subfaces: [{
            id: 'face1',
            style: move_to_the_edge_transform(0),
            background: 'http://vrubli.files.wordpress.com/2014/08/img_4071.jpg',
            background_pos: [0, 0],
            background_size: [200, 200],
            points: common_points,
            glue_triangles: [1, 3, 4],
            content: months[1],
            subfaces: [{
                id: 'face2',
                style: move_to_the_edge_transform(0),
                background: 'http://vrubli.files.wordpress.com/2013/09/img_1673.jpg',
                background_pos: [0, 0],
                background_size: [200, 200],
                points: common_points,
                glue_triangles: [0, 1, 3, 4],
                content: months[2],
                subfaces: [],
            }],
        }, {
            id: 'face3',
            style: move_to_the_edge_transform(1),
            background: 'http://vrubli.files.wordpress.com/2014/08/img_4014.jpg',
            background_pos: [0, 0],
            background_size: [200, 200],
            points: common_points,
            glue_triangles: [1],
            content: months[0],
            subfaces: [{
                id: 'face4',
                style: move_to_the_edge_transform(0),
                background: 'http://vrubli.files.wordpress.com/2014/09/img_4542.jpg',
                background_pos: [0, 0],
                background_size: [200, 200],
                points: common_points,
                glue_triangles: [0, 1, 4],
                content: months[2],
                subfaces: [],
                
            }],
        }, {
            id: 'face5',
            style: move_to_the_edge_transform(2),
            background: 'http://vrubli.files.wordpress.com/2014/08/img_4014.jpg',
            background_pos: [0, 0],
            background_size: [200, 200],
            points: common_points,
            glue_triangles: [1],
            content: months[0],
            subfaces: [{
                id: 'face6',
                style: move_to_the_edge_transform(0),
                background: 'http://vrubli.files.wordpress.com/2014/09/img_4542.jpg',
                background_pos: [0, 0],
                background_size: [200, 200],
                points: common_points,
                glue_triangles: [0, 1, 4],
                content: months[2],
                subfaces: [],
            }],
        }, {
            id: 'face7',
            style: move_to_the_edge_transform(3),
            background: 'http://vrubli.files.wordpress.com/2014/08/img_4014.jpg',
            background_pos: [0, 0],
            background_size: [200, 200],
            points: common_points,
            glue_triangles: [1],
            content: months[0],
            subfaces: [{
                id: 'face8',
                style: move_to_the_edge_transform(0),
                background: 'http://vrubli.files.wordpress.com/2014/09/img_4542.jpg',
                background_pos: [0, 0],
                background_size: [200, 200],
                points: common_points,
                glue_triangles: [0, 1, 4],
                content: months[2],
                subfaces: [],
            }],
        }, {
            id: 'face9',
            style: move_to_the_edge_transform(4),
            background: 'http://cs618126.vk.me/v618126487/b7eb/phtmGhecxc0.jpg',
            background_pos: [0, 0],
            background_size: [200, 200],
            points: common_points,
            glue_triangles: [],
            content: months[0],
            subfaces: [{
                id: 'face10',
                style: move_to_the_edge_transform(0),
                background: 'http://vrubli.files.wordpress.com/2012/12/dsc09898.jpg',
                background_pos: [0, 0],
                background_size: [200, 200],
                points: common_points,
                glue_triangles: [],
                content: months[2],
                subfaces: [{
                    id: 'face11',
                    style: move_to_the_edge_transform(4),
                    background: 'http://vrubli.files.wordpress.com/2014/03/193.jpg',
                    background_pos: [0, 0],
                    background_size: [200, 200],
                    points: common_points,
                    glue_triangles: [],
                    content: months[2],
                }],
            }],
        }],
    }]
)
