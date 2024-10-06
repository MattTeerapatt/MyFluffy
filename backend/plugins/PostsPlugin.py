from plugins.BasePlugin import BasePlugin
from flask import jsonify
from flask import current_app

class PostsPlugin(BasePlugin):
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