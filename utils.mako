<%def name="current_year()" filter="trim">
    <% import datetime  %>
    ${datetime.date.today().year}
</%def>
<%def name="present_moment()" filter="trim">
    <% import datetime  %>
    ${datetime.datetime.now().strftime('%Y %B %d, %H:%M')}
</%def>

<%def name="google_analytics()">
<script type="text/javascript"> var _gaq = _gaq || []; _gaq.push(['_setAccount', 'UA-42001280-1']); _gaq.push(['_trackPageview']);
(function() { var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s); })();</script>
</%def>


