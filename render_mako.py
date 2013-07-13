import sys

from mako.template import Template
from mako.lookup import TemplateLookup

def render(filename, lookup=['.']):
    print('Rendering %s' % filename)
    if not filename.endswith('.mako'):
        raise ValueError('Template file should be .mako file!')
    lookup = TemplateLookup(directories=lookup, input_encoding='utf-8')
    template = Template(filename=filename, lookup=lookup, input_encoding='utf-8')

    filename = filename[:-len('.mako')]
    with open(filename + '.html', 'w', newline='\n', encoding='utf-8') as f:
        current_location = '/' + filename
        if current_location.endswith('index'):
            current_location = current_location[:-len('index')]
        else:
            current_location += '.html'
        html = template.render(
            filename=filename,
            current_location=current_location,
        )
        print('Writing html to %s' % f.name)
        f.write(html.replace('\r\n', '\n').strip())

if __name__ == '__main__':
    if(len(sys.argv) < 2):
        print('You should pass template name')

    render(sys.argv[1], sys.argv[2:] or ['.'])
