<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
    ${u.requirejs('home_bi.coffee')}

<style>
#product-list li .input {
    display: none;
}
#product-list li.editing input {
    display: block;
}
#product-list li.editing span {
    display: none;
}
</style>
</%block>

<%block name="title">Controlling home budget</%block>

<p>Created for learning backbone and to computing stats for my household</p>

<div id="products">
    <input id="new-product" placeholder="Add another product." type="text" />
    <ul id="product-list"></ul>
</div>
