from flask import Flask, render_template
from flask import request, redirect
from db_connector import connect_to_database, execute_query

#create the web application
app = Flask(__name__)
app.secret_key = 'SECRETKEY'

@app.route('/')
@app.route('/index')
def homepage():
    return render_template('index.html')

@app.route('/students')
def students():
    db_connection = connect_to_database()
    query = "SELECT studentID, first_name, last_name, email FROM Students;"
    result = execute_query(db_connection, query).fetchall()
    return render_template('students.html', students=result)

@app.route('/addstudent')
def addstudent():
    return render_template('addstudent.html')

@app.route('/books')
def books():
    return render_template('books.html')

@app.route('/booksonloan')
def booksonloan():
    return render_template('booksonloan.html')