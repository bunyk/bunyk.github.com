# REQUIRE underscore

_.zfill = (x, padding) ->
    zeroes = ('0' for i in [0..padding]).join('')
    (zeroes + x).slice(-1 * padding)

class AllReady
    constructor: (@onReady) ->
        @id = 0
        @checklist = {}

    wait: () ->
        @id += 1
        @checklist[@id] = false

        get_callback = (id, ready) ->
            () =>
                ready(id)
        get_callback(@id, @ready)

    ready: (id) =>
        @checklist[id] = true
        if _.reduce(@checklist, ((a, b) -> a and b), true)
            @onReady()

window.AllReady = AllReady
