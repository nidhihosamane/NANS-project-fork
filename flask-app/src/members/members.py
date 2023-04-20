from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

members = Blueprint('members', __name__)

@members.route('/postOrder', methods=['POST'])
def post_order():
    the_data = request.json
    current_app.logger.info(the_data)
    
    #extracting variable
    total_cost = the_data['totalCost']
    oid = the_data['oid']
    mcid = the_data['mcid']
    mid = the_data['mid']

    #constructing the query
    query = 'INSERT INTO Orders (totalCost, oid, mcid, mid) VALUES ("'
    query += str(total_cost) + '", "'
    query += str(oid) + '", "'
    query += str(mcid) + '", "'
    query += str(mid) + '")'   
    
    current_app.logger.info(query)
    
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Order created!'


# Get all the classes from the database
@members.route('/classNames', methods=['GET'])
def get_classes():
    # get a cursor object from the database
    
    query = '''
        SELECT name
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



@members.route('/updateType', methods=['PUT'])
def update_type():
    the_data = request.json
    current_app.logger.info(the_data)
    
    msid = the_data['msid']
    type = the_data['type']

    query = "UPDATE Membership SET type = '{}' WHERE msid = {}".format(type, msid)


    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Membership Updated!'



@members.route('/deleteAccount', methods=['DELETE'])
def delete_account():
    the_data = request.json
    current_app.logger.info(the_data)
    
    mid = the_data['mid']
    query = 'DELETE FROM Member WHERE mid = '  + str(mid)
    
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Member account deleted!'



