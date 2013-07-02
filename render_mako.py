import sys

from mako.template import Template
from mako.lookup import TemplateLookup

def render(filename):
    if not filename.endswith('.mako'):
        raise ValueError('Template file should be .mako file!')
    lookup = TemplateLookup(directories=['.'], input_encoding='utf-8')
    template = Template(filename=filename, lookup=lookup, input_encoding='utf-8')
    filename = filename[:-len('.mako')]

    with open(filename + '.html', 'w') as f:
        f.write(template.render())

if __name__ == '__main__':
    if(len(sys.argv) < 2):
        print('You should pass template name')
    render(sys.argv[1])
