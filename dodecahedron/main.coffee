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

    @year = 2015 

    face_text = []
    @set_year = (year) -> 
        face_text.length = 0 # clear calendar
        for i in [0 ... 12]
            face_text.push(cal.text(year, i))
    @set_year(@year)

    summer = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Field_Hamois_Belgium_Luc_Viatour.jpg/389px-Field_Hamois_Belgium_Luc_Viatour.jpg'
    autumn = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Hapgood_Pond_-_Flickr_-_USDAgov.jpg/640px-Hapgood_Pond_-_Flickr_-_USDAgov.jpg'
    winter = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Tallinn_cityview.jpg/640px-Tallinn_cityview.jpg'
    spring = 'https://upload.wikimedia.org/wikipedia/commons/1/12/SpringFlower_2008.jpg'
    lions = '/dodecahedron/leopolis_lions.jpg'
                                                                                    

    @get_glue = (i) -> 
        get_glue_triangle_points(100, 100, 100, 5, d2r(-90), i)

    move_to_the_edge_transform = (edge_id) ->
        "transform: rotate(#{36 + 72*edge_id}deg) translate(0, -#{r_small * 2}px)"

    common_points = get_polygon_points(100, 100, 100, 5, d2r(-90))

    @edit = false
    @toggle_edit = () ->
        @edit = !@edit


    @faces = [{
        id: 'face0',
        style: '',
        background: lions,
        background_pos: [-100, -100],
        background_size: 400,
        points: common_points,
        glue_triangles: [],
        content: face_text[0],
        subfaces: [{
            id: 'face1',
            style: move_to_the_edge_transform(0),
            background: winter,
            background_pos: [-100, -100],
            background_size: 400,
            points: common_points,
            glue_triangles: [1, 3, 4],
            content: face_text[1],
            subfaces: [{
                id: 'face2',
                style: move_to_the_edge_transform(0),
                background: spring,
                background_pos: [-100, -100],
                background_size: 400,
                points: common_points,
                glue_triangles: [0, 1, 3, 4],
                content: face_text[2],
                subfaces: [],
            }],
        }, {
            id: 'face3',
            style: move_to_the_edge_transform(1),
            background: spring,
            background_pos: [-100, -100],
            background_size: 400,
            points: common_points,
            glue_triangles: [1],
            content: face_text[3],
            subfaces: [{
                id: 'face4',
                style: move_to_the_edge_transform(0),
                background: spring,
                background_pos: [-100, -100],
                background_size: 400,
                points: common_points,
                glue_triangles: [0, 1, 4],
                content: face_text[4],
                subfaces: [],
                
            }],
        }, {
            id: 'face5',
            style: move_to_the_edge_transform(2),
            background: summer,
            background_pos: [-50, -30],
            background_size: 300,
            points: common_points,
            glue_triangles: [1],
            content: face_text[5],
            subfaces: [{
                id: 'face6',
                style: move_to_the_edge_transform(0),
                background: summer,
                background_pos: [-50, -30],
                background_size: 300,
                points: common_points,
                glue_triangles: [0, 1, 4],
                content: face_text[6],
                subfaces: [],
            }],
        }, {
            id: 'face7',
            style: move_to_the_edge_transform(3),
            background: summer,
            background_pos: [-50, -30],
            background_size: 300,
            points: common_points,
            glue_triangles: [1],
            content: face_text[7],
            subfaces: [{
                id: 'face8',
                style: move_to_the_edge_transform(0),
                background: autumn,
                background_pos: [-100, -100],
                background_size: 400,
                points: common_points,
                glue_triangles: [0, 1, 4],
                content: face_text[8],
                subfaces: [],
            }],
        }, {
            id: 'face9',
            style: move_to_the_edge_transform(4),
            background: autumn,
            background_pos: [-100, -100],
            background_size: 400,
            points: common_points,
            glue_triangles: [],
            content: face_text[9],
            subfaces: [{
                id: 'face10',
                style: move_to_the_edge_transform(0),
                background: autumn,
                background_pos: [-100, -100],
                background_size: 400,
                points: common_points,
                glue_triangles: [],
                content: face_text[10],
                subfaces: [{
                    id: 'face11',
                    style: move_to_the_edge_transform(4),
                    background: winter,
                    background_pos: [-100, -100],
                    background_size: 400,
                    points: common_points,
                    glue_triangles: [],
                    content: face_text[11],
                }],
            }],
        }],
    }]
)
