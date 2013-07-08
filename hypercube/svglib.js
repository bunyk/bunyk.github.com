// REQUIRE /jslibs/jquery-2.0.2.min.js
// REQUIRE /jslibs/radio.min.js

(function() {
	var Point = function (x, y) {
		this._x = x;
		this._y = y;
		Object.defineProperty(this, 'x', {
			configurable: true,
			get: function () { return this._x },
			set: function (value) {
                this._x = value;
                radio('move_x').broadcast(this);
            }
		})
		Object.defineProperty(this, 'y', {
			configurable: true,
			get: function () { return this._y },
			set: function (value) {
                this._y = value;
                radio('move_y').broadcast(this);
            }
		})
	};
	Point.prototype.onMoveX = function (cb) {
        var that = this;
        radio('move_x').subscribe(function(point) {
            if(point == that) cb();
        });
    };
	Point.prototype.onMoveY = function (cb) {
        var that = this;
        radio('move_y').subscribe(function(point) {
            if(point == that) cb();
        });
    };

	var Line = function (svg, a, b) {
		this.a = a;
		this.b = b;
		this.element = document.createElementNS('http://www.w3.org/2000/svg','line');
		this.element.setAttribute('style', 'stroke:rgb(0,0,0);stroke-width:2');
		this.element.setAttribute('x1', svg.x(this.a.x));
		this.element.setAttribute('y1', svg.y(this.a.y));
		this.element.setAttribute('x2', svg.x(this.b.x));
		this.element.setAttribute('y2', svg.y(this.b.y));

        var that = this;

        this.a.onMoveX(function() {
            that.element.setAttribute('x1', svg.x(that.a.x));
        });
        this.a.onMoveY(function() {
            that.element.setAttribute('y1', svg.y(that.a.y));
        });
        this.b.onMoveX(function() {
            that.element.setAttribute('x2', svg.x(that.b.x));
        });
        this.b.onMoveY(function() {
            that.element.setAttribute('y2', svg.y(that.b.y));
        });

		svg.$element.append(this.element);
	};

	var SVG = function (selector, width, height, a) {
        this.a = a || 2.0; // default side of square is 2, from -1 to 1
		this.width = width;
		this.height = height;
		this.$element = $('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" ' + 
			'height="' + height + '" width="' + width + '">'
			+ '</svg>'
		);
		$(selector).append(this.$element);
	};
    SVG.prototype.clear = function () {
        this.$element.html('');
    };
	SVG.prototype.line4 = function(ax, ay, bx, by) {
		return this.line2(new Point(ax, ay), new Point(bx, by));
	};
	SVG.prototype.line2 = function(a, b) {
		return new Line(this, a, b);
	};
    SVG.prototype.line = function() {
        if(arguments.length == 2)
            return this.line2.apply(this, arguments);
        if(arguments.length == 4)
            return this.line4.apply(this, arguments);
    };
	SVG.prototype.x = function (val) {
		return (val / this.a + 0.5) * this.width;
	};
	SVG.prototype.y = function (val) {
		return (val / this.a + 0.5) * this.height;
	};

    window.svglib = {
        'SVG': SVG,
        'Point': Point
    };
}());
