<%inherit file="base.mako"/>
<%namespace name="u" file="utils.mako"/>

<%block name="title">Bunyk's humble home page</%block>

<a href="resume/">Resume</a>
<h2>Hacks:</h2>
<ul>
	<li><a href="hypercube">HTML5 SVG Hypercube animation hack</a></li>
</ul>

${u.disqus_thread('index')}
