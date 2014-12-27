all: html love
love:
	python3.3 -m http.server 8080
test:
	python3.3 test.py

load:
	mkdir -p external_assets
	python3.3 requirejs.py

html: index_html deutsch_html resume_html hypercube_html canvas_html fifteen_html

index_html:
	python3.3 render_mako.py index.mako 
	python3.3 render_mako.py test.mako 

deutsch_html:
	python3.3 render_mako.py deutsch/index.mako 

resume_html: 
	python3.3 render_mako.py resume/index.mako 

hypercube_html:
	python3.3 render_mako.py hypercube/index.mako 

canvas_html:
	python3.3 render_mako.py canvas/index.mako

fifteen_html:
	python3.3 render_mako.py fifteen/index.mako

dodecahedron_html:
	python3.3 render_mako.py dodecahedron/index.mako

d: dodecahedron_html love
