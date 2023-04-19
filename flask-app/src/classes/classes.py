from flask import Blueprint, request, jsonify, make_response
import json
from src import db


classes = Blueprint('classes', __name__)


# Get all the products from the database
@classes.route('/classnames', methods=['GET'])
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

