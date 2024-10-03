from plugins.BasePlugin import BasePlugin
from flask import jsonify
from core_system import Ads

class AdsPlugin(BasePlugin):
    def register(self, core_system):
        core_system['ads'] = self  # Save this object to core_system with key 'ads'

    def fetch_ads(self):
        ads = Ads.query.all()
        if not ads:
                return jsonify({"status": "success", "ads": []})
        ads_list = [ad.content for ad in ads]
        return jsonify({"status": "success", "ads": ads_list})

# Register the plugin
def register(core_system):
    plugin = AdsPlugin()
    plugin.register(core_system)