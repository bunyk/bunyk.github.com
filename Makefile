html:
	python3 render_mako.py todo/index.mako 
	python3 render_mako.py index.mako 
	python3 render_mako.py test.mako 
	python3 render_mako.py deutsch/index.mako 
	python3 render_mako.py deutsch/unendliche_geschichte.mako
	python3 render_mako.py hypercube/index.mako 
	python3 render_mako.py resume/index.mako 
love:
	python -m SimpleHTTPServer 8080
test:
	python test.py
