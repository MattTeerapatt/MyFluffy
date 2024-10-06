import uuid
from sqlalchemy import create_engine, Column, String, Integer, ForeignKey, Text, Boolean, LargeBinary
from sqlalchemy.orm import sessionmaker, relationship, declarative_base
from sqlalchemy.dialects.postgresql import BYTEA
from sqlalchemy.exc import IntegrityError

# Database connection
DATABASE_URL = 'postgresql+psycopg2://postgres:password@localhost:5432/postgres'
engine = create_engine(DATABASE_URL)

# Base class for declarative models
Base = declarative_base()

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
    location = Column(String)
    image = Column(BYTEA)  # Binary data for image
    reward = Column(String)
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
    ad1 = Ads(link='http://example.com/ad1', picture=b'Test Picture 1')
    ad2 = Ads(link='http://example.com/ad2', picture=b'Test Picture 2')
    session.add_all([ad1, ad2])

    # Charity data
    charity1 = Charity(link='http://example.com/charity1', picture=b'Test Picture 1')
    charity2 = Charity(link='http://example.com/charity2', picture=b'Test Picture 2')
    session.add_all([charity1, charity2])

    # Add mock users
    user1 = User(name='John Doe', password='encrypted_pwd1', phone_number='123-456-7890', email='john@example.com', Bankaccount='123456789')
    user2 = User(name='Jane Smith', password='encrypted_pwd2', phone_number='987-654-3210', email='jane@example.com', Bankaccount='987654321')
    session.add_all([user1, user2])
    
    
    # Add mock posts
    #get user_id
    user1_id = session.query(User).filter_by(name='John Doe').first().user_id
    user2_id = session.query(User).filter_by(name='Jane Smith').first().user_id
    post1 = Post(owner_id=str(user1_id), pet_name='Tom', description='Lost Dog', location='100.0 0.0', image=None, reward='50', found=False)
    post2 = Post(owner_id=str(user2_id), pet_name='Jerry', description='Found Cat', location='101.0 1.0', image=None, reward='100', found=True)
    session.add_all([post1, post2])

    # Commit the changes
    session.commit()

    print("Data loaded successfully!")

except IntegrityError as e:
    print(f"An error occurred: {e}")
    session.rollback()

finally:
    # Close the session
    session.close()