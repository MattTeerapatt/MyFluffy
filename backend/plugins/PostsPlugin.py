from plugins.BasePlugin import BasePlugin
from flask import jsonify
from flask import current_app
import base64

class PostsPlugin(BasePlugin):
    _instance = None
    
    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = super(PostsPlugin, cls).__new__(cls, *args, **kwargs)
        return cls._instance
    
    def __init__(self):
        if not hasattr(self, 'initialized'):  
            self.name = 'posts'
            self.initialized = True
            
    def register(self):
        self.name = 'posts'
        self.schema = current_app.schema[self.name]
        self.session = current_app.Session
        current_app.core_system[self.name] = self

    def FetchAllPost(self):
        posts = self.session.query(self.schema).all()
        #split by location
        by_location = {}
        for post in posts:
            if post.location not in by_location:
                by_location[post.location] = []
                print(post)
            by_location[post.location].append(self.to_dict(post))
        if not posts:
                return jsonify({"status": "success", "post": []})
        return jsonify({"status": "success", "post": by_location})
    
    def AddPost(self, data):
        post = self.schema(
            owner_id = data.get('owner_id'),
            pet_name = data.get('pet_name'),
            description = data.get('description'),
            location = data.get('location'),  # Expected format: 'POINT(longitude latitude)'
            image = data.get('image'),  # Expected to be base64 encoded
            reward = data.get('reward'),
            found = False
        )
        try:
            self.session.add(post)
            self.session.commit()
        except Exception as e:
            self.session.rollback()
            return jsonify({"status": "error", "message": str(e)}), 400
        

        return jsonify({"status": "success", "post": self.to_dict(post)})



    
    def to_dict(self, post):
        return {
            'post_id': post.post_id,
            'owner_id': post.owner_id,
            'pet_name': post.pet_name,
            'description': post.description,
            'location': post.location,
            'reward': post.reward,
            'image': post.image,
            'found': post.found,
        }


def register():
    plugin = PostsPlugin()
    plugin.register()