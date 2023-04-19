from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

members = Blueprint('members', __name__)

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



