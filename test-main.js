"use strict";
require.config({
    paths: {
        QUnit: 'jslibs/qunit/qunit',
        jquery: ['http://code.jquery.com/jquery-1.10.0.min', '../jslibs/jquery-2.0.2.min'],
        radio: ['jslibs/radio.min']
    },
    shim: {
        'QUnit': {
            exports: 'QUnit',
            init: function() {
                QUnit.config.autoload = false;
                QUnit.config.autostart = false;
            }
        }
    }
});

require([
    'QUnit',
    'hypercube/tests'
], function(QUnit, hypercube_test) {
    hypercube_test.run();

    QUnit.load();
    QUnit.start();
});

