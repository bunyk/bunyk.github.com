"use strict";
define(['svglib', 'matrix'], function(svg, matrix) {
    var Point = svg.Point;
	var Hypercube = function (DIMENSIONS) {
		var VERTEXES = 1 << DIMENSIONS,
		    EDGES = DIMENSIONS * (1 << (DIMENSIONS - 1));

        console.log(DIMENSIONS,'-dimensional cube have ', VERTEXES, 'vertexes and', EDGES, 'edges');

        function Vertex(number) {
            this.coords = new matrix.Matrix(DIMENSIONS, 1, function (x, y) {
                var res = 0.5 - (number & 1);
				number >>= 1;
                return res;
            });
            this.point = new Point(this.coords.data[0], this.coords.data[1]);
        }
        Vertex.prototype.project_with_matrix = function (matrix) {
            var res = this.coords.mult(matrix).data[0];
            this.point.x = res[0]
            this.point.y = res[1];
        };

		function a_vertex(num) { // return number of first vertex of edge
    		var x = num >> (DIMENSIONS - 1);
    		num = num % (1 << (DIMENSIONS - 1));
    		var res = num % (1 << x);
    		num >>= x;
    		num <<= x + 1;
    		return res | num;
		}

		function b_vertex(num) { // return number of second vertex of edge
    		var x = num >> (DIMENSIONS - 1);
    		return a_vertex(num) | (1 << x);
		}

		this.reset = function (svg) { // sets cube into orthogonal position
            svg.clear();
			this.svg = svg;
			this.vertexes = [];
			for(var i = 0; i < VERTEXES; i++) {
                this.vertexes[i] = new Vertex(i);
            }

            this.lines = [];
            for(var i = 0; i < EDGES; i++)
            {
            	this.lines[i] = svg.line(
            		this.vertexes[a_vertex(i)].point,
            		this.vertexes[b_vertex(i)].point
            	);
            }

            this.matrix = new matrix.Matrix(DIMENSIONS, DIMENSIONS, matrix.identity); 
            this.update_projection();
		}

		this.rotate_matrix = function (a, b, angle) { // rotates cube inside plane ab
        	angle *= 3.1415926535 / 180;
            var c = Math.cos(angle),
                s = Math.sin(angle);

            // rotation matrix
            var rot_m = new matrix.Matrix(DIMENSIONS, DIMENSIONS, matrix.identity);
            rot_m.set(a, a, c); rot_m.set(a, b, -s);
            rot_m.set(b, a, s); rot_m.set(b, b, c);

            this.matrix = this.matrix.mult(rot_m);
        };
        this.update_projection = function() {
        	for(var i = 0; i < VERTEXES; i++)
        	{
                this.vertexes[i].project_with_matrix(this.matrix);
        	}
    	};
        this.rotate = function(a, b, angle) {
            this.rotate_matrix(a, b, angle);
            this.update_projection();
        };
	};

    return {
        'Hypercube': Hypercube,
    };
});
