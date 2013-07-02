"use strict";

require.config({
    paths: {
        jquery: ['http://code.jquery.com/jquery-1.10.0.min', '../jslibs/jquery-2.0.2.min'],
        jqueryui: ['http://code.jquery.com/ui/1.10.3/jquery-ui'],
    }
});

require([
    'jquery', 'jqueryui'
], function($, ui) {
    $('li').draggable();
    $('.droppable').droppable({
        drop: function(evt, elem) {
            var $this = $(this);
            console.log($(elem.draggable).html(), $this.data('correct'));
            if($(elem.draggable).html() == $this.data('correct')) {
                $this.css('background-color', 'green');
            } else {
                $this.css('background-color', 'red');
            };
        },
        out: function() {
            $(this).css('background-color', 'white');
        }
    });
});
