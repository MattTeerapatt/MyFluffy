from plugins.BasePlugin import BasePlugin
from flask import jsonify
from flask import current_app

class AdsPlugin(BasePlugin):
    _instance = None
    
    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = super(AdsPlugin, cls).__new__(cls, *args, **kwargs)
        return cls._instance
    
    def __init__(self):
        if not hasattr(self, 'initialized'):  
            self.name = 'ads'
            self.initialized = True
            
    def register(self):
        self.name = 'ads'
        self.schema = current_app.schema[self.name]
        self.session = current_app.Session
        current_app.core_system[self.name] = self  # Save this object to core_system with key 'ads'

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