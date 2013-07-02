<%namespace name="u" file="utils.mako"/>
<!DOCTYPE html>
<html><!-- this html is generated from mako! -->
    <head>
        <meta charset="utf-8" />
        <title><%block name="title" /></title>

        <link rel="stylesheet" href="/styles/global_layout.css" />
        <%block name="head" />
    </head>
<body>
    <h1>${self.title()}</h1>
    ${self.body()}

<%block name="footer">
    <hr />
    <a href="http://bunyk.wordpress.com/">Bunyk Taras</a>, ${u.current_year()}. 
    ${u.google_analytics()}
</%block>

</body>
</html>

