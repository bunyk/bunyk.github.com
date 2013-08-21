<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
    ${u.requirejs('home_bi.coffee')}

<style>
.item-list tr .input {
    display: none;
}
.item-list tr .save {
    display: none;
}
.item-list tr.editing .edit {
    display: none;
}
.item-list tr.editing .save {
    display: block;
}
.item-list tr.editing .input {
    display: block;
}
.item-list tr.editing .content {
    display: none;
}
.widget {
    padding: 20px;
    border: 1px solid black;
}
td {
    border: 1px solid black;
    padding: 2px;
    margin: 0px;
}
</style>
</%block>

<%block name="title">Controlling home budget</%block>

<p>Created for learning backbone and to computing stats for my household</p>

<div class="widget" id="vendors"></div>
<div class="widget" id="products"></div>
