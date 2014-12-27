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

<script type="text/ng-template" id="dodecahedron_face_renderer.html">
    <label class="inputs" style="top: 150px; left: 20px; z-index: 99;" ng-show="dc.edit||face.edit"><input ng-model="face.edit" ng-click="dc.toggle_edit()" type="checkbox"/>Edit</label>
    <div class="inputs" ng-show="face.edit">
        <input ng-model="face.background"/>
        <input ng-model="face.background_pos[0]" title="x" type="range" min="-200" max="200" />
        <input ng-model="face.background_pos[1]" title="y" type="range" min="-200" max="200" />
        <input ng-model="face.background_size" title="size" type="range" min="0" max="500" />
        <textarea ng-model="face.content"></textarea>
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
                    height="{{face.background_size}}"
                    width="{{face.background_size}}"
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

<div class="noprint inputs" style="top: 0px;">
    <input type="number" ng-model="dc.year" ng-change="dc.set_year(dc.year)"/>
    <label style="position: static">
        <input type="checkbox" ng-model="dc.edit">
        Edit
    </label>
</div>

</div>

${u.disqus_thread('dodecahedron')}
