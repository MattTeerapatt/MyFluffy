from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
import os
import importlib.util

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:password@localhost:5432/core_system_db'
#before running this, create a database called core_system_db in postgres and run the following line:
#psql -U username -d core_system_db -f path/to/init.sql 
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# Initialize core system
core_system = {}

class Ads(db.Model):
    __tablename__ = 'ads'
    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String(200), nullable=False)
    
class Charity(db.Model):
    __tablename__ = 'charity'
    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String(200), nullable=False)

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


@app.route('/Fetch_ads', methods=['GET'])
def fetch_ads():
    if 'ads' in core_system:
        return core_system['ads'].fetch_ads()
    return jsonify({"error": "Ads plugin not available"}), 400

@app.route('/Fetch_charities', methods=['GET'])
def fetch_charity():
    if 'charity' in core_system:
        return core_system['charity'].fetch_charities()
    return jsonify({"error": "Charity plugin not available"}), 400

@app.route('/pay_paypal', methods=['GET'])
def pay_paypal():
    if 'payment' in core_system:
        return core_system['payment'].redirect_to_paypal()
    return jsonify({"error": "Payment plugin not available"}), 400

@app.route('/pay_truemoney', methods=['GET'])
def pay_truemoney():
    if 'payment' in core_system:
        return core_system['payment'].redirect_to_Truemoney()
    return jsonify({"error": "Payment plugin not available"}), 400

@app.route('/pay_bank_transfer', methods=['GET'])
def pay_bank_transfer():
    if 'payment' in core_system:
        return core_system['payment'].redirect_to_BankTransfer()
    return jsonify({"error": "Payment plugin not available"}), 400

if __name__ == '__main__':
    db.create_all()
    load_plugins()
    app.run(debug=True)
    
#in db:
#Photo name description location reward
#want /FetchAllPost and /FetchPostByLocation 
#want FetchCharity