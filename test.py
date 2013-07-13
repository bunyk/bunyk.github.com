import os
import unittest

from requirejs import *

class TestAbsolute(unittest.TestCase):
    def test_caller_sibling(self):
        self.assertEquals(
            absolute(
                'script.js',
                '/home/user/project/module/',
                '/home/user/project',
            ),
            '/home/user/project/module/script.js'
        )

    def test_in_caller_parent(self):
        self.assertEquals(
            absolute(
                '../script.js',
                '/home/user/project/module/',
                '/home/user/project',
            ),
            '/home/user/project/script.js'
        )

    def test_in_project_root(self):
        self.assertEquals(
            absolute(
                '/script.js',
                '/home/user/project/module/',
                '/home/user/project/',
            ),
            '/home/user/project/script.js'
        )

    def test_in_project_subfolder_absolute(self):
        self.assertEquals(
            absolute(
                '/assets/script.js',
                '/home/user/project/module/',
                '/home/user/project',
            ),
            '/home/user/project/assets/script.js'
        )

    def test_relative_subfolder(self):
        self.assertEquals(
            absolute(
                'assets/script.js',
                '/home/user/project/module/',
                '/home/user/project',
            ),
            '/home/user/project/module/assets/script.js'
        )

class TestRequireJS(unittest.TestCase):
    def test_include(self):
        self.assertEqual(
            include(
                '/deutsch/main.coffee', 
                './deutsch/',
                '.', 
            ),
            ''
        )

    def test_asset_type(self):
        self.assertEqual(file_type('main.js'), 'js')
        self.assertEqual(file_type('jquery.min.js'), 'js')
        self.assertEqual(file_type('example.coffee'), 'coffee')

    def test_requirements(self):
        self.assertEqual(
            list(requirements(
                '/home/bunyk/bunyk.github.com/deutsch/main.coffee', 
                '/home/bunyk/bunyk.github.com/', 
            )), [
                '/home/bunyk/bunyk.github.com/jslibs/jquery-2.0.2.min.js',
                '/home/bunyk/bunyk.github.com/deutsch/exercises.coffee'
            ]
        )

    def test_topo_sort(self):
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
