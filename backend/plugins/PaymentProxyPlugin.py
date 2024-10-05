from plugins.BasePlugin import BasePlugin
from flask import jsonify
from flask import current_app

class PaymentPlugin(BasePlugin):
    def register(self):
        self.name = 'payment'
        current_app.core_system['payment'] = self #save this object to core_system with key 'payment'

    def redirect_to_paypal(self):
        return jsonify({"status": "success", "transaction_type": "Paypal"})
    
    def redirect_to_Truemoney(self):
        return jsonify({"status": "success", "transaction_type": "True Money"})
    
    def redirect_to_BankTransfer(self):
        return jsonify({"status": "success", "transaction_type": "Bank Transfer"})

def register():
    plugin = PaymentPlugin()
    plugin.register()