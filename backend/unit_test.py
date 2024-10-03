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
        response = self.app.get('/pay_paypal')
        self.assertEqual(response.status_code, 200)
        data = response.get_json()
        self.assertEqual(data['status'], 'success')
        self.assertIn('transaction_type', data)

        # Test the pay route without the payment plugin
        # Temporarily remove the payment plugin
        del app.core_system['payment']
        response = self.app.get('/pay_paypal')
        self.assertEqual(response.status_code, 400)
        data = response.get_json()
        self.assertEqual(data['error'], 'Payment plugin not available')
    
    def test_fetch_ads(self):
        # Test the fetch_ads route with the ads plugin available
        response = self.app.get('/Fetch_ads')
        self.assertEqual(response.status_code, 200)
        data = response.get_json()
        self.assertEqual(data['status'], 'success')
        self.assertIn('ads', data)

        # Test the fetch_ads route without the ads plugin
        # Temporarily remove the ads plugin
        del app.core_system['ads']
        response = self.app.get('/Fetch_ads')
        self.assertEqual(response.status_code, 400)
        data = response.get_json()
        self.assertEqual(data['error'], 'Ads plugin not available')
    
    def test_fetch_charity(self):
        # Test the fetch_charity route with the charity plugin available
        response = self.app.get('/Fetch_charities')
        self.assertEqual(response.status_code, 200)
        data = response.get_json()
        self.assertEqual(data['status'], 'success')
        self.assertIn('charity', data)

        # Test the fetch_charity route without the charity plugin
        # Temporarily remove the charity plugin
        del app.core_system['charity']
        response = self.app.get('/Fetch_charities')
        self.assertEqual(response.status_code, 400)
        data = response.get_json()
        self.assertEqual(data['error'], 'Charity plugin not available')

if __name__ == '__main__':
    unittest.main()