from plugins.BasePlugin import BasePlugin
from flask import jsonify

class PaymentPlugin(BasePlugin):
    def register(self, core_system):
        core_system['payment'] = self #save this object to core_system with key 'payment'

    def redirect_to_paypal(self):
        return jsonify({"status": "success", "transaction_type": "Paypal"})
    
    def redirect_to_Truemoney(self):
        return jsonify({"status": "success", "transaction_type": "True Money"})
    
    def redirect_to_BankTransfer(self):
        return jsonify({"status": "success", "transaction_type": "Bank Transfer"})

def register(core_system):
    plugin = PaymentPlugin()
    plugin.register(core_system)