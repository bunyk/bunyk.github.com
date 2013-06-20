(function($){
	// SVG drawing lib
	var Point = function (x, y) {
		this._x = x;
		this._y = y;
		Object.defineProperty(this, 'x', {
			configurable: true,
			get: function () { return this._x },
			set: function (value) { this._x = value; this.onMove(); }
		})
		Object.defineProperty(this, 'y', {
			configurable: true,
			get: function () { return this._y },
			set: function (value) { this._y = value; this.onMove(); }
		})
	};
	Point.prototype.onMove = function () {};

	var Line = function (container, a, b) {
		this.a = a;
		this.b = b;
		//this.$element = $('<line style="stroke:rgb(0,0,0);stroke-width:2"/>');
		this.element = document.createElementNS('http://www.w3.org/2000/svg','line');
		this.element.setAttribute('style', 'stroke:rgb(0,0,0);stroke-width:2');
		this.update();
		container.append(this.element);
		this.a.onMove = this.update.bind(this);
		this.b.onMove = this.update.bind(this);
	};
	Line.prototype.onChange = function () {};
	Line.prototype.update = function () {
		this.element.setAttribute('x1', this.a.x);
		this.element.setAttribute('y1', this.a.y);
		this.element.setAttribute('x2', this.b.x);
		this.element.setAttribute('y2', this.b.y);
		this.onChange();
	};

	var SVG = function (selector, width, height) {
		this.width = width;
		this.height = height;
		this.$element = $('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" ' + 
			'height="' + height + '" width="' + width + '">'
			+ '</svg>'
		);
		$(selector).append(this.$element);
	};
	SVG.prototype.line = function(ax, ay, bx, by) {
		return new Line(this.$element, new Point(ax, ay), new Point(bx, by));
	};
	SVG.prototype.x = function (val) {
		return (val + 1) * this.width / 2.0;
	};
	SVG.prototype.y = function (val) {
		return (val + 1) * this.height / 2.0;
	};

	// Hypercube lib
	var Hypercube = function (DIMENSIONS) {
		VERTEXES = 1 << DIMENSIONS;
		EDGES = DIMENSIONS * (1 << (DIMENSIONS - 1));

		function genVertexBin(number, vertex) {
		// sets vertex value by its number
			for(var i = 0; i < DIMENSIONS; i++) {
				vertex[i] = (0.5 - (number & 1));
				number >>= 1;
			}
		}
		function Avertex(num) { // return number of first vertex of edge
    		var x = num >> (DIMENSIONS - 1);
    		num = num % (1 << (DIMENSIONS - 1));
    		var res = num % (1 << x);
    		num >>= x;
    		num <<= x + 1;
    		return res | num;
		}
		function Bvertex(num) { // return number of second vertex of edge
    		var x = num >> (DIMENSIONS - 1);
    		return Avertex(num) | (1 << x);
		}

		this.reset = function (svg) { // sets cube into orthogonal position
			this.svg = svg;
			this.vertexes = [];
			for(var i = 0; i < VERTEXES; i++) {
				this.vertexes[i] = [];
            	genVertexBin(i, this.vertexes[i]);
            }
            this.lines = [];
            for(var i = 0; i < EDGES; i++)
            {
            	this.lines[i] = svg.line(
            		svg.x(this.vertexes[Avertex(i)][0]),
            		svg.y(this.vertexes[Avertex(i)][1]),
            		svg.x(this.vertexes[Bvertex(i)][0]),
            		svg.y(this.vertexes[Bvertex(i)][1])
            	);
            }
		}
		cos = Math.cos;
		sin = Math.sin;
		this.rotate = function (a, b, angle) { // rotates cube inside plane ab
    		var x,y;
        	angle *= 3.1415926 / 180;
        	for(var i = 0; i < VERTEXES; i++)
        	{
            	x = this.vertexes[i][a] * cos(angle) - this.vertexes[i][b] * sin(angle);
                y = this.vertexes[i][a] * sin(angle) + this.vertexes[i][b] * cos(angle);
                console.log(x, y)
            	this.vertexes[i][a] = x;
            	this.vertexes[i][b] = y;
        	}
        	for(var i = 0; i < EDGES; i++)
            {
            	this.lines[i].a.x = this.svg.x(this.vertexes[Avertex(i)][0]);
            	this.lines[i].a.y = this.svg.y(this.vertexes[Avertex(i)][1]);
            	this.lines[i].b.x = this.svg.x(this.vertexes[Bvertex(i)][0]);
            	this.lines[i].b.y = this.svg.y(this.vertexes[Bvertex(i)][1]);
            }
    	};
	};


	$(function() {
		var svg = new SVG('#surface', 500, 500);
		var cube = new Hypercube(4);
		cube.reset(svg);
		cube.rotate(0,1,45);
		cube.rotate(2,1,45);
		cube.rotate(3,0,45);
		setInterval(function() { cube.rotate(3, 0, 2); cube.rotate(2, 1, 3);}, 50);
	});
})(jQuery);