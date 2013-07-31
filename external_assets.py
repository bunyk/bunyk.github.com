_dependencies = {}

jquery = 'http://code.jquery.com/jquery-2.0.3.min.js'
jquery_ui = 'http://code.jquery.com/ui/1.10.3/jquery-ui.min.js'
qunit = 'http://code.jquery.com/qunit/qunit-1.12.0.js'

underscore = 'http://underscorejs.org/underscore-min.js'
backbone = 'http://backbonejs.org/backbone-min.js'
_dependencies['backbone'] = ['underscore']

backbone_localstorage = 'http://raw.github.com/jeromegn/Backbone.localStorage/master/backbone.localStorage-min.js'
_dependencies['backbone_localstorage'] = ['backbone']

radio = 'http://raw.github.com/uxder/Radio/master/radio.min.js'

bootstrap_collapse = 'http://twitter.github.io/bootstrap/assets/js/bootstrap-collapse.js'
_dependencies['bootstrap_collapse'] = ['jquery']

bootstrap_dropdown = 'http://twitter.github.io/bootstrap/assets/js/bootstrap-dropdown.js'
_dependencies['bootstrap_dropdown'] = ['jquery']

firebase = 'https://cdn.firebase.com/v0/firebase.js'
