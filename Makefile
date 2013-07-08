html:
	#python3 render_mako.py deutsch/index.mako 
	python3 render_mako.py hypercube/index.mako 
love:
	python -m SimpleHTTPServer 8080
test:
	python test.py
