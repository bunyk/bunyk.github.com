define([], function() {
    var Matrix = function(width, height, data, sparse) {
        if(typeof(data) === 'undefined')
            data = function() { return 0; };
        this.width = width;
        this.height = height;
        if(sparse) {
            this.indicator = data;
        } else { // sparse matrices don't use arrays, and are not mutable
            if(typeof(data) === 'function') {
                this.data = [];
                for(var i = 0; i < height; i++) {
                    this.data[i] = [];
                    for(var j = 0; j < width; j++) {
                        this.data[i][j] = data(j, i);
                    };
                };
            } else {
                this.data = data;
            };
        };
    };
    Matrix.prototype.indicator = function(x, y) {
       return this.data[y][x]; 
    };
    Matrix.prototype.set = function(x, y, value) {
        this.data[y][x] = value;
    };
    Matrix.prototype.html = function() {
        var html = ['<table class="matrix">'];
        for(var i = 0; i < this.height; i++) {
            html.push('<tr>');
            for(var j = 0; j < this.width; j++) {
                html.push('<td>' + this.data[i][j] + '</td>');
            };
            html.push('</tr>');
        };
        return html.join('');
    };
    Matrix.prototype.mult = function(other) {
        if (this.width != other.height) {
            console.log(this, other);
            throw "error: incompatible matrix sizes for multiplication";
        }
        var result = [];
        for (var i = 0; i < this.height; i++) {
            result[i] = [];
            for (var j = 0; j < other.width; j++) {
                var sum = 0;
                for (var k = 0; k < this.width; k++) {
                    sum += this.indicator(k, i) * other.indicator(j, k);
                }
                result[i][j] = sum;
            }
        }
        return new Matrix(other.width, this.height, result); 
    };
    return Matrix;
});
