from math import sin, pi
from functools import partial

import shapefile

#sf = shapefile.Reader('Ukraine/UKR_adm2.shp')
sf = shapefile.Reader('USA/USA_adm1.shp')
shapes = sf.shapes()

def rad(a):
    return a * pi / 180

def project(latlng, bbox):
    lat, lng = latlng
    lat0, lng0, lat1, lng1 = bbox

    x = (lng - lng0) / (lng1 - lng0)
    lat_c = (lat0 + lat1) / 2
    y_c= sin(rad(lat - lat_c))
    y0 = sin(rad(lat0 - lat_c))
    y1 = sin(rad(lat1 - lat_c))
    y = (y_c - y0) / (y1 - y0)
    return y, 1 - x # don't really know why not x, y


WIDTH = 1500
HEIGHT = WIDTH / abs(sf.bbox[0] - sf.bbox[2]) * abs(sf.bbox[1] - sf.bbox[3])

def polygon(points):
    return '<path d="M%s" style="fill:none;stroke:black;stroke-width:1"/>' % (
        ' L'.join('%s %s' % (
            round(x * WIDTH),
            round(y * HEIGHT),
        ) for x, y in points)
    )


print('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="%s" height="%s">' % (WIDTH, HEIGHT))
for shape in sf.shapes():
    print(polygon(map(lambda c: project(c, sf.bbox), shape.points)))
print('</svg>')
