from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


orders = Blueprint('orders', __name__)

@orders.route('/postOrder', methods=['POST'])
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

