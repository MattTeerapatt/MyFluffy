from plugins.BasePlugin import BasePlugin
from flask import jsonify
from flask import current_app

class PaymentPlugin(BasePlugin):
    _instance = None
    
    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = super(PaymentPlugin, cls).__new__(cls, *args, **kwargs)
        return cls._instance
    
    def __init__(self):
        if not hasattr(self, 'initialized'):  
            self.name = 'payment'
            self.initialized = True
            
    def register(self):
        self.name = 'payment'
        current_app.core_system[self.name] = self #save this object to core_system with key 'payment'

    def redirect_to_paypal(self):
        return jsonify({"status": "success", "transaction_type": "Paypal"})
    
    def redirect_to_Truemoney(self):
        return jsonify({"status": "success", "transaction_type": "True Money"})
    
    def redirect_to_BankTransfer(self):
        return jsonify({"status": "success", "transaction_type": "Bank Transfer"})

def register():
    plugin = PaymentPlugin()
    plugin.register()