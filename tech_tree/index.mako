<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
	<link rel="stylesheet" href="../styles/global_layout.css" />

    <style>

    .node circle {
      fill: #steelblue;
      stroke: steelblue;
      stroke-width: 1.5px;
    }

    .node {
      font: 12px sans-serif;
    }

    .link {
      fill: none;
      stroke: #333;
      stroke-width: 1.5px;
    }

    </style>
</%block>

<%block name="title">D3 Tree test</%block>

<div class="widget_block">
</div>

${u.requirejs('main.coffee')}
