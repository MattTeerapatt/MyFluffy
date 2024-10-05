from plugins.BasePlugin import BasePlugin
from flask import jsonify
from flask import current_app

class AdsPlugin(BasePlugin):
    def register(self):
        self.name = 'ads'
        self.schema = current_app.schema[self.name]
        self.session = current_app.Session
        current_app.core_system['ads'] = self  # Save this object to core_system with key 'ads'

    def fetch_ads(self):
        ads = self.session.query(self.schema).all()
        if not ads:
                return jsonify({"status": "success", "ads": []})
        ads_list = [ad.id for ad in ads]
        return jsonify({"status": "success", "ads": ads_list})

# Register the plugin
def register():
    plugin = AdsPlugin()
    plugin.register()