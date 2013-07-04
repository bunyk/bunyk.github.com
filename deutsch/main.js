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
            var $this = $(this), content = $(elem.draggable).html();
            console.log(content, $this.data('correct'));
            if($this.data('content')){
                return false;
            };
            $this.data('content', content);
            if(content == $this.data('correct')) {
                $this.css('background-color', '#CFC');
            } else {
                $this.css('background-color', '#FAA');
            };
        },
        out: function(evt, elem) {
            var $this = $(this), content = $(elem.draggable).html();
            if($this.data('content') == content) {
                $this.css('background-color', 'white');
                $this.data('content', '');
            };
        }
    });
});
