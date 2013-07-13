<%namespace name="u" file="utils.mako"/>
<!DOCTYPE html>
<html><!-- this html is generated from ${filename}.mako! -->
    <head>
        <meta charset="utf-8" />
        <title><%block name="title" /></title>

        <link rel="stylesheet" href="/styles/global_layout.css" />
        <link rel="stylesheet" href="/styles/bootstrap.min.css" />
        <link rel="stylesheet" href="/styles/bootstrap-responsive.css" />
        ${u.requirejs('/jslibs/jquery-2.0.2.min.js')}
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
            ('/hypercube/', 'Hypercube hack'),
            (None, ('Deutschunterricht',
                ('/deutsch/', 'Übungen'),
                ('/deutsch/unendliche_geschichte.html', 'Die unendliche Geschichte'),
            )),
            ('/todo/', 'TODO app'),
            ('http://bunyk.wordpress.com/', 'Блоґ'),
        ))}
      </div>
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
    ${u.requirejs('/jslibs/bootstrap-collapse.js')}
    ${u.requirejs('/jslibs/bootstrap-dropdown.js')}
</body>
</html>

