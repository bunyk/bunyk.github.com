python = python3.4
all: html love
love:
	$(python) -m http.server 8080
test:
	$(python) test.py

load:
	mkdir -p external_assets
	$(python) requirejs.py

html: index_html deutsch_html resume_html hypercube_html canvas_html fifteen_html

index_html:
	$(python) render_mako.py index.mako 
	$(python) render_mako.py test.mako 

deutsch_html:
	$(python) render_mako.py deutsch/index.mako 

resume_html: 
	$(python) render_mako.py resume/index.mako 

hypercube_html:
	$(python) render_mako.py hypercube/index.mako 

canvas_html:
	$(python) render_mako.py canvas/index.mako

fifteen_html:
	$(python) render_mako.py fifteen/index.mako

dodecahedron_html:
	$(python) render_mako.py dodecahedron/index.mako

d: dodecahedron_html love
