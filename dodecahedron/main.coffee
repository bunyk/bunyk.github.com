# REQUIRE jquery
# REQUIRE angular
# REQUIRE ./cal.coffee

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

    summer = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Field_Hamois_Belgium_Luc_Viatour.jpg/389px-Field_Hamois_Belgium_Luc_Viatour.jpg'
    autumn = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Hapgood_Pond_-_Flickr_-_USDAgov.jpg/640px-Hapgood_Pond_-_Flickr_-_USDAgov.jpg'
    winter = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Tallinn_cityview.jpg/640px-Tallinn_cityview.jpg'
    spring = 'https://upload.wikimedia.org/wikipedia/commons/1/12/SpringFlower_2008.jpg'
                                                                                    

    this.get_glue = (i) -> 
        get_glue_triangle_points(100, 100, 100, 5, d2r(-90), i)

    move_to_the_edge_transform = (edge_id) ->
        "transform: rotate(#{36 + 72*edge_id}deg) translate(0, -#{r_small * 2}px)"


    common_points = get_polygon_points(100, 100, 100, 5, d2r(-90))
    this.faces = [{
        id: 'face0',
        style: '',
        background: winter,
        background_pos: [-100, -100],
        background_size: [400, 400],
        points: common_points,
        glue_triangles: [],
        content: months[0],
        subfaces: [{
            id: 'face1',
            style: move_to_the_edge_transform(0),
            background: winter,
            background_pos: [-100, -100],
            background_size: [400, 400],
            points: common_points,
            glue_triangles: [1, 3, 4],
            content: months[1],
            subfaces: [{
                id: 'face2',
                style: move_to_the_edge_transform(0),
                background: spring,
                background_pos: [-100, -100],
                background_size: [400, 400],
                points: common_points,
                glue_triangles: [0, 1, 3, 4],
                content: months[2],
                subfaces: [],
            }],
        }, {
            id: 'face3',
            style: move_to_the_edge_transform(1),
            background: spring,
            background_pos: [-100, -100],
            background_size: [400, 400],
            points: common_points,
            glue_triangles: [1],
            content: 'Тут буде Квітень',
            subfaces: [{
                id: 'face4',
                style: move_to_the_edge_transform(0),
                background: spring,
                background_pos: [-100, -100],
                background_size: [400, 400],
                points: common_points,
                glue_triangles: [0, 1, 4],
                content: 'Тут буде Травень',
                subfaces: [],
                
            }],
        }, {
            id: 'face5',
            style: move_to_the_edge_transform(2),
            background: summer,
            background_pos: [-50, -30],
            background_size: [300, 300],
            points: common_points,
            glue_triangles: [1],
            content: 'Червень',
            subfaces: [{
                id: 'face6',
                style: move_to_the_edge_transform(0),
                background: summer,
                background_pos: [-50, -30],
                background_size: [300, 300],
                points: common_points,
                glue_triangles: [0, 1, 4],
                content: 'Липень',
                subfaces: [],
            }],
        }, {
            id: 'face7',
            style: move_to_the_edge_transform(3),
            background: summer,
            background_pos: [-50, -30],
            background_size: [300, 300],
            points: common_points,
            glue_triangles: [1],
            content: 'Серпень',
            subfaces: [{
                id: 'face8',
                style: move_to_the_edge_transform(0),
                background: autumn,
                background_pos: [-100, -100],
                background_size: [400, 400],
                points: common_points,
                glue_triangles: [0, 1, 4],
                content: 'Вересень',
                subfaces: [],
            }],
        }, {
            id: 'face9',
            style: move_to_the_edge_transform(4),
            background: autumn,
            background_pos: [-100, -100],
            background_size: [400, 400],
            points: common_points,
            glue_triangles: [],
            content: 'Жовтень',
            subfaces: [{
                id: 'face10',
                style: move_to_the_edge_transform(0),
                background: autumn,
                background_pos: [-100, -100],
                background_size: [400, 400],
                points: common_points,
                glue_triangles: [],
                content: 'Листопад',
                subfaces: [{
                    id: 'face11',
                    style: move_to_the_edge_transform(4),
                    background: winter,
                    background_pos: [-100, -100],
                    background_size: [400, 400],
                    points: common_points,
                    glue_triangles: [],
                    content: 'Грудень 2015\n (c) Буник Т. 2014',
                }],
            }],
        }],
    }]
)
