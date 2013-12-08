<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
	<link rel="stylesheet" href="../styles/global_layout.css" />
    ${u.requirejs('main.coffee')}
</%block>

<%block name="title">HTML5 canvas graphics test</%block>

<div id="content">
<canvas id="canvas" width="800" height="600" style="border: solid black 1px;"></canvas>
</div>
