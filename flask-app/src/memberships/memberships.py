from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

memberships = Blueprint('memberships', __name__)

@memberships.route('/updateType', methods=['PUT'])
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

