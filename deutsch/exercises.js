'use strict';

(function($) {
    //var c = function() {}; // for production
    var c = console.log.bind(console); // for debug

    $.fn.dragExcercise = function() {
        c('dragExcercise plugin started for', this);
        /*
         * Inside exercise element elements with class "draggable" should be 
         * dragged into elements with class "droppable".
         * When the html content of draggable equals data stored in 
         * data-correct attribute of droppable element, then draggable and
         * droppable become green. Else red.
        */
        $('.draggable', this).draggable();
        $('.droppable', this).droppable({
            tolerance: 'pointer',
            drop: function(evt, elem) {
                var $this = $(this),
                    $elem = $(elem.draggable);
                c($elem.html(), $this.data('correct'));
                if($this.data('content')) {
                    c('element already occupied');

                    return false;
                };
                $this.data('content', $elem.html()); c('content put into element');
                if($elem.html() == $this.data('correct')) {
                    c('correct variant');

                    $this.css('background-color', '#CFC');
                    $elem.css('color', 'green');
                } else {
                    c('incorrect variant');

                    $this.css('background-color', '#FAA');
                    $elem.css('color', 'red');
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
