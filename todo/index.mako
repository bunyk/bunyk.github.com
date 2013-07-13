<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
    ${u.requirejs('todos.coffee')}
    <link rel="stylesheet" href="todo.css" />
</%block>

<%block name="title">TODO list</%block>

<p>Created for learning backbone and may be for personal management</p>

<div id="todoapp">
    <div class="content">
        <div id="create-todo">
            <input id="new-todo" placeholder="What else needs to be done?" type="text" />
        </div>
        <div id="todos">
            <ul id="todo-list"></ul>
        </div>
    </div>
</div>
