from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


trainers = Blueprint('trainers', __name__)


# Get all the different trainers from the database
@trainers.route('/members', methods=['GET'])
def get_members():
    # get a cursor object from the database

    query = '''
       SELECT first_name, last_name
       FROM Member
   '''
    # use cursor to query the database for a list of products
    cursor = db.get_db().cursor()
    cursor.execute(query)

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Get the total number of remaining seats for a class
@trainers.route('/totalseats', methods=['GET'])
def get_seats():
    # get a cursor object from the database

    query = '''
       SELECT name, totalSeats
       FROM Class
   '''
    # use cursor to query the database for a list of products
    cursor = db.get_db().cursor()
    cursor.execute(query)

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Get all the different trainers from the database
@trainers.route('/interest', methods=['GET'])
def get_interest():
    # get a cursor object from the database

    query = '''
       SELECT first, last, interest
       FROM Member
   '''
    # use cursor to query the database for a list of products
    cursor = db.get_db().cursor()
    cursor.execute(query)

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Get all the different trainers from the database
@trainers.route('/managerinfo', methods=['GET'])
def get_information():
    # get a cursor object from the database

    query = '''
       SELECT first, last, email, phoneNum
       FROM Manager
   '''
    # use cursor to query the database for a list of products
    cursor = db.get_db().cursor()
    cursor.execute(query)

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Get all the different trainers from the database
@trainers.route('/classinfo', methods=['GET'])
def get_classinfo():
    # get a cursor object from the database

    query = '''
       SELECT name, startTime, endTiime, roomNum
       FROM Class
   '''
    # use cursor to query the database for a list of products
    cursor = db.get_db().cursor()
    cursor.execute(query)

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@trainers.route('/updateSpecialty', methods=['PUT'])
def update_specialty():
    the_data = request.json
    current_app.logger.info(the_data)

    tid = the_data['tid']
    specialty = the_data['specialty']

    query = "UPDATE Trainer SET specialty = '{}' WHERE tid = {}".format(
        type, tid)

    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Specialty Updated!'


@trainers.route('/postTrainer', methods=['POST'])
def post_trainer():
    the_data = request.json
    current_app.logger.info(the_data)

    # extracting variable
    specialty = the_data['specialty']

    # constructing the query
    query = 'INSERT INTO Trainer (specialty, oid, mcid, mid) VALUES ("'
    query += str(specialty) + '", "'

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Specialty updated!'