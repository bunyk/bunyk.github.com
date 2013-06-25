require.config({
    paths: {
        jquery: ['http://code.jquery.com/jquery-1.10.0.min', 'jslibs/jquery-2.0.2.min'],
    }
});

require([
    "svg_bind",
    "hypercube"
], function(svg_bind, hypercube) {
    // the app is loaded...
	$(function() {
		var svg = new svg_bind.SVG('#surface', 500, 500);
        var dimensions = 3;
		var cube = new hypercube.Hypercube(dimensions);
		cube.reset(svg);
        var a_d = 0, b_d = 1;
        cube.rotate(a_d, b_d, 45);


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
