'use strict';

(function($) {
    //var c = function() {}; // for production
    var c = console.log.bind(console); // for debug

    $.fn.checkContent = function(visual) {
        var $this = $(this),
            correct = $this.data('content') == $this.data('correct');
        if(visual) {
            if(correct) {
                $this.css('background-color', '#CFC');
            } else {
                $this.css('background-color', '#FAA');
            };
        };
        return correct;
    };

    $.fn.dragExcercise = function(check_instantly) {
        c('dragExcercise plugin started for', this);
        /*
         * Inside exercise element elements with class "draggable" should be 
         * dragged into elements with class "droppable".
         * When the html content of draggable equals data stored in 
         * data-correct attribute of droppable element, then draggable and
         * droppable become green. Else red.
        */

        $('.draggable', this).draggable();
        var $droppables = $('.droppable', this).droppable({
            tolerance: 'pointer',
            drop: function(evt, elem) {
                var $this = $(this),
                    $elem = $(elem.draggable);
                c($elem.html(), '- data put into container');
                c($this.data('correct'), '- data which should be put into container');
                if($this.data('content')) {
                    c('element already occupied');
                    return false;
                };
                $this.data('content', $elem.html()); c('content put into element');
                if(check_instantly) {
                    $this.checkContent(true);
                };
            },
            out: function(evt, elem) {
                var $this = $(this),
                    $elem = $(elem.draggable);
                if($this.data('content') != $elem.html()) {
                    c('leaves some other element');
                    return false; 
                };

                $this.css('background-color', 'white');
                $this.data('content', '');
                $elem.css('color', 'black');
            }
        });
    };
}(jQuery));
