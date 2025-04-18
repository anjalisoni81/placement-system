from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL

app = Flask(__name__)

# MySQL Configuration
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'PlacementSyst1'

mysql = MySQL(app)

@app.route('/')
def index():
    return render_template('index.html')
@app.route('/students', methods=['GET', 'POST'])
def students():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Student")
    data = cur.fetchall()

    if request.method == 'POST':  # Handle POST request for deletion
        reg_no = request.form['delete_reg_no']  # Get the reg_no of the student to delete
        cur.execute("DELETE FROM Student WHERE Registration_No = %s", [reg_no])
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('students'))  # Redirect back to the students list page

    cur.close()
    return render_template('students.html', students=data)

@app.route('/add_student', methods=['GET', 'POST'])
def add_student():
    if request.method == 'POST':
        reg_no = request.form['reg_no']
        name = request.form['name']
        section = request.form['section']
        branch = request.form['branch']
        placement_id = request.form['placement_id']
        stipend = request.form['stipend']
        offertype = request.form['offertype']
        onoff = request.form['onoff']
        company_id = request.form['company_id']
        package_val = request.form['package_val']

        cur = mysql.connection.cursor()
        cur.callproc('InsertStudentWithPlacement', 
            [reg_no, name, section, branch, placement_id, stipend, offertype, onoff, company_id, package_val])
        mysql.connection.commit()
        cur.close()
        return redirect('/students')

    return render_template('add_student.html')




@app.route('/placements')
def placements():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT s.Name, s.Branch, p.Package
        FROM Student s
        JOIN Placement p ON s.Registration_No = p.Registration_No
    """)
    data = cur.fetchall()
    cur.close()
    return render_template('placements.html', placements=data)

@app.route('/company-stats')
def company_stats():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT c.Company_Name, COUNT(p.Registration_No)
        FROM Placement p
        JOIN Company c ON p.Company_ID = c.Company_ID
        GROUP BY p.Company_ID
    """)
    data = cur.fetchall()
    cur.close()
    return render_template('company_stats.html', stats=data)

@app.route('/companies')
def companies():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Company")
    data = cur.fetchall()
    cur.close()
    return render_template('companies.html', companies=data)

if __name__ == '__main__':
    app.run(debug=True)
