<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="exercises.css" />
    ${u.requirejs('main.coffee')}
</%block>

<%block name="title">Моє бачення інтерактивного підручника німецької</%block>

Перевірте чи елементи не можна перетягувати.

<div class="exercise drag_exercise">
    <h2>1</h2> <p>Доповніть діалог, вибираючи з-поміж поданих слів.</p>
    <ol>
        <li class="draggable">mir</li>
        <li class="draggable">Ordnung</li>
        <li class="draggable">Ihnen</li>
        <li class="draggable">neu</li>
        <li class="draggable">kennen zu lernen</li>
        <li class="draggable">Ihr Name</li>
        <li class="draggable">heißen</li>
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
</div>
<div class="exercise fill_exercise">
    <h2>2</h2><p>Впишіть правильні назви кольорів:</p>
    <%doc><ol>
        <li class="draggable">blau</li>
        <li class="draggable">braun</li>
        <li class="draggable">gelb</li>
        <li class="draggable">grau</li>
        <li class="draggable">grün</li>
        <li class="draggable">orange</li>
        <li class="draggable">rot</li>
        <li class="draggable">schwarz</li>
        <li class="draggable">violett</li>
        <li class="draggable">weiß</li>
    </ol></%doc>
    <table>
        <tr><td bgcolor="red" width="30px">&nbsp;</td><td><span class="editable" data-correct="rot"></span></td></tr>
        <tr><td bgcolor="orange">&nbsp;</td><td><span class="editable" data-correct="orange"></span></td></tr>
        <tr><td bgcolor="yellow">&nbsp;</td><td><span class="editable" data-correct="gelb"></span></td></tr>
        <tr><td bgcolor="green">&nbsp;</td><td><span class="editable" data-correct="grün"></span></td></tr>
        <tr><td bgcolor="blue">&nbsp;</td><td><span class="editable" data-correct="blau"></span></td></tr>
        <tr><td bgcolor="#9F00FF">&nbsp;</td><td><span class="editable" data-correct="violett"></span></td></tr>
        <tr><td bgcolor="black">&nbsp;</td><td><span class="editable" data-correct="schwarz"></span></td></tr>
        <tr><td bgcolor="grey">&nbsp;</td><td><span class="editable" data-correct="grau"></span></td></tr>
        <tr><td bgcolor="white">&nbsp;</td><td><span class="editable" data-correct="weiß"></span></td></tr>
        <tr><td bgcolor="brown">&nbsp;</td><td><span class="editable" data-correct="braun"></span></td></tr>
    </table>
</div>

${u.disqus_thread('deutsch')}
