import os
import unittest
import io
from functools import reduce

def patch_open(module, filesystem):
    '''
        Patches function open() in module in such way,
        that it opens files set as strings in filesystem dictionary
    '''
    def open_patch(filename):
        return io.StringIO(reduce(
            lambda d, k: d[k], 
            filename.split('/'),
            filesystem
        ))
    module.open = open_patch

class TestPatchOpen(unittest.TestCase):
    def test_opens(self):
        m = lambda: 0
        patch_open(m, {
            'directory': {
                'file.txt': 'hello!',
            },
        })
        self.assertEqual(m.open('directory/file.txt').read(), 'hello!')
class TestAbsolute(unittest.TestCase):
    def test_caller_sibling(self):
        from requirejs import absolute
        self.assertEqual(
            absolute(
                'script.js',
                '/home/user/project/module/',
                '/home/user/project',
            ),
            '/home/user/project/module/script.js'
        )

    def test_in_caller_parent(self):
        from requirejs import absolute
        self.assertEqual(
            absolute(
                '../script.js',
                '/home/user/project/module/',
                '/home/user/project',
            ),
            '/home/user/project/script.js'
        )

    def test_in_project_root(self):
        from requirejs import absolute
        self.assertEqual(
            absolute(
                '/script.js',
                '/home/user/project/module/',
                '/home/user/project/',
            ),
            '/home/user/project/script.js'
        )

    def test_in_project_subfolder_absolute(self):
        from requirejs import absolute
        self.assertEqual(
            absolute(
                '/assets/script.js',
                '/home/user/project/module/',
                '/home/user/project',
            ),
            '/home/user/project/assets/script.js'
        )

    def test_relative_subfolder(self):
        from requirejs import absolute
        self.assertEqual(
            absolute(
                'assets/script.js',
                '/home/user/project/module/',
                '/home/user/project',
            ),
            '/home/user/project/module/assets/script.js'
        )

class TestRequireJS(unittest.TestCase):
    def test_asset_type(self):
        from requirejs import file_type
        self.assertEqual(file_type('main.js'), 'js')
        self.assertEqual(file_type('jquery.min.js'), 'js')
        self.assertEqual(file_type('example.coffee'), 'coffee')

    def test_requirements(self):
        import requirejs
        patch_open(requirejs, {
            '': { # filesystem root
                'project': {
                    'main.coffee': '# REQUIRE jquery\n'
                                   '# REQUIRE module.coffee\n'
                                   '# REQUIRE /deeper/module.coffee\n',
                }
            }
        })

        self.assertEqual(
            list(requirejs.requirements(
                '/project/main.coffee', 
                '/project/', 
            )), [
                'jquery',
                '/project/module.coffee',
                '/project/deeper/module.coffee',
            ]
        )

    def test_topo_sort(self):
        from requirejs import topo_sort
        self.assertEqual(
                topo_sort({
                    'a': [],
                    'b': ['a', 'c'],
                    'c': ['a']
                }),
                ['a', 'c', 'b']
            )

if __name__ == '__main__':
    unittest.main()
