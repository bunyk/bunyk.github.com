from zope.interface import Interface, implements
from zope.component import getUtility
 
class IOperation(Interface):
    def __call__(a, b):
        ''' performs operation on two operands '''
 
class Plus(object):
    implements(IOperation)
    def __call__(self, a, b):
        return a + b
plus = Plus()
 
class Minus(object):
    implements(IOperation)
    def __call__(self, a, b):
        return a - b
minus = Minus()
 
