<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<link rel="stylesheet" href="../styles/global_layout.css" />
    <style type="text/css">
      #map-canvas {
          width: 800px;
          height: 600px;
      }
    </style>
    ${u.requirejs('main.coffee')}
</%block>

<%block name="title">Game using google maps as map</%block>

<div id="map-canvas" />
