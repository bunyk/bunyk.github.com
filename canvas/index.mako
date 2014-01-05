<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
	<link rel="stylesheet" href="../styles/global_layout.css" />
    ${u.requirejs('main.coffee')}
</%block>

<%block name="title">HTML5 canvas graphics test</%block>

<div id="content">
</div>
