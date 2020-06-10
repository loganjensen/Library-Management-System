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

#ROUTES PERTAINING TO STUDENTS
@app.route('/students')
def students():
    db_connection = connect_to_database()

    query = "SELECT studentID, first_name, last_name, email FROM Students;"
    result = execute_query(db_connection, query).fetchall()

    return render_template('students.html', students=result)

@app.route('/addstudent')
def addstudent():
    return render_template('addstudent.html')

#ROUTES PERTAINING TO BOOKS
@app.route('/books')
def books():
    db_connection = connect_to_database()

    query = "SELECT bookID, title, year_published, Books.authorID, \
    Authors.first_name, Authors.last_name, Genres.genre_name \
    FROM Books \
    INNER JOIN Authors ON Books.authorID = Authors.authorID \
    INNER JOIN Genres ON Books.genreID = Genres.genreID \
    ORDER BY bookID"
    result = execute_query(db_connection, query).fetchall()

    return render_template('books.html', books=result)

@app.route('/addbook')
def addbook():
    return render_template('addbook.html')

@app.route('/updatebook')
def updatebook():
    return render_template('updatebook.html')

@app.route('/booksonloan')
def booksonloan():
    return render_template('booksonloan.html')