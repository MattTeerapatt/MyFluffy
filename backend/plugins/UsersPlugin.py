from plugins.BasePlugin import BasePlugin
from flask import jsonify
from flask import current_app

class UsersPlugin(BasePlugin):
    def register(self):
        self.name = 'users'
        self.schema = current_app.schema[self.name]
        self.session = current_app.Session
        current_app.core_system[self.name] = self

    def fetch_user_by_id(self, user_id):
        user = self.session.query(self.schema).filter_by(user_id=user_id).first()
        if not user:
            return jsonify({"status": "error", "message": "User not found"})
        return jsonify({"status": "success", "user": self.to_dict(user)})

    def to_dict(self, user):
        return {
            'user_id': user.user_id,
            'name' : user.name,
            'password' : user.password,
            'email' : user.email,
            'phone' : user.phone_number,
            'location' : user.location,
            'Bankaccount' : user.Bankaccount,
        }
    
def register():
    plugin = UsersPlugin()
    plugin.register()