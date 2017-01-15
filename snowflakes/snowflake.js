var byId = document.getElementById.bind(document);
var display = byId('display');
var svg = byId('canvas');
var lines = byId('lines');
var cursor = byId('cursor');
var svgPolyline;

var isTouchDevice = 'ontouchstart' in window;

SVGElement.prototype.getTransformToElement = SVGElement.prototype.getTransformToElement || function(toElement) {
    return toElement.getScreenCTM().inverse().multiply(this.getScreenCTM());
};
// http://phrogz.net/svg/drag_under_transformation.xhtml

if(isTouchDevice) {
    svg.addEventListener("touchstart", startDrawing, false);
    svg.addEventListener("touchmove", continueDrawing, false);
    svg.addEventListener("touchend", endDrawing, false);
} else {
    svg.addEventListener("mousedown", startDrawing)
    svg.addEventListener("mousemove", continueDrawing);
    svg.addEventListener("mouseup", endDrawing);
}

byId('clearBtn').addEventListener('click', function() {
    while(lines.lastChild) {
        lines.removeChild(lines.lastChild);
    }
});
byId('showReference').addEventListener('change', toggleReference);
byId('mirrorCheck').addEventListener('change', toggleMirror);


function startDrawing(event) {
    svgPolyline = createSvgElement("polyline");
    svgPolyline.setAttribute("fill", "none");
    svgPolyline.setAttribute("shape-rendering", "geometricPrecision");
    svgPolyline.setAttribute("stroke-linejoin", "round");
    svgPolyline.setAttribute("stroke", byId('color').value);
    svgPolyline.setAttribute("stroke-width", byId('penWidth').value)

    lines.appendChild(svgPolyline);
    continueDrawing(event);
}

var TOOLBAR_HEIGHT = 50;

function continueDrawing(event) {
    var touch, x, y;
      
    var pt = svg.createSVGPoint();
    if(event.changedTouches) {
        touch = event.changedTouches[0];
        pt.x = touch.clientX;
        pt.y = touch.clientY;
    } else {
        pt.x = event.offsetX;
        pt.y = event.offsetY + TOOLBAR_HEIGHT;
    }
    var globalPoint = pt.matrixTransform(svg.getScreenCTM().inverse());
    var globalToLocal = lines.getTransformToElement(svg).inverse();
    var inObjectSpace = globalPoint.matrixTransform( globalToLocal );
    x = inObjectSpace.x;
    y = inObjectSpace.y;

    cursor.setAttribute('cx', x);
    cursor.setAttribute('cy', y)
    if (svgPolyline) {
        var point = svgPolyline.ownerSVGElement.createSVGPoint();
        point.x = x;
        point.y = y;
        svgPolyline.points.appendItem(point);
    }
}

function changeCursor() {
    cursor.setAttribute('fill', byId('color').value);
    cursor.setAttribute('r', byId('penWidth').value / 2);
}
function endDrawing(event) {
    continueDrawing(event);
    svgPolyline = null;
}

function toggleReference(event) {
    byId('referenceLine').setAttribute(
        'visibility', event.srcElement.checked ? 'visible': 'hidden'
    );
}
function toggleMirror(event) {
    var visibility = event.srcElement.checked ? 'visible': 'hidden';
    byId('mirrored').setAttribute('visibility', visibility);
}

function createSvgElement(tagName) {
    return document.createElementNS("http://www.w3.org/2000/svg", tagName);
}


navigator.serviceWorker && navigator.serviceWorker.register('sw.js').then(function(registration) {
  console.log('Excellent, registered with scope: ', registration.scope);
});
