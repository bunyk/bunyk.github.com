<%def name="requirejs(file)" filter="trim">
    <%
        import os
        import requirejs
    %>
    ${requirejs.include(os.path.join(
        os.path.dirname(filename), file
    ), '.')}
</%def>

<%def name="current_year()" filter="trim">
    <% import datetime  %>
    ${datetime.date.today().year}
</%def>
<%def name="present_moment()" filter="trim">
    <% import datetime  %>
    ${datetime.datetime.now().strftime('%Y %B %d, %H:%M')}
</%def>

<%def name="li_menu(page)" filter="trim">
    %if page == filename:
        <li class = "active">
    % else:
        <li>
    %endif
</%def>

<%def name="google_analytics()">
<script type="text/javascript"> var _gaq = _gaq || []; _gaq.push(['_setAccount', 'UA-42001280-1']); _gaq.push(['_trackPageview']);
(function() { var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s); })();</script>
</%def>

<%def name="disqus_thread(identifier)">
    <hr />
    <div id="disqus_thread"></div>
    <script type="text/javascript">
        /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
        var disqus_shortname = 'bunykshumblehomepage'; // required: replace example with your forum shortname
        var disqus_identifier = '${identifier}'; 

        /* * * DON'T EDIT BELOW THIS LINE * * */
        (function() {
            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
            dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
            (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
        })();
    </script>
    <noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
    <a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>
</%def> 
