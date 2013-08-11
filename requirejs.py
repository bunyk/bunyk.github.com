'''
Python script for JavaScript and coffescript assets management.
'''

import os
import subprocess
import re

import logging 
log = logging.getLogger(__name__)

import external_assets

def main():
    load_assets()

def load_assets():
    import requests
    for asset in dir(external_assets):
        if asset[0] == '_': continue
        url = getattr(external_assets, asset)
        r = requests.get(url)
        print(r.status_code, asset, url)
        if r.status_code == 200:
            with open('external_assets/%s' % asset, 'w') as f:
                f.write(r.text)

included = set()

def include(asset, from_file, root, local=False):
    '''
        Returns a set of <script src="... tags for asset with dependencies.
        from_file - file from which asset is included
        root - root of the project
        local - if true, than link external libs from external_assets folder
    '''
    root = os.path.abspath(root)
    dir = os.path.abspath(os.path.dirname(from_file))
    asset = absolute(asset, dir, root)

    def once(src):
        if (src, from_file) in included:
            return False
        else:
            included.add((src, from_file))
            return True

    return (
        '\n<!-- include("{}") -->\n'.format(asset)
        + '\n'.join(
            get_tag(coffee2js(src, local), root, local)
            for src in topo_sort(get_graph(asset, root))
            if once(src)
        )
    )

def get_tag(src, root, local=False):
    if not external(src):
        assert src.startswith(root)
        src = src[len(root):]
    elif local:
        src = '/external_assets/%s' % src
    return '<script type="text/javascript" src="%s"></script>' % src

def coffee2js(asset, local=False):
    ft = file_type(asset)
    if ft == 'coffee':
        js = asset[:-len('coffee')] + 'js'
        if os.path.exists(js) and os.path.getmtime(asset) <= os.path.getmtime(js):
            log.info('%s is up to date' % js)
            return js
        log.info('Compiling %s' % asset)
        subprocess.call(['coffee', '-c', asset])
        return js
    elif ft == 'js':
        return asset
    elif ft is None:
        if external(asset):
            return asset if local else external_assets.__dict__[asset]
        raise ValueError('Asset "%s" is not found in external_assets.py' % asset)
    else:
        raise ValueError('Unknown file type: .%s' % tp)

def file_type(filename):
    try:
        return filename.rsplit('.', 1)[1]
    except IndexError:
        return None

def external(asset):
    return (
        asset.startswith('http://')
        or asset.startswith('https://')
        or asset in external_assets.__dict__
    )

def absolute(filename, path, root):
    ''' filename - path to the requirement
            absolute from root of project or 
            relative to dir found in
        dir - absolute path to directory of file which require the requirement
        root - absolute path to root of the project
    '''
    if external(filename):
        return filename
    j = lambda a, b: os.path.normpath(os.path.join(a, b))
    if filename.startswith('/'):
        return j(root, filename[1:])
    else:
        return j(path, filename)

def requirements(asset, root):
    '''
        asset - absolute path of asset which requires other,
        root - absolute path of root of project
        returns list of absolute paths to required assets.
    '''
    if external(asset):
        if asset not in external_assets._dependencies:
            return
        for r in external_assets._dependencies[asset]:
            yield r
        return

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
    marks = { k: None for k in graph.keys() } # all unvisited

    def unvisited():
        ''' Return first unvisited node or None '''
        for k, v in marks.items():
            if v is None:
                return k

    def visit(n):
        if marks[n] == 'temp':
            raise ValueError('Found a circular dependency in "%s"' % n)
        if marks[n] is None:
            marks[n] = 'temp'
            for m in graph[n]:
                visit(m)
            marks[n] = 'perm'
            res.append(n)

    while True:
        n = unvisited()
        if n is None:
            break
        visit(n)
    return res

if __name__ == '__main__':
    main()
