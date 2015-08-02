<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
	<link rel="stylesheet" href="../styles/global_layout.css" />
    ${u.requirejs('main.js')}
    <style>
        .month_block {
            display: inline-block;
            vertical-align: top;
            width: 30%;
        }
    </style>
</%block>

<div ng-app="calendar">
<div ng-controller="CalendarController as cc">
    <div>
        <input class="noprint" type="number" ng-model="cc.year"/> {{cc.year}}
    </div>
    <pre class="month_block" ng-repeat="month in cc.range(12)" >
        {{cc.get_month(month)}}
    </pre>
</div>
</div>

${u.disqus_thread('calendar')}
