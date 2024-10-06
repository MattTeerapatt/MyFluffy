import unittest
from flask import Flask, jsonify
from core_system import app, core_system, Session, Post
from unittest.mock import patch, MagicMock
import json


class CoreSystemTestCase(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_index(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Welcome to the Core System", response.data)

    def test_fetch_ads(self):
        core_system['ads'] = MockAdsPlugin()
        response = self.app.get('/Fetch_ads')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Mock Ads Data", response.data)

    def test_fetch_charities(self):
        core_system['charity'] = MockCharityPlugin()
        response = self.app.get('/Fetch_charities')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Mock Charity Data", response.data)

    def test_pay_paypal(self):
        core_system['payment'] = MockPaymentPlugin()
        response = self.app.get('/pay_paypal')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Redirect to PayPal", response.data)

    def test_pay_truemoney(self):
        core_system['payment'] = MockPaymentPlugin()
        response = self.app.get('/pay_truemoney')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Redirect to TrueMoney", response.data)

    def test_pay_bank_transfer(self):
        core_system['payment'] = MockPaymentPlugin()
        response = self.app.get('/pay_bank_transfer')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Redirect to Bank Transfer", response.data)
    
    @patch('core_system.Session')
    def test_post_postings(self, MockSession):
        # Mock the database session and Post object
        mock_session = MockSession.return_value
        mock_post = MagicMock(spec=Post)
        mock_session.add.return_value = None
        mock_session.commit.return_value = None
        mock_session.rollback.return_value = None
        mock_session.close.return_value = None

        # Define the test data
        test_data = {
            "owner_id": "b75c7db5-9eee-403e-92d2-d0f84959e437",
            "pet_name": "Parrot",
            "description": "Lost Parrot",
            "location": "POINT(100.0 0.0)",
            "image": "base64_encoded_image_string",
            "reward": "100"
        }

        # Mock the PostsPlugin
        core_system['posts'] = MockPostsPlugin()

        # Simulate a POST request to the /PostPostings endpoint
        response = self.app.post('/PostPostings', data=json.dumps(test_data), content_type='application/json')

        # Check the response
        self.assertEqual(response.status_code, 201)
        response_data = json.loads(response.data)
        self.assertEqual(response_data['status'], "success")
        self.assertEqual(response_data['post']['owner_id'], test_data['owner_id'])
        self.assertEqual(response_data['post']['pet_name'], test_data['pet_name'])
        self.assertEqual(response_data['post']['description'], test_data['description'])
        self.assertEqual(response_data['post']['location'], test_data['location'])
        self.assertEqual(response_data['post']['reward'], test_data['reward'])
        self.assertIsNone(response_data['post']['image'])
        self.assertFalse(response_data['post']['found'])



class MockAdsPlugin:
    def fetch_ads(self):
        return jsonify({"data": "Mock Ads Data"})

class MockCharityPlugin:
    def fetch_charities(self):
        return jsonify({"data": "Mock Charity Data"})

class MockPaymentPlugin:
    def redirect_to_paypal(self):
        return jsonify({"data": "Redirect to PayPal"})

    def redirect_to_Truemoney(self):
        return jsonify({"data": "Redirect to TrueMoney"})

    def redirect_to_BankTransfer(self):
        return jsonify({"data": "Redirect to Bank Transfer"})

class MockPostsPlugin:
    def AddPost(self, data):
        post = {
            'post_id': '6e330118-d037-48a3-aa3b-381dbaf30b55',
            'owner_id': data.get('owner_id'),
            'pet_name': data.get('pet_name'),
            'description': data.get('description'),
            'location': data.get('location'),
            'reward': data.get('reward'),
            'image': None,
            'found': False,
        }
        return jsonify({"status": "success", "post": post}), 201

if __name__ == '__main__':
    unittest.main()