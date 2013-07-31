<%inherit file="/base.mako" />
<%namespace name="u" file="/utils.mako"/>

<%block name="head">
    ${u.requirejs('reading.coffee')}
    <link rel="stylesheet" href="reading.css" />
</%block>

<%block name="title">Die unendliche Geschichte</%block>

<button id="edit_save" class="btn">Edit</button>
<textarea id="edit_content" style="display:none" rows="20"></textarea>
<div id="content">
    <p>TAIRAUQITNA<br />
    rednaeroK darnoK lraK: rebahnI</p>
    <p> ... </p>
</div>

${u.disqus_thread('unendliche_geschichte')}
