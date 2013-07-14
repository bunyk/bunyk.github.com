# REQUIRE jquery
# REQUIRE underscore

$ = jQuery;

show_popup = (text, x, y, duration=2000) -> 
    popup = $('<div class="popup"></div>').html(text)
    (popup
        .css(
            'left': x - popup.width() / 2 + pageXOffset,
            'top': y + 10 + pageYOffset
        )
        .click(() ->
            $(this).remove()
        )
        .delay(duration / 5 * 4)
        .fadeOut(duration / 5)
        .queue(() -> $(this).remove())
    )
    $('body').append(popup)


dictionary = {}

save_dictionary = () ->
    localStorage.setItem('dictionary', JSON.stringify(dictionary))
load_dictionary = () ->
    dictionary = JSON.parse(localStorage.getItem('dictionary')) or {}

add_to_dictionary = (key, value, $elements) ->
    console.log 'adding to dictionary:', key, value
    dictionary[key] = value
    if $elements?
        $elements.each(() ->
            $(this).html((i, text) ->
                text.replace(
                    RegExp("\\b#{key}\\b(?!>)", 'g'),
                    '<span class="word">$&</span>'
                )
            )
        )
        $('.word').click((evt) ->
            show_popup(
                dictionary[$(this).html()],
                evt.clientX, evt.clientY
            )
        )

$.fn.bindDictionaryLookup = () ->
    load_dictionary()
    for word, meaning of dictionary
        add_to_dictionary(word, meaning, $(this))


dictionary_form = _.template("""
<div class="modal_window">
    <h3><%= key %></h3>
    <textarea cols="80" rows="5"><%= value %></textarea>
</div>
""")


init_state = () ->
    control_state = 'normal'

    input = () ->
        control_state = 'input'
        console.log('state', control_state)
    is_input = () -> control_state == 'input'

    normal = () -> 
        control_state = 'normal'
        console.log('state', control_state)
    is_normal = () -> control_state == 'normal'

    keypress = (evt) ->
        switch evt.which
            when 97 # 'a' button
                if is_normal()
                    add_dictionary_note()
    input: input
    normal: normal
    keypress: keypress

state = init_state()


add_dictionary_note = () ->
    key = window.getSelection().toString() or 'hello world'
    console.log(key)

    dialog = $(dictionary_form(key: key, value: dictionary[key]))
    save_button = (
        $('<button class="btn btn-success">Save</button>')
        .click(() ->
            add_to_dictionary(key, dialog.find('textarea').val(), $('p'))
            dialog.remove()
            state.normal()
        )
    )
    cancel_button = (
        $('<button id="cancel" class="btn btn-danger">Cancel</button>')
        .click(() ->
            dialog.remove()
            state.normal()
        )
    )
    dialog.append(save_button, cancel_button)
    state.input()
    $('body').append(dialog)


$(() ->
    $('p').bindDictionaryLookup()
    $(document).keypress(state.keypress)
    $(window).on('unload', () -> save_dictionary())
)
