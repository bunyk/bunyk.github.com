'''
Python script for JavaScript and coffescript assets management.
'''

import os
import subprocess
import re

included = set()

def include(asset, from_file, root):
    '''
        Returns a set of <script src="... tags for asset with dependencies.
        from_file - file from which asset is included
        root - root of the project
    '''
    root = os.path.abspath(root)
    dir = os.path.abspath(os.path.dirname(from_file))
    asset = absolute(asset, dir, root)
    if (asset, from_file) in included:
        print('"{}" already included in {}'.format(asset, from_file))
        return
    included.add((asset, from_file))
        
    return '\n'.join(
        get_tag(coffee2js(src), root)
        for src in topo_sort(get_graph(asset, root))
    )

def get_tag(src, root):
    if not external(src):
        assert src.startswith(root)
        src = src[len(root):]
    return '<script type="text/javascript" src="%s"></script>' % src

def coffee2js(asset):
    if file_type(asset) == 'coffee':
        js = asset[:-len('coffee')] + 'js'
        if os.path.exists(js) and os.path.getmtime(asset) <= os.path.getmtime(js):
            print('%s is up to date' % js)
            return js
        print('Compiling %s' % asset)
        subprocess.call(['coffee', '-c', asset])
        return js
    elif file_type(asset) == 'js':
        return asset
    else:
        raise ValueError('Unknown file type: .%s' % tp)

def file_type(filename):
    return filename.rsplit('.', 1)[1]

def external(asset):
    return asset.startswith('http://')

def absolute(filename, path, root):
    ''' filename - path to the requirement
            absolute from root of project or 
            relative to dir found in
        dir - absolute path to directory of file which require the requirement
        root - absolute path to root of the project
    '''
    if external(filename):
        return filename # don't touch URLs
    j = lambda a, b: os.path.normpath(os.path.join(a, b))
    if filename.startswith('/'):
        return j(root, filename[1:])
    else:
        return j(path, filename)

def requirements(asset, root):
    '''
        asset - absolute path,
        root - absolute path of root of project
        returns list of absolute paths.
    '''
    if external(asset):
        return # assume external libs have no requirements
    tp = file_type(asset)
    try:
        requirement_re = re.compile({
            'js': '^// REQUIRE\s+(.+)$',
            'coffee':'^# REQUIRE\s+(.+)$'
        }[tp])
    except KeyError:
        raise ValueError('Unknown file type: .%s' % tp)

    dir = os.path.dirname(asset)

    with open(asset) as f:
        for line in f:
            m = requirement_re.match(line)
            if m:
                yield absolute(m.group(1), dir, root)


def get_graph(asset, root):
    res = {}

    def visit(asset):
        if asset in res:
            return
        reqs = list(requirements(asset, root))
        res[asset] = reqs
        for r in reqs:
            visit(r)
    visit(asset)
    return res


def topo_sort(graph):
    '''
        Input - dictionary of dependencies
        Output - properly ordered list of dependencies
        or exception when found a cycle
    '''
    res = []
    marks = { k: None for k in graph.keys() }
    def unmarked():
        for k, v in marks.items():
            if v is None:
                return k

    def visit(n):
        if marks[n] == 'temp':
            raise ValueError('Not a DAG')
        if marks[n] is None:
            marks[n] = 'temp'
            for m in graph[n]:
                visit(m)
            marks[n] = 'perm'
            res.append(n)

    while True:
        n = unmarked()
        if not n:
            break
        visit(n)
    return res

