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
        var dimensions = 5;
		var svg = new svglib.SVG(
            '#surface', 300, 300,
            Math.sqrt(dimensions) // diagonal of n-hypercube = sqrt(d)
        );
		var cube = new hypercube.Hypercube(dimensions);
		cube.reset(svg);
        $('#matrix').html(cube.matrix.html());
        var a_d = 0, b_d = 1;

		var animate = function() {
            cube.rotate(a_d, b_d, 5);
            $('#matrix').html(cube.matrix.html());
            if (Math.random() < 0.05) {
                a_d = (Math.floor(Math.random() * 2));
                b_d = (Math.floor(Math.random() * dimensions));
                if(b_d == a_d) b_d = (a_d + 1) % dimensions;
            };
            setTimeout(animate, 40);
        };
        setTimeout(animate, 40);
	});
});
