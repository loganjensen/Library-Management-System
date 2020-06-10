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

@app.route('/updatestudent/<int:id>', methods=['GET','POST'])
def updatestudent(id):
    db_connection = connect_to_database()

    if request.method == 'GET':
        query = "SELECT studentID, first_name, last_name, email FROM Students WHERE studentID = %s" % id
        student_result = execute_query(db_connection, query).fetchall()
        studentIDResult = execute_query(db_connection, query).fetchone()

        if student_result == None:
            return "No student found!"

        return render_template('updatestudent.html', student=student_result, studentID=studentIDResult)

    elif request.method == 'POST':
        studentID_input = request.form['id']
        first_name_input = request.form['fname']
        last_name_input = request.form['lname']
        email_input = request.form['email']

        query = "UPDATE Students \
        SET first_name = %s, last_name = %s, email = %s \
        WHERE studentID = %s"
        data = (first_name_input, last_name_input, email_input, studentID_input)
        result = execute_query(db_connection, query, data)
        flash('Student updated!', 'success')
        return redirect(url_for('students'))


@app.route('/deletestudent/<int:id>')
def deletestudent(id):
    db_connection = connect_to_database()
    query = "DELETE FROM Students WHERE studentID = %s"
    data = (id, )
    result = execute_query(db_connection, query, data)
    flash('Student has been deleted!', 'success')
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

@app.route('/addbook', methods=['GET','POST'])
def addbook():
    db_connection = connect_to_database()

    #Show form to add book if method is GET
    if request.method == 'GET':
        #Get data of Authors and Genres so user can link an author to a book
        author_query = "SELECT * FROM Authors"
        author_result = execute_query(db_connection, author_query).fetchall()

        genre_query = "SELECT * FROM Genres"
        genre_result = execute_query(db_connection, genre_query).fetchall()

        return render_template('addbook.html', authors=author_result, genres=genre_result)

    #Add new book to database if method is POST
    if request.method == 'POST':



        flash('A Book Has Been Added!', 'success')
        return redirect(url_for('books'))

@app.route('/updatebook')
def updatebook():
    return render_template('updatebook.html')

@app.route('/deletebook/<int:id>')
def deletebook(id):
    db_connection = connect_to_database()
    query = "DELETE FROM Books WHERE bookID = %s"
    data = (id, )
    result = execute_query(db_connection, query, data)
    flash('Book has been deleted!', 'success')
    return redirect(url_for('books'))

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