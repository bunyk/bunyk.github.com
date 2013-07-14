<%inherit file="base.mako"/>
<%namespace name="u" file="utils.mako"/>

<%block name="title">Bunyk's home page testing panel</%block>

<%block name="head">
	<link rel="stylesheet" href="styles/qunit.css" />
</%block>

<div id="qunit"></div>

${u.requirejs('test-main.js')}
