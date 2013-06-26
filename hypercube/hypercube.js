
define(['svglib', 'matrix'], function(svg, Matrix) {
    var Point = svg.Point;
	var Hypercube = function (DIMENSIONS) {
		VERTEXES = 1 << DIMENSIONS;
		EDGES = DIMENSIONS * (1 << (DIMENSIONS - 1));
        console.log(DIMENSIONS,'-dimensional cube have ', VERTEXES, 'vertexes and', EDGES, 'edges');

        function Vertex(number) {
            this.coords = new Matrix(DIMENSIONS, 1, function (x, y) {
                var res = 0.5 - (number & 1);
				number >>= 1;
                return res;
            });
            this.point = new Point(this.coords.data[0], this.coords.data[1]);
        }
        Vertex.prototype.project_with_matrix = function (matrix) {
            var res = this.coords.mult(matrix);
            this.point.x = res.data[0]
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

            this.matrix = new Matrix(2, DIMENSIONS, function(x, y) {
                return x == y ? 1 : 0;
            });
		}

		this.rotate_matrix = function (a, b, angle) { // rotates cube inside plane ab
        	angle *= 3.1415926535 / 180;
            var c = Math.cos(angle),
                s = Math.sin(angle);

            var rot_f = function (x, y) {
                if (x == a) {
                    if (y == a) return c;
                    if (y == b) return -s;
                };
                if (x == b) {
                    if (y == a) return s;
                    if (y == b) return c;
                };
                return 0;
            }; // sparse rotation matrix
            var rot_m = new Matrix(DIMENSIONS, DIMENSIONS, rot_f, true);
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
