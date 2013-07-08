# REQUIRE /jslibs/jquery-2.0.2.min.js
$ = jQuery

c = console.log.bind console

$.fn.checkContent = (visual) ->
    $this = $(this)
    c 'Checking if #{$this} is corrrect'
    correct = $this.data('content') == $this.data('correct')
    if visual
        if correct
            $this.css('background-color', '#CFC')
        else
            $this.css('background-color', '#FAA')
    correct

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
    check_all = () ->
        total = 0
        correct = 0
        $droppables.each(() ->
            if $(this).checkContent(true)
                correct++
            total++
        )
        correct / total
        
    if not check_instantly
        $this = $(this)
        $check = $('<button>Check</button>').click(() -> 
            points = Math.round($ check_all() * 12)
            $this.append("<p>Points = #{mark} of 12</p>")
        )
        c 'Adding check button'

        $this.append($check)
