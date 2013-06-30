"use strict";

define(['matrix', 'hypercube'], function(matrix, hypercube) {
    var run = function () {
        module("Matrix tests");
        var Matrix = matrix.Matrix;
        test("Zero filled matrix can be created", function() {
            var m = new Matrix(2, 2);
            deepEqual(m.data, [[0, 0], [0, 0]]);
        });
        test("Mutiplication to identity matrix", function() {
            var a = new Matrix(2, 2, [[1, 2], [3, 4]]),
                b = new Matrix(2, 2, [[1, 0], [0, 1]]);
            deepEqual(a.data, a.mult(b).data);
            deepEqual(a.data, b.mult(a).data);
        });
        test("180 degree rotation of 2d vector", function() {
            var a = new Matrix(2, 1, [[1, 2]]),
                b = new Matrix(2, 2, [[-1, 0], [0, -1]]); 
            deepEqual(a.mult(b).data, [[-1, -2]]);
        });
        test("Mutliplicating of random matrices", function() {
            var a = new Matrix(3, 2, [[1, 2, 3], [4, 5, 6]]),
                b = new Matrix(2, 3, [[1, 2], [3, 4], [5, 6]]),
                c = a.mult(b);
            deepEqual(c.data, [[22, 28], [49, 64]]);
        });
    };
    return {run: run};
});
