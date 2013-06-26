"use strict";

require.config({
    paths: {
        jquery: ['http://code.jquery.com/jquery-1.10.0.min', '../jslibs/jquery-2.0.2.min'],
        radio: ['../jslibs/radio.min'],
        hypercube: 'hypercube',
        svglib: 'svglib',
    }
});

require([
    "svglib",
    "hypercube"
], function(svglib, hypercube) {
    // the app is loaded...
	$(function() {
		var svg = new svglib.SVG('#surface', 500, 500);
        var dimensions = 3;
		var cube = new hypercube.Hypercube(dimensions);
		cube.reset(svg);
        $('#matrix').html(cube.matrix.html());
        var a_d = 0, b_d = 1;
        cube.rotate(a_d, b_d, 45);
        $('#matrix').html(cube.matrix.html());

/*
		setInterval(function() {
            cube.rotate(a_d, b_d, 5);
            if (Math.random() < 0.01) {
                a_d = (a_d + 1) % dimensions;
                b_d = (b_d + 1) % dimensions;
            };
        }, 200);
        */
	});
});
