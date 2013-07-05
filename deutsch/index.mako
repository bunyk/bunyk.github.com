<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
    <script type="text/javascript" src="../jslibs/require.js" data-main="main.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
</%block>

<%block name="title">Моє бачення інтерактивного підручника німецької</%block>

Перевірте чи елементи не можна перетягувати.

<style type="text/css">
ol {
    list-style-type: lower-alpha;
}
ol > li {
    display: inline;
    cursor: move;
}
.droppable {
    border-bottom: 1px solid;
    width: 10em;
    display: inline-block;
    height: 1em;
}
</style>

<h2>1</h2> <p>Доповніть діалог, вибираючи з-поміж поданих слів.</p>
<ol>
    <li>mir</li>
    <li>Ordnung</li>
    <li>Ihnen</li>
    <li>neu</li>
    <li>kennen zu lernen</li>
    <li>Ihr Name</li>
    <li>heißen</li>
</ol>

<p>- Ist alles in <span class="droppable" data-correct="Ordnung"></span>?
    Geht es <span class="droppable" data-correct="Ihnen"></span> gut?</p>
<p>- Ja sicher. Es geht <span class="droppable" data-correct="mir"></span> gut. 
    Ich bin nur müde.</p>
<p>- Sind Sie <span class="droppable" data-correct="neu"></span> hier?</p>
<p>- Ja. Nett, Sie <span class="droppable" data-correct="kennen zu lernen"></span>.
Wie <span class="droppable" data-correct="heißen"></span> Sie?</p>
<p>- Ich bin Ben. Und wie ist <span class="droppable" data-correct="Ihr Name"></span>?</p>
<p>- Ich bin Anna.</p>

${u.disqus_thread('deutsch')}
