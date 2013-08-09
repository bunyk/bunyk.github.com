# REQUIRE jquery
# REQUIRE jquery_ui

$ = jQuery

c = console.log.bind console

$.fn.editable = () ->
    $this = $(this)
    editable = (e) -> $this.attr('contentEditable', e)

    $this
        .click(() -> editable(true))
        .blur(() -> editable(false))
        .keypress (e) ->
            code = if e.keyCode then e.keyCode else e.which
            if code == 13
                $this.blur()
    this

$.fn.checkContent = (visual, html=false) ->
    $this = $(this)
    content = if html then $this.html().trim() else $this.data('content')
    c "Checking if #{content} is corrrect"
    correct = content == $this.data('correct')
    if visual
        if correct
            $this.css('background-color', '#CFC')
        else
            $this.css('background-color', '#FAA')
    correct

$.fn.fillExcercise = (check_instantly) ->
    c 'fillExcercise plugin started for', this
    ### inside this, elements with class "editable"
        become editable and data-correct attribute should be set.
    ###

    $editables = $('.editable', this).editable()
    add_check_button($(this), $editables, true)

$.fn.dragExcercise = (check_instantly) ->
    c 'dragExcercise plugin started for', this
    ###
    Inside exercise element elements with class "draggable" should be 
    dragged into elements with class "droppable".
    When the html content of draggable equals data stored in 
    data-correct attribute of droppable element, then draggable and
    droppable become green. Else red.
    ###
    $('.draggable', this).draggable()
    $droppables = $('.droppable', this).droppable(
        tolerance: 'pointer',
        drop: (evt, elem) ->
            $this = $(this)
            $elem = $(elem.draggable)
            c($elem.html(), '- data put into container')
            c($this.data('correct'), '- data which should be put into container')
            if $this.data('content')
                c('element already occupied')
                return false
            $this.data('content', $elem.html()) 
            c('content put into element')
            if check_instantly
                $this.checkContent(true)
        out: (evt, elem) ->
            $this = $(this)
            $elem = $(elem.draggable)
            if $this.data('content') != $elem.html()
                c('leaves some other element')
                return false

            $this.css('background-color', 'white')
            $this.data('content', '')
            $elem.css('color', 'black')
    )
    add_check_button($(this), $droppables)


add_check_button = ($this, $elements, check_html=false) ->
    check_all = () ->
        total = 0
        correct = 0
        $elements.each(() ->
            if $(this).checkContent(true, check_html)
                correct++
            total++
        )
        correct / total
        
    $check = $('<button>Check</button>').click(() -> 
        points = Math.round(check_all() * 12)
        $this.append("<p>Points = #{points} of 12</p>")
    )
    c 'Adding check button'

    $this.append($check)
