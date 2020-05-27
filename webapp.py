from flask import Flask, render_template
from flask import request, redirect
#from db_connector.db_connector import connect_to_database, execute_query
#create the web application
webapp = Flask(__name__)
webapp.config['DEBUG'] = True

#provide a route where requests on the web application can be addressed
@webapp.route('/')
@webapp.route('/index')
def homepage():
    return render_template('index.html')

@webapp.route('/students')
def students():
    return render_template('students.html')

@webapp.route('/books')
def books():
    return render_template('books.html')

@webapp.route('/booksonloan')
def booksonloan():
    return render_template('booksonloan.html')