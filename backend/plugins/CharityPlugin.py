from plugins.BasePlugin import BasePlugin
from flask import jsonify
from core_system import Charity

class CharitiesPlugin(BasePlugin):
    def register(self, core_system):
        core_system['charity'] = self  # Save this object to core_system with key 'charity'

    def fetch_charities(self):
        charities = Charity.query.all()
        if not charities:
                return jsonify({"status": "success", "charity": []})
        charities_list = [c.content for c in charities]
        return jsonify({"status": "success", "charity": charities_list})

# Register the plugin
def register(core_system):
    plugin = CharitiesPlugin()
    plugin.register(core_system)