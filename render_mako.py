import argparse
import sys

from mako.template import Template
from mako.lookup import TemplateLookup

import markupsafe

def main():
    args = sys.argv
    if(len(args) < 2):
        print('You should pass template name')

    if(args[1]) == '-l': # local
        local = True
        args.pop(1)
    else:
        local = False

    render(args[1], args[2:] or ['.'], local)

class literal(markupsafe.Markup):
    # https://bitbucket.org/bbangert/webhelpers/src/527e244cc5fa966f88826df5a94ba7a37b86f252/webhelpers/html/builder.py?at=trunk#cl-171
    __slots__ = ()

    @classmethod
    def escape(cls, s):
        if s is None:
            return EMPTY
        return super(literal, cls).escape(s)

helpers = lambda : 1
helpers.literal = literal

template_params = {
    'input_encoding': 'utf-8',
    'default_filters': ['h'],
}
def render(filename, lookup=['.'], local=False):
    print('Rendering %s' % filename)
    if not filename.endswith('.mako'):
        raise ValueError('Template file should be .mako file!')
    lookup = TemplateLookup(directories=lookup, **template_params)
    template = Template(filename=filename, lookup=lookup, **template_params)

    filename = filename[:-len('.mako')]
    with open(filename + '.html', 'w', newline='\n', encoding='utf-8') as f:
        current_location = '/' + filename
        if current_location.endswith('index'):
            current_location = current_location[:-len('index')]
        else:
            current_location += '.html'
        html = template.render(
            filename=filename,
            local_externals=local,
            current_location=current_location,
            h=helpers,
        )
        print('Writing html to %s' % f.name)
        f.write(html.replace('\r\n', '\n').strip())

if __name__ == '__main__':
    main()
