// Generated by CoffeeScript 1.6.1
(function() {
  var $, app, d2r, get_glue_triangle_points, get_polygon_point, get_polygon_points;

  $ = jQuery;

  $(function() {
    return $('.widget_block').show();
  });

  d2r = function(d) {
    return d / 180.0 * Math.PI;
  };

  get_polygon_point = function(cx, cy, r, n, startangle, i) {
    var a, x, y;
    a = startangle + (2 * Math.PI / n) * i;
    x = cx + Math.cos(a) * r;
    y = cy + Math.sin(a) * r;
    return [x, y];
  };

  get_polygon_points = function(cx, cy, r, n, startangle) {
    var coords, i;
    coords = (function() {
      var _i, _results;
      _results = [];
      for (i = _i = 0; 0 <= n ? _i < n : _i > n; i = 0 <= n ? ++_i : --_i) {
        _results.push(get_polygon_point(cx, cy, r, n, startangle, i).join(', '));
      }
      return _results;
    })();
    return coords.join(' ');
  };

  get_glue_triangle_points = function(cx, cy, r, n, startangle, i) {
    var coords;
    coords = [get_polygon_point(cx, cy, r, n, startangle, i).join(', '), get_polygon_point(cx, cy, r, n, startangle, i + 1).join(', '), get_polygon_point(cx, cy, r, n * 2, startangle, i * 2 + 1).join(', ')];
    return coords.join(' ');
  };

  app = angular.module('dodecahedronApp', []).config(function($sceProvider) {
    return $sceProvider.enabled(false);
  });

  app.controller('DodecahedronController', function() {
    var autumn, common_points, face_text, lions, move_to_the_edge_transform, r_small, spring, summer, winter;
    r_small = 100 * Math.cos(Math.PI / 5.0);
    this.year = 2015;
    face_text = [];
    this.set_year = function(year) {
      var i, _i, _results;
      face_text.length = 0;
      _results = [];
      for (i = _i = 0; _i < 12; i = ++_i) {
        _results.push(face_text.push(cal.text(year, i)));
      }
      return _results;
    };
    this.set_year(this.year);
    summer = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Field_Hamois_Belgium_Luc_Viatour.jpg/389px-Field_Hamois_Belgium_Luc_Viatour.jpg';
    autumn = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Hapgood_Pond_-_Flickr_-_USDAgov.jpg/640px-Hapgood_Pond_-_Flickr_-_USDAgov.jpg';
    winter = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Tallinn_cityview.jpg/640px-Tallinn_cityview.jpg';
    spring = 'https://upload.wikimedia.org/wikipedia/commons/1/12/SpringFlower_2008.jpg';
    lions = '/dodecahedron/leopolis_lions.jpg';
    this.get_glue = function(i) {
      return get_glue_triangle_points(100, 100, 100, 5, d2r(-90), i);
    };
    move_to_the_edge_transform = function(edge_id) {
      return "transform: rotate(" + (36 + 72 * edge_id) + "deg) translate(0, -" + (r_small * 2) + "px)";
    };
    common_points = get_polygon_points(100, 100, 100, 5, d2r(-90));
    this.edit = false;
    this.toggle_edit = function() {
      return this.edit = !this.edit;
    };
    return this.faces = [
      {
        id: 'face0',
        style: '',
        background: lions,
        background_pos: [-100, -100],
        background_size: 400,
        points: common_points,
        glue_triangles: [],
        content: face_text[0],
        subfaces: [
          {
            id: 'face1',
            style: move_to_the_edge_transform(0),
            background: winter,
            background_pos: [-100, -100],
            background_size: 400,
            points: common_points,
            glue_triangles: [1, 3, 4],
            content: face_text[1],
            subfaces: [
              {
                id: 'face2',
                style: move_to_the_edge_transform(0),
                background: spring,
                background_pos: [-100, -100],
                background_size: 400,
                points: common_points,
                glue_triangles: [0, 1, 3, 4],
                content: face_text[2],
                subfaces: []
              }
            ]
          }, {
            id: 'face3',
            style: move_to_the_edge_transform(1),
            background: spring,
            background_pos: [-100, -100],
            background_size: 400,
            points: common_points,
            glue_triangles: [1],
            content: face_text[3],
            subfaces: [
              {
                id: 'face4',
                style: move_to_the_edge_transform(0),
                background: spring,
                background_pos: [-100, -100],
                background_size: 400,
                points: common_points,
                glue_triangles: [0, 1, 4],
                content: face_text[4],
                subfaces: []
              }
            ]
          }, {
            id: 'face5',
            style: move_to_the_edge_transform(2),
            background: summer,
            background_pos: [-50, -30],
            background_size: 300,
            points: common_points,
            glue_triangles: [1],
            content: face_text[5],
            subfaces: [
              {
                id: 'face6',
                style: move_to_the_edge_transform(0),
                background: summer,
                background_pos: [-50, -30],
                background_size: 300,
                points: common_points,
                glue_triangles: [0, 1, 4],
                content: face_text[6],
                subfaces: []
              }
            ]
          }, {
            id: 'face7',
            style: move_to_the_edge_transform(3),
            background: summer,
            background_pos: [-50, -30],
            background_size: 300,
            points: common_points,
            glue_triangles: [1],
            content: face_text[7],
            subfaces: [
              {
                id: 'face8',
                style: move_to_the_edge_transform(0),
                background: autumn,
                background_pos: [-100, -100],
                background_size: 400,
                points: common_points,
                glue_triangles: [0, 1, 4],
                content: face_text[8],
                subfaces: []
              }
            ]
          }, {
            id: 'face9',
            style: move_to_the_edge_transform(4),
            background: autumn,
            background_pos: [-100, -100],
            background_size: 400,
            points: common_points,
            glue_triangles: [],
            content: face_text[9],
            subfaces: [
              {
                id: 'face10',
                style: move_to_the_edge_transform(0),
                background: autumn,
                background_pos: [-100, -100],
                background_size: 400,
                points: common_points,
                glue_triangles: [],
                content: face_text[10],
                subfaces: [
                  {
                    id: 'face11',
                    style: move_to_the_edge_transform(4),
                    background: winter,
                    background_pos: [-100, -100],
                    background_size: 400,
                    points: common_points,
                    glue_triangles: [],
                    content: face_text[11]
                  }
                ]
              }
            ]
          }
        ]
      }
    ];
  });

}).call(this);
