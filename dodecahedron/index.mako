<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
	<link rel="stylesheet" href="../styles/global_layout.css" />
    <link rel="stylesheet" href="./dodecahedron.css" />
    ${u.requirejs('main.coffee')}
</%block>

<%block name="title">Dodecahedron</%block>

<div class="widget_block" id="widget"
    ng-app="dodecahedronApp"
    ng-controller="DodecahedronController as dc">
<button ng-click="dc.toggle_edit_background()">Edit</button>
<script type="text/ng-template" id="dodecahedron_face_renderer.html">
    <div class="inputs" ng-show="dc.edit_backgrounds">
        <input ng-model="face.background" />
        <input ng-model="face.background_pos[0]" type="range" min="-200" max="200" />
        <input ng-model="face.background_pos[1]" type="range" min="-200" max="200" />
        <input ng-model="face.background_size[0]" type="range" min="0" max="500" />
        <input ng-model="face.background_size[1]" type="range" min="0" max="500" />
    </div>
    <svg version="1.1"
        width="200" height="200"
        viewBox="0 0 200 200"
        xmlns="http://www.w3.org/2000/svg"
        xmlns:xlink= "http://www.w3.org/1999/xlink"
    >
        <defs>
            <pattern id="background{{face.id}}" patternUnits="userSpaceOnUse" x="0" y="0" width="200" height="200">
                <image
                    xlink:href="{{face.background}}"
                    x="{{face.background_pos[0]}}"
                    y="{{face.background_pos[1]}}"
                    height="{{face.background_size[0]}}"
                    width="{{face.background_size[1]}}"
                />
            </pattern>
        </defs>
        <polygon
            points="{{face.points}}"
            fill="url(#background{{face.id}})"
            fill-opacity="1"
        />

        <polygon ng-repeat="t in face.glue_triangles"
            points="{{dc.get_glue(t)}}"
            fill-opacity="0"
            stroke="solid black 1px"
        />
    </svg>
    <pre class="content">
        {{face.content}}
    </pre>

    <div class="face"
        ng-include="'dodecahedron_face_renderer.html'"
        ng-repeat="face in face.subfaces"
        id="{{face.id}}"
        style="{{face.style}}"
    ></div>
</script>

    <div class="face"
        ng-include="'dodecahedron_face_renderer.html'"
        ng-repeat="face in dc.faces"
        id="{{face.id}}"
        style="{{face.style}}"
    ></div>
</div>

${u.disqus_thread('dodecahedron')}
