<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
	<link rel="stylesheet" href="../styles/global_layout.css" />
    ${u.requirejs('extjs')}
    ${u.requirejs('./main.coffee')}
</%block>

<%block name="title">Ext js test</%block>
