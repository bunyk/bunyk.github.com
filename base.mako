<%namespace name="u" file="utils.mako"/>
<!DOCTYPE html>
<html><!-- this html is generated from ${filename}.mako! -->
    <head>
        <meta charset="utf-8" />
        <title><%block name="title" /></title>

        <link rel="stylesheet" href="/styles/global_layout.css" />
        <link rel="stylesheet" href="/styles/bootstrap.min.css" />
        <%block name="head" />
    </head>
<body>
    <div class="container">
        <h1>${self.title()}</h1>

        <div class="navbar">
        <div class="navbar-inner">
            <ul class="nav">
            ${u.li_menu('index')}<a href="/">Home</a></li>
            ${u.li_menu('resume/index')}<a href="/resume/">CV</a></li>
            ${u.li_menu('hypercube/index')}<a href="/hypercube/">Hypercube hack</a></li>
            ${u.li_menu('deutsch/index')}<a href="/deutsch/">Німецька сторіночка</a></li>
            <li><a href="http://bunyk.wordpress.com/">Блоґ</a></li>
            </ul>
        </div>
        </div>

        ${self.body()}

        <%block name="footer">
            <hr />
            <a href="http://bunyk.wordpress.com/">Bunyk Taras</a>, ${u.current_year()}. 
            ${u.google_analytics()}
        </%block>
    </div>
</body>
</html>

