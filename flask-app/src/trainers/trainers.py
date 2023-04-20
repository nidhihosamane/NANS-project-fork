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
@trainers.route('/contact', methods=['GET'])
def get_contact():
   # get a cursor object from the database
  
   query = '''
       SELECT first_name, last_name, phoneNum_1, email_1
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
       SELECT name, startTime, endTime, roomNum
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




@trainers.route('/updateLast', methods=['PUT'])
def update_last():
   the_data = request.json
   current_app.logger.info(the_data)
  
   tid = the_data['tid']
   last = the_data['last']


   query = "UPDATE Trainer SET last = '{}' WHERE tid = {}".format(last, tid)


   current_app.logger.info(query)
   cursor = db.get_db().cursor()
   cursor.execute(query)
   db.get_db().commit()
  
   return 'Last Name Updated!'


# @trainer.route('/postTrainer', methods=['POST'])
# def new_member():
#     the_data = request.json
#     current_app.logger.info(the_data)
    
#     #extracting variable
#     mid = the_data['mid']
#     first_name = the_data['first_name']
#     last_name = the_data['last_name']
#     gender = the_data['gender']
#     years = the_data['years']
#     age = the_data['age']
#     mcid = the_data['mcid']
#     msid = the_data['msid']
#     phoneNum_1 = the_data['phoneNum_1']
#     phoneNum_2 = the_data['phoneNum_2']
#     email_1 = the_data['email_1']
#     email_2 = the_data['email_2']

#     query = 'INSERT into Member (mid, first_name, last_name, gender, years, age,\
#           mcid, msid, phoneNum_1, phoneNum_2, email_1,email_2) VALUES ("'
#     query += str(mid) + '", "'
#     query += str(first_name) + '", "'
#     query += str(last_name) + '", "'
#     query += str(gender) + '", "'
#     query += str(years) + '", "'
#     query += str(age) + '", "'
#     query += str(mcid) + '", "'
#     query += str(msid) + '", "'
#     query += str(phoneNum_1) + '", "'
#     query += str(phoneNum_2) + '", "'
#     query += str(email_1) + '", "'
#     query += str(email_2) + '")'   
    
#     current_app.logger.info(query)
    
#     cursor = db.get_db().cursor()
#     cursor.execute(query)
#     db.get_db().commit()
#     return 'Member created!'

@trainers.route('/deleteCertification', methods=['DELETE'])
def delete_certification():
    the_data = request.json
    current_app.logger.info(the_data)
    
    tid = the_data['tid']
    query = 'DELETE FROM Certs WHERE tid = '  + str(tid)
    
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Trainer certification deleted!'