# REQUIRE jquery
# REQUIRE google_maps

$ = jQuery

class Plane
    constructor: (@lat, @lng) ->
        @altitude = 0
        @set_velocity(0, 0)
        setInterval(@move, 100)

    set_velocity: (@v_x, @v_y) ->
        console.log('Velocity:', @v_x, @v_y)

    get_position: () ->
        new google.maps.LatLng(@lat, @lng)

    get_zoom: () ->
        return 18 - @altitude / 10.0

    change_altitude: (d) ->
        @altitude += d
        if @altitude < 0
            @altitude = 0
        console.log @altitude
        if @map?
            @map.setZoom(@get_zoom())

    move: () =>
        console.log('Position:', @lat, @lng)
        @lat -= @v_y
        @lng += @v_x
        if @map?
            @map.panTo(@get_position())

initialize = () ->
    plane = new Plane(
        48.884167, 24.686111
    )

    map = new google.maps.Map(
        $("#map-canvas")[0],
        {
          center: plane.get_position()
          zoom: plane.get_zoom()
          disableDefaultUI: true
          mapTypeId: google.maps.MapTypeId.SATELLITE
        }
    )
    plane.map = map

    $(window).keydown((event) ->
        s = 0.0005
        console.log event.keyCode
        switch event.keyCode
            when 38 then plane.set_velocity(0, -s) # up
            when 39 then plane.set_velocity(s, 0) # right
            when 40 then plane.set_velocity(0, s) # down
            when 41 then plane.set_velocity(-s, 0) # left
            when 32 then plane.set_velocity(0, 0) # space
            when 74 then plane.change_altitude(-1) # j
            when 75 then plane.change_altitude(1) # k
    )

$(() ->
    initialize()
)
