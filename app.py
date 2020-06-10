from flask import Flask, render_template
from flask import request, redirect, flash, url_for
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

@app.route('/addstudent', methods=['GET','POST'])
def addstudent():
    db_connection = connect_to_database()

    #Show form to add student if method is GET
    if request.method == 'GET':
        return render_template('addstudent.html')

    #Add new student to database if method is POST
    if request.method == 'POST':
        first_name_input = request.form['fname']
        last_name_input = request.form['lname']
        email_input = request.form['email']

        query = "INSERT INTO Students (first_name, last_name, email) \
        VALUES (%s, %s, %s)"
        data = (first_name_input, last_name_input, email_input)
        result = execute_query(db_connection, query, data)

        flash('A Student Has Been Added!', 'success')
        return redirect(url_for('students'))

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

#ROUTES PERTAINING TO LOANING BOOKS
@app.route('/booksonloan')
def booksonloan():
    db_connection = connect_to_database()

    query = "SELECT loanID, Books.title, \
    Books_On_Loan.studentID, Students.first_name, Students.last_name, \
    date_checkout, date_due, date_returned, late_fee \
    FROM Books_On_Loan \
    INNER JOIN Books ON Books_On_Loan.bookID = Books.bookID \
    INNER JOIN Students ON Books_On_Loan.studentID = Students.studentID \
    ORDER BY loanID"
    result = execute_query(db_connection, query).fetchall()

    return render_template('booksonloan.html', booksonloan=result)

@app.route('/updateloanbook')
def updateloanbook():
    return render_template('updateloanbook.html')