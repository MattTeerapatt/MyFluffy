from flask import Flask, jsonify, request
import os
import importlib.util

app = Flask(__name__)

# Initialize core system
core_system = {}

def load_plugins():
    plugins_dir = os.path.join(os.path.dirname(__file__), 'plugins')
    for filename in os.listdir(plugins_dir):
        if filename.endswith('.py') and filename != '__init__.py' and filename != 'base_plugin.py':
            plugin_path = os.path.join(plugins_dir, filename)
            spec = importlib.util.spec_from_file_location(filename[:-3], plugin_path)
            module = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(module)
            if hasattr(module, 'register'):
                module.register(core_system)
    app.core_system = core_system  # Attach core_system to app

@app.route('/')
def index():
    return jsonify({"message": "Welcome to the Core System", "plugins": list(core_system.keys())})

@app.route('/pay', methods=['POST'])
def pay():
    if 'payment' in core_system:
        return core_system['payment'].process_payment(request.json)
    return jsonify({"error": "Payment plugin not available"}), 400

if __name__ == '__main__':
    load_plugins()
    app.run(debug=True)