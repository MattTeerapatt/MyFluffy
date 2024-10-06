# HOW TO RUN: 
# 1. must have db postgres (docker run --name SDA_db -e POSTGRES_PASSWORD=password -d -p 5432:5432 postgres)
# 2. run python load_data.py 
# 3. run python core_system.py
# 4. enjoy คร้าบบบบบบบบบบบบ http://127.0.0.1:5000



import uuid
from flask import Flask, jsonify, request
from sqlalchemy import create_engine, Column, String, Integer, ForeignKey, Text, Boolean, LargeBinary
from sqlalchemy.orm import sessionmaker, relationship, declarative_base
from sqlalchemy.dialects.postgresql import BYTEA
import os
import importlib.util

app = Flask(__name__)
DATABASE_URI = 'postgresql+psycopg2://postgres:password@localhost:5432/postgres'
app.config['SQLALCHEMY_DATABASE_URI'] = DATABASE_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

engine = create_engine(DATABASE_URI)
Session = sessionmaker(bind=engine)

Base = declarative_base()

#__________________________________________________________________________________
# Define the 'ads' table as a Python class
class Ads(Base):
    __tablename__ = 'ads'
    id = Column(Integer, primary_key=True, autoincrement=True)
    link = Column(String(200), nullable=True)  
    picture = Column(LargeBinary, nullable=True)  

# Define the 'charity' table as a Python class
class Charity(Base):
    __tablename__ = 'charity'
    id = Column(Integer, primary_key=True, autoincrement=True)
    link = Column(String(200), nullable=True)  
    picture = Column(BYTEA, nullable=True)  

# Users table model
class User(Base):
    __tablename__ = 'users'
    user_id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    name = Column(String, nullable=False)
    password = Column(String, nullable=False)  # Store encrypted password
    location = Column(String)
    phone_number = Column(String, nullable=False)
    email = Column(String, nullable=False)
    Bankaccount = Column(String, nullable=False)
    

    # Relationship to posts (one-to-many)
    posts = relationship("Post", back_populates="owner", cascade="all, delete")

# Posts table model
class Post(Base):
    __tablename__ = 'posts'
    post_id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    owner_id = Column(String, ForeignKey('users.user_id', ondelete='CASCADE'), nullable=False)
    pet_name = Column(String, nullable=False)
    description = Column(Text)
    location = Column(String)  # Use PostGIS 'GEOGRAPHY'
    image = Column(BYTEA)  # Binary data for image
    reward = Column(String)
    found = Column(Boolean)

    # Relationship to users
    owner = relationship("User", back_populates="posts")

#__________________________________________________________________________________

# Dictionary schema to store all tables
schema = {Ads.__tablename__: Ads, 
          Charity.__tablename__: Charity, 
          User.__tablename__: User, 
          Post.__tablename__: Post}

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
                module.register()


app.core_system = core_system
app.Session = Session()
app.schema = schema

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

@app.route('/FetchAllPost', methods=['GET'])
def FetchAllPost():
    if 'post' in core_system:
        return core_system['post'].FetchAllPost()
    return jsonify({"error": "Post plugin not available"}), 400

if __name__ == '__main__':
    with app.app_context():
        load_plugins()
    print("Plugins loaded:", list(core_system.keys()))
    app.run(debug=True)
    
#in db:
#Photo name description location reward
#want /FetchAllPost and /FetchPostByLocation 
#want FetchCharity