def get_indent(line):
    for i, c in enumerate(line.replace('\t', '    '):
        if c !=

def parse_tree(text):
    lines = (line for line in text.splitlines() if line.strip())

    # intialize a stack
    # push first line to stack
    stack = [{
        'name': None,
        'children': [],
        'indent': -1
    }]

    for line in lines:
        s1 = stack[-1]
        s2 = {
            'name': 
        }
         S1 = top of stack // do not pop off yet
         S2 = read a line
         if depth of S1 < depth of S2 {
          add S2 as child of S1
          push S2 into stack
         }
         else {
          while (depth of S1 >= depth of S2 AND there are at least 2 elements in stack) {
           pop stack
           S1 = top of stack // do not pop
          }
          add S2 as child of S1
          push S2 into stack
         }
        }
return bottom element of stack

assert parse_tree(
'''
a
    aa
    ab
b
    ba
        baa
''') == {
    'name': None,
    'children': [
        {
            'name': 'a',
            'children': [
                {
                    'name': 'aa',
                    'children': [],
                },
                {
                    'name': 'ab',
                    'children': [],
                },
            ]
        },
        {
            'name': 'b',
            'children': [
                {
                    'name': 'ba',
                    'children': [
                        {
                            'name': 'baa',
                            'children': [],
                        },
                    ],
                },
            ]
        },
    ]
}
