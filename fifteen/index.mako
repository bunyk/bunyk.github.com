<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
	<link rel="stylesheet" href="../styles/global_layout.css" />
    ${u.requirejs('main.coffee')}
</%block>

<%block name="title">15-puzzle</%block>

<div class="widget_block">
</div>
