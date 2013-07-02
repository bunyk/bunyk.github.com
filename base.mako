<%namespace name="u" file="utils.mako"/>
<!DOCTYPE html>
<html><!-- this html is generated from mako! -->
    <head>
        <meta charset="utf-8" />
        <title><%block name="title" /></title>

        <link rel="stylesheet" href="./styles/global_layout.css" />
        <link rel="stylesheet" href="../styles/bootstrap.min.css" />
        <%block name="head" />
    </head>
<body>
    <div class="navbar">
    <div class="navbar-inner">
        <span class="brand">Bunyk: </span>
        <ul class="nav">
        <li class="active"><a href="/">Home</a></li>
        <li><a href="/resume/">CV</a></li>
        <li><a href="/hypercube/">Hypercube hack</a></li>
        <li><a href="/deutsch/">Німецька сторіночка</a></li>
        <li><a href="http://bunyk.wordpress.com/">Блоґ</a></li>
        </ul>
    </div>
    </div>

    <div class="container">
        <h1>${self.title()}</h1>
        ${self.body()}
    </div>

<%block name="footer">
    <hr />
    <a href="http://bunyk.wordpress.com/">Bunyk Taras</a>, ${u.current_year()}. 
    ${u.google_analytics()}
</%block>

</body>
</html>

