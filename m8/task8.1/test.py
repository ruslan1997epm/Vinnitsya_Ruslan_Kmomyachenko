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
