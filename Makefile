all: html love
love:
	python3.3 -m http.server 8080
test:
	python3.3 test.py

load:
	mkdir -p external_assets
	python3.3 requirejs.py

html: drawing_html index_html backbone deutsch_html resume hypercube_html
drawing_html:
	python3.3 render_mako.py drawing/index.mako 
index_html:
	python3.3 render_mako.py index.mako 
	python3.3 render_mako.py test.mako 
backbone: 
	python3.3 render_mako.py todo/index.mako 
	python3.3 render_mako.py todo/home_bi.mako 
deutsch_html:
	python3.3 render_mako.py deutsch/index.mako 
	python3.3 render_mako.py deutsch/unendliche_geschichte.mako
resume: 
	python3.3 render_mako.py resume/index.mako 
hypercube_html:
	python3.3 render_mako.py hypercube/index.mako 
