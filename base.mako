<%namespace name="u" file="utils.mako"/>
<!DOCTYPE html>
<html><!-- this html is generated from ${filename}.mako! -->
    <head>
        <meta charset="utf-8" />
        <title><%block name="title" /></title>

        <%block name="head" />
        <link rel="stylesheet" href="/styles/global_layout.css" />
    </head>
<body>
    <%doc>
    <!-- Cover to show during loading process -->
    <div id="cover" style="
        position: fixed;
        top: 0px;
        left: 0px;
        right: 0px;
        bottom:0px;
        z-index: 9999;
        background-color:white;
        line-height:100%;
        font-size: 5em;
        font-family: 'Courier New', Courier, monospace;
    ">Loading.</div>
    <script type="text/javascript">
    (function() {
        var cover = document.getElementById('cover');
        var i = 2;
        window.loading_progress = setInterval(function() {
            i++;
            if(i>10) i=2;
            cover.innerHTML = 'Loading' + Array(i).join('.');
        }, 200);
    }());
    </script>
    
    ${u.requirejs('jquery')}
    <script type="text/javascript">
    (function($) {
        $(window).load(function() {
            clearInterval(window.loading_progress);
            $('#cover').hide();
        });
    }(jQuery));
    </script>
    </%doc>

    <!-- Navigation -->
    <div id="sidebar">
        ${u.main_menu((
            ('/', 'Home'),
            ('/resume/', 'CV'),
            ('/tech_tree/', 'Technology tree'),
            ('/hypercube/', 'Hypercube hack'),
            (None, ('Deutschunterricht',
                ('/deutsch/', 'Übungen'),
                ('/deutsch/unendliche_geschichte.html', 'Die unendliche Geschichte'),
            )),
            ('/gamemaps/', 'Google Maps game'),
            ('/canvas/', 'HTML5 canvas test'),
            ('/drawing/', 'HTML5 SVG test'),
            ('http://bunyk.wordpress.com/', 'Блоґ'),
        ))}
    </div>
    <h1>${self.title()}</h1>

    ${self.body()}

    <%block name="footer">
        <hr />
        <a href="http://bunyk.wordpress.com/">Bunyk Taras</a>, ${u.current_year()}. 
        ${u.google_analytics()}
    </%block>
</body>
</html>

