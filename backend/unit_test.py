import unittest
from core_system import app, load_plugins

class CoreSystemTestCase(unittest.TestCase):
    def setUp(self):
        # Set up the test client
        self.app = app.test_client()
        self.app.testing = True
        # Load plugins
        load_plugins()

    def test_index(self):
        # Test the index route
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        data = response.get_json()
        self.assertIn('message', data)
        self.assertIn('plugins', data)

    def test_pay(self):
        # Test the pay route with valid data
        response = self.app.post('/pay', json={"amount": 100, "currency": "USD"})
        self.assertEqual(response.status_code, 200)
        data = response.get_json()
        self.assertEqual(data['status'], 'success')
        self.assertIn('transaction_id', data)

        # Test the pay route without the payment plugin
        # Temporarily remove the payment plugin
        del app.core_system['payment']
        response = self.app.post('/pay', json={"amount": 100, "currency": "USD"})
        self.assertEqual(response.status_code, 400)
        data = response.get_json()
        self.assertEqual(data['error'], 'Payment plugin not available')

if __name__ == '__main__':
    unittest.main()