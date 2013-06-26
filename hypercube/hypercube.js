
define(['hypercube/svglib'], function(svg) {
    var Point = svg.Point;
	var Hypercube = function (DIMENSIONS) {
		VERTEXES = 1 << DIMENSIONS;
		EDGES = DIMENSIONS * (1 << (DIMENSIONS - 1));
        console.log(DIMENSIONS,'-dimensional cube have ', VERTEXES, 'vertexes and', EDGES, 'edges');

        function Vertex(number) {
            this.coords = [];
			for(var i = 0; i < DIMENSIONS; i++) {
				this.coords[i] = (0.5 - (number & 1));
				number >>= 1;
			}
            this.point = new Point(this.coords[0], this.coords[1]);
        }
        Vertex.prototype.project_with_matrix = function (matrix) {
            console.log(matrix);
            var res = [];
            for(var j = 0; j < 2; j++) {
                res[j] = 0;
                for(var i = 0; i < DIMENSIONS; i++) {
                    res[j] += this.coords[i] * matrix[j][i];
                };
            };
            console.log(this.coords, '->', res);
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

            this.matrix = [];
            this.matrix[0] = [];
            this.matrix[1] = [];
            for(var i = 0; i < DIMENSIONS; i++) {
                this.matrix[0][i] = 0;
                this.matrix[1][i] = 0;
            }
            this.matrix[0][0] = 1;
            this.matrix[1][1] = 1;
		}

		this.rotate_matrix = function (a, b, angle) { // rotates cube inside plane ab
        	angle *= 3.1415926535 / 180;
            var c = Math.cos(angle),
                s = Math.sin(angle);

            var rot_m = function (x, y) { // sparse rotational matrix
                if (x == a) {
                    if (y == a) return c;
                    if (y == b) return -s;
                };
                if (x == b) {
                    if (y == a) return s;
                    if (y == b) return c;
                };
                return 0;
            };
            console.log(this.matrix);

            var new_matrix = [];
            for(var row = 0; row < 2; row ++) {
                new_matrix[row] = [];
                for(var i = 0; i < DIMENSIONS; i++) {
                    var res = 0;
                    for(var j = 0; j < DIMENSIONS; j++) {
                        res += this.matrix[row][j] * rot_m(j, i);
                    }
                    new_matrix[row][i] = res;
                }
                console.log(new_matrix[row]);
            };
            console.log('');
            this.matrix = new_matrix;

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
