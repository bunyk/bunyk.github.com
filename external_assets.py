_dependencies = {}

jquery = 'http://code.jquery.com/jquery-2.0.3.min.js'
jquery_ui = 'http://code.jquery.com/ui/1.10.3/jquery-ui.min.js'
qunit = 'http://code.jquery.com/qunit/qunit-1.12.0.js'

_dependencies['jquery_ui'] = ['jquery']

underscore = 'http://underscorejs.org/underscore-min.js'
backbone = 'http://backbonejs.org/backbone-min.js'
_dependencies['backbone'] = [
    'underscore',
    'jquery' # don't know why, but this fixes some bugs. Order of script tags matters.
]

backbone_localstorage = 'http://raw.github.com/jeromegn/Backbone.localStorage/master/backbone.localStorage-min.js'
_dependencies['backbone_localstorage'] = ['backbone']

radio = 'http://raw.github.com/uxder/Radio/master/radio.min.js'

bootstrap_collapse = 'http://twitter.github.io/bootstrap/assets/js/bootstrap-collapse.js'
_dependencies['bootstrap_collapse'] = ['jquery']

bootstrap_dropdown = 'http://twitter.github.io/bootstrap/assets/js/bootstrap-dropdown.js'
_dependencies['bootstrap_dropdown'] = ['jquery']

firebase = 'http://cdn.firebase.com/v0/firebase.js'

raphael = 'http://raw.github.com/DmitryBaranovskiy/raphael/master/raphael-min.js'
raphael_src = 'http://raw.github.com/DmitryBaranovskiy/raphael/master/raphael.js'

extjs = 'http://cdn.sencha.io/ext-4.2.0-gpl/ext-all.js'

d3 = 'http://d3js.org/d3.v3.min.js'

google_maps = 'https://maps.googleapis.com/maps/api/js?language=uk'

react = 'http://fb.me/react-0.12.1.js'
JSXTransformer = 'http://fb.me/JSXTransformer-0.12.1.js'
_dependencies['react'] = ['JSXTransformer']

angular = 'http://ajax.googleapis.com/ajax/libs/angularjs/1.4.3/angular.js'
