from sqlalchemy import create_engine, Column, String, Integer, ForeignKey, Text, Boolean, LargeBinary
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy.dialects.postgresql import BYTEA
from geoalchemy2 import Geography  # Needed for PostGIS 'GEOGRAPHY' type
from sqlalchemy.exc import IntegrityError

# Database connection
DATABASE_URL = 'postgresql://postgres:password@localhost:5432/postgres'
engine = create_engine(DATABASE_URL)

# Base class for declarative models
Base = declarative_base()

# Define the 'ads' table as a Python class
class Ads(Base):
    __tablename__ = 'ads'
    id = Column(Integer, primary_key=True, autoincrement=True)
    content = Column(String(200), nullable=False)

# Define the 'charity' table as a Python class
class Charity(Base):
    __tablename__ = 'charity'
    id = Column(Integer, primary_key=True, autoincrement=True)
    content = Column(String(200), nullable=False)

# Users table model
class User(Base):
    __tablename__ = 'users'
    user_id = Column(String, primary_key=True)
    name = Column(String, nullable=False)
    password = Column(String, nullable=False)  # Store encrypted password
    phone_number = Column(String, nullable=False)
    money = Column(Integer)

    # Relationship to posts (one-to-many)
    posts = relationship("Post", back_populates="owner", cascade="all, delete")

# Posts table model
class Post(Base):
    __tablename__ = 'posts'
    post_id = Column(String, primary_key=True)
    owner_id = Column(String, ForeignKey('users.user_id', ondelete='CASCADE'), nullable=False)
    description = Column(Text)
    location = Column(Geography(geometry_type='POINT', srid=4326))  # Use PostGIS 'GEOGRAPHY'
    image = Column(BYTEA)  # Binary data for image
    reward = Column(Integer)
    found = Column(Boolean)

    # Relationship to users
    owner = relationship("User", back_populates="posts")

# Create tables
Base.metadata.create_all(engine)

# Creating a session to interact with the database
Session = sessionmaker(bind=engine)
session = Session()

# Mock Data
try:
    # Ads data
    ad1 = Ads(content='Test Ad 1')
    ad2 = Ads(content='Test Ad 2')
    session.add_all([ad1, ad2])

    # Charity data
    charity1 = Charity(content='Test Charity 1')
    charity2 = Charity(content='Test Charity 2')
    session.add_all([charity1, charity2])

    # Add mock users
    user1 = User(user_id='user_001', name='John Doe', password='encrypted_pwd1', phone_number='123-456-7890', money=100)
    user2 = User(user_id='user_002', name='Jane Smith', password='encrypted_pwd2', phone_number='987-654-3210', money=200)
    session.add_all([user1, user2])

    # Add mock posts
    post1 = Post(post_id='post_001', owner_id='user_001', description='Lost Dog', location='POINT(100.0 0.0)', image=None, reward=50, found=False)
    post2 = Post(post_id='post_002', owner_id='user_002', description='Found Cat', location='POINT(101.0 1.0)', image=None, reward=100, found=True)
    session.add_all([post1, post2])

    # Commit the changes
    session.commit()

except IntegrityError as e:
    print(f"An error occurred: {e}")
    session.rollback()

finally:
    # Close the session
    session.close()
