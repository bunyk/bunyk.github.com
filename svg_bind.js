define(['jquery'], function($) {
	var Point = function (x, y) {
		this._x = x;
		this._y = y;
		Object.defineProperty(this, 'x', {
			configurable: true,
			get: function () { return this._x },
			set: function (value) {
                this._x = value;
                this.onMoveX(); 
            }
		})
		Object.defineProperty(this, 'y', {
			configurable: true,
			get: function () { return this._y },
			set: function (value) {
                this._y = value;
                this.onMoveY();
            }
		})
	};
	Point.prototype.onMoveX = function () {};
	Point.prototype.onMoveY = function () {};

	var Line = function (svg, a, b) {
		this.a = a;
		this.b = b;
		this.element = document.createElementNS('http://www.w3.org/2000/svg','line');
		this.element.setAttribute('style', 'stroke:rgb(0,0,0);stroke-width:2');
		this.element.setAttribute('x1', svg.x(this.a.x));
		this.element.setAttribute('y1', svg.y(this.a.y));
		this.element.setAttribute('x2', svg.x(this.b.x));
		this.element.setAttribute('y2', svg.y(this.b.y));

        that_a_mx = this.a.onMoveX.bind(this);
		this.a.onMoveX = (function () {
            this.element.setAttribute('x1', svg.x(this.a.x));
            //that_a_mx();
        }).bind(this);

        that_a_my = this.a.onMoveY.bind(this);
		this.a.onMoveY = (function () {
            this.element.setAttribute('y1', svg.y(this.a.y));
            //that_a_my();
        }).bind(this);

        that_b_mx = this.b.onMoveX.bind(this);
		this.b.onMoveX = (function () {
            this.element.setAttribute('x2', svg.x(this.b.x));
            //that_b_mx();
        }).bind(this);
        that_b_my = this.b.onMoveY.bind(this);
		this.b.onMoveY = (function () {
            this.element.setAttribute('y2', svg.y(this.b.y));
            //that_b_my();
        }).bind(this);

		svg.$element.append(this.element);
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
		return (val + 1) * this.width / 2.0;
	};
	SVG.prototype.y = function (val) {
		return (val + 1) * this.height / 2.0;
	};

    return {
        'SVG': SVG,
        'Point': Point
    };
});
