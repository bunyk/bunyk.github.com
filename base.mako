<%namespace name="u" file="utils.mako"/>
<!DOCTYPE html>
<html><!-- this html is generated from ${filename}.mako! -->
    <head>
        <meta charset="utf-8" />
        <title><%block name="title" /></title>

        <link rel="stylesheet" href="/styles/bootstrap.min.css" />
        <link rel="stylesheet" href="/styles/bootstrap-responsive.css" />
        <link rel="stylesheet" href="/styles/global_layout.css" />
        ${u.requirejs('/hypercube/main.coffee')}
        <%block name="head" />
    </head>
<body>
    <div class="navbar navbar-inverse navbar-fixed-top"><div class="navbar-inner"><div class="container">
      <button data-target=".nav-collapse" data-toggle="collapse" class="btn btn-navbar" type="button">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <div class="nav-collapse collapse">
        ${u.main_menu((
            ('/', 'Home'),
            ('/resume/', 'CV'),
            ('/hypercube/', h.literal('Hypercube hack<span id="hypercube_logo"></span>')),
            (None, ('Deutschunterricht',
                ('/deutsch/', 'Übungen'),
                ('/deutsch/unendliche_geschichte.html', 'Die unendliche Geschichte'),
            )),
            ('/todo/', 'TODO app'),
            ('http://bunyk.wordpress.com/', 'Блоґ'),
        ))}
      </div>
      <script>hypercubeWidget("#hypercube_logo", 30, 30, 4, 3, 50, null, 'stroke:white;stroke-width:1');</script>
    </div></div></div>
    <div class="container">
        <h1>${self.title()}</h1>

        ${self.body()}

        <%block name="footer">
            <hr />
            <a href="http://bunyk.wordpress.com/">Bunyk Taras</a>, ${u.current_year()}. 
            ${u.google_analytics()}
        </%block>
    </div>
    ${u.requirejs('bootstrap_collapse')}
    ${u.requirejs('bootstrap_dropdown')}
</body>
</html>

