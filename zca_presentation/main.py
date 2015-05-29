# We should additionally install zope.configuration
from zope.configuration import xmlconfig
  
def eval(expr):
    a, op, b = expr.split()
    return getUtility(IOperation, op)(float(a), float(b))
  
def main():
    xmlconfig.file('configure.zcml') # it will import every needed component
  
    assert eval('2 + 2') == 4
    assert eval('2 - 2') == 0
  
if __name__ == '__main__':
    main()
