import mysql.connector as MySQL
from config import db_con
import json
import codecs


with codecs.open('doctors.json', 'w','utf-8') as file:
    try:
        connection = MySQL.connect(host = db_con['host'], database = db_con['database'], user = db_con['user'], password = db_con['password'])

        cursor = connection.cursor(dictionary=True)
        cursor.execute('SELECT * FROM doctor;')
        res = cursor.fetchall()

        for entry in res: 
            entry['birthdate'] = str(entry['birthdate'])

            cursor.execute('SELECT * FROM zipcode as z WHERE z.zipcode = %s;', (entry['idZipcode'],))
            entry['idZipcode'] = cursor.fetchone()
            entry['zipcode'] = entry.pop('idZipcode')

            cursor.execute('SELECT * FROM expertise WHERE idExpertise = %s', (entry['idExpertise'],))
            entry['idExpertise'] = cursor.fetchone()
            entry['expertise'] = entry.pop('idExpertise')

            file.write(f'{json.dumps(entry, ensure_ascii=False)}\n')
            
        
    finally:
        connection.close()
    