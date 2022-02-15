Code of main.py
```
import math

def validate_params():
    attempts = 3
    while attempts > 0:
        try:
            print(f'You have {attempts} attempts')
            a = int(input('Enter value for a: '))
            b = int(input('Enter value for b: '))
            c = int(input('Enter value for c: '))
        except ValueError:
            print("Value is not integer")
            attempts -=1
            continue
        else:
            return a, b, c

def discriminant(a, b, c):
    discr = b**2 - 4*a*c
    return discr

def roots(discr, a, b, c):
    if discr > 0:
        x1 = (-b + math.sqrt(discr)) / (2 * a)
        x2 = (-b - math.sqrt(discr)) / (2 * a)
        print("x1 =  x2 = ", (x1, x2))
        return x1, x2
    elif discr == 0:
        x = -b / (2 * a)
        print("x = ", x)
        return x
    else:
        print("Equation has no roots")

def solv_square(a, b, c) -> roots:
    discr = discriminant(a, b, c)
    root = roots(discr, a, b, c)
    print("Discriminant = ", discr)
    return root

def square_print(a, b, c, roots):
    print("a =", a)
    print("b = ", b)
    print("c = ", c)
    roots

def main():
    print("Please enter values:")
    valid_params = validate_params()
    a = valid_params[0]
    b = valid_params[1]
    c = valid_params[2]
    solv_square(a, b, c)
    square_print(a, b, c, roots)

if __name__=="__main__":
    main()
```
 Code of UnitTest
 
 ```
 import unittest
import main

class MyTestCase(unittest.TestCase):
    def test_discriminant(self):
        self.assertEqual(main.discriminant(2, 20, 3), 376)  # add assertion here

    def test_solv_square(self):
        self.assertEqual(main.solv_square(2, 20, 3), (-0.15232014258367066, -9.84767985741633) )

    def test_roots(self):
        self.assertEqual(main.roots(376, 2, 20, 3), (-0.15232014258367066, -9.84767985741633))
if __name__ == '__main__':
    unittest.main()
 
 ```
 
    
