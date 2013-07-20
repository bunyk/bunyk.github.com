<%inherit file="base.mako"/>
<%namespace name="u" file="utils.mako"/>

<%block name="title">Welcome to Bunyk's amazing home page</%block>

<p><a href="https://github.com/bunyk/">Look at my code</a>, my code is amazing!</p>
${u.disqus_thread('index')}
