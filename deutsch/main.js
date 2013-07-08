"use strict";

require.config({
    paths: {
        jquery: ['http://code.jquery.com/jquery-1.10.0.min', '../jslibs/jquery-2.0.2.min'],
        jqueryui: ['http://code.jquery.com/ui/1.10.3/jquery-ui', '../jslibs/jquery-ui.min'],
    },
    shim: {
        'jqueryui': ['jquery'],
        'exercises2': ['jquery', 'jqueryui'],
    },
});

require([
    'jquery', 'jqueryui', 'exercises'
], function($) {
   $('.drag_exercise').each(function() {
       $(this).dragExcercise();
    });
});
