'use strict';

(function($) {

    var popup = function (text, x, y) {
        var popup = $('<div class="popup" style="position:absolute;"></div>');
        popup.html(text);
        $('body').append(popup);
        popup.css('left', x - popup.width() / 2 + pageXOffset);
        popup.css('top', y + 10 + pageYOffset);
        popup.delay(2000).fadeOut(500);
    };

    $.fn.bindDictionaryLookup = function (dictionary) {
        var transform_text = function(text) {
            var res = text;
            for(var word in dictionary) {
                var r = RegExp('\\b' + word + '\\b(?!>)', 'g');
                res = res.replace(r, '<span class="word">$&</span>');
            };
            return res;
        };
        $(this).each(function(){
            $(this).html(transform_text($(this).html()));
        });
        $('.word').click(function(evt) {
            var lookup_info = dictionary[$(this).html()];
            popup(lookup_info, evt.clientX, evt.clientY);
        });
    };
    $(function(){
        $('p').bindDictionaryLookup({
            die: 'жіночий рід',
            und: 'und - і',
            Tumults: 'Неспокій',
            Der: 'Артикль',
        });
    });
}(jQuery));
