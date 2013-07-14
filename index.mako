<%inherit file="base.mako"/>
<%namespace name="u" file="utils.mako"/>

<%block name="title">Welcome to Bunyk's humble home page</%block>

<%block name="head">
	<link rel="stylesheet" href="/styles/home.css" />
</%block>

${u.disqus_thread('index')}
