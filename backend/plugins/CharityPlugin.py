from plugins.BasePlugin import BasePlugin
from flask import jsonify
from flask import current_app

class CharitiesPlugin(BasePlugin):
    def register(self):
        self.name = 'charity'
        self.schema = current_app.schema[self.name]
        self.session = current_app.Session
        current_app.core_system[self.name] = self

    def fetch_charities(self):
        charities = self.session.query(self.schema).all()
        if not charities:
                return jsonify({"status": "success", "charity": []})
        charities_list = [c.id for c in charities]
        return jsonify({"status": "success", "charity": charities_list})

# Register the plugin
def register():
    plugin = CharitiesPlugin()
    plugin.register()