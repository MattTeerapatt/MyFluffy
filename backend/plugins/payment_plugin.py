from plugins.BasePlugin import BasePlugin
from flask import jsonify

class PaymentPlugin(BasePlugin):
    def register(self, core_system):
        core_system['payment'] = self #save this object to core_system with key 'payment'

    def process_payment(self, data):
        return jsonify({"status": "success", "transaction_id": "1234567890"})

def register(core_system):
    plugin = PaymentPlugin()
    plugin.register(core_system)