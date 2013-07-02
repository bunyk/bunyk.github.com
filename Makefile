html:
	python3 render_mako.py resume/index.mako 
	python3 render_mako.py hypercube/index.mako 
	python3 render_mako.py deutsch/index.mako 
	python3 render_mako.py index.mako 

love:
	python -m SimpleHTTPServer 8080
