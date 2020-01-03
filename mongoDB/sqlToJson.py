import mysql.connector as MySQL
from config import db_con
import json
import threading
import time
import codecs
import platform, os

OUTPUT_FILES = ['doctors.json', 'athletes.json', 'appointments.json']

# Clear command line
if platform.system() == "Windows":
	os.system("cls")


print(f'Ficheiros de Output: {", ".join(OUTPUT_FILES[:len(OUTPUT_FILES) - 1])} e {OUTPUT_FILES[len(OUTPUT_FILES) - 1]}.\n')
print('SQL connection: \n')
print(f'\tHOST: {db_con["host"]}')
print(f'\tUSER: {db_con["user"]}')
print(f'\tDATABASE: {db_con["database"]}\n')

print('Gerando JSON ...\n')


# ---------------- ANIMATION ------------------------------
complete = False

def animation():
	animation = "|/-\\"
	idx = 0
	while not complete:
	    print(animation[idx % len(animation)], end="\r")
	    idx += 1
	    time.sleep(0.1)

animation_func = threading.Thread(target=animation)
animation_func.start()

# --------------------------------------------------------


# ---------------------- Gerar JSON ----------------------

try:
    connection = MySQL.connect(host = db_con['host'], database = db_con['database'], user = db_con['user'], password = db_con['password'])

    cursor = connection.cursor(dictionary=True)
    cursor.execute('SELECT * FROM doctor;')
    res = cursor.fetchall()

    with codecs.open('doctors.json', 'w','utf-8') as file:
        for entry in res: 
            entry['birthdate'] = str(entry['birthdate'])

            cursor.execute('SELECT * FROM zipcode as z WHERE z.zipcode = %s', (entry['idZipcode'],))
            entry['idZipcode'] = cursor.fetchone()
            entry['zipcode'] = entry.pop('idZipcode')

            cursor.execute('SELECT * FROM expertise WHERE idExpertise = %s', (entry['idExpertise'],))
            entry['idExpertise'] = cursor.fetchone()
            entry['expertise'] = entry.pop('idExpertise')

            file.write(f'{json.dumps(entry, ensure_ascii=False)}\n')
        file.close()

    cursor.execute('SELECT * FROM athlete')
    res = cursor.fetchall()

    with codecs.open('athletes.json', 'w','utf-8') as file:
        for entry in res:
            entry['birthdate'] = str(entry['birthdate'])
            entry['weight'] = float(entry['weight'])

            cursor.execute('SELECT * FROM zipcode as z WHERE z.zipcode = %s', (entry['idZipcode'],))
            entry['idZipcode'] = cursor.fetchone()
            entry['zipcode'] = entry.pop('idZipcode')

            cursor.execute('SELECT * FROM club where idClub = %s', (entry['idClub'],))
            entry['idClub'] = cursor.fetchone()
            entry['club'] =  entry.pop('idClub')

            cursor.execute('SELECT * FROM category where idCategory = %s', (entry['idCategory'],))
            entry['idCategory'] = cursor.fetchone()
            entry['category'] =  entry.pop('idCategory')

            cursor.execute('SELECT * FROM modality where idModality = %s', (entry['idModality'],))
            entry['idModality'] = cursor.fetchone()
            entry['modality'] =  entry.pop('idModality')

            file.write(f'{json.dumps(entry, ensure_ascii=False)}\n')
        file.close()

    cursor.execute('SELECT * FROM appointment')
    res = cursor.fetchall()

    with codecs.open('appointments.json', 'w', 'utf-8') as file:
        for entry in res:

            entry['dateAppointment'] = str(entry['dateAppointment'])
            entry['price'] = float(entry['price'])

            # --------------------- ATLETA ---------------------

            cursor.execute('SELECT * FROM athlete WHERE idAthlete = %s', (entry['idAthlete'],))
            atl = cursor.fetchone()

            atl['birthdate'] = str(atl['birthdate'])
            atl['weight'] = float(atl['weight'])

            cursor.execute('SELECT * FROM zipcode as z WHERE z.zipcode = %s', (atl['idZipcode'],))
            atl['idZipcode'] = cursor.fetchone()
            atl['zipcode'] = atl.pop('idZipcode')

            cursor.execute('SELECT * FROM club where idClub = %s', (atl['idClub'],))
            atl['idClub'] = cursor.fetchone()
            atl['club'] =  atl.pop('idClub')

            cursor.execute('SELECT * FROM category where idCategory = %s', (atl['idCategory'],))
            atl['idCategory'] = cursor.fetchone()
            atl['category'] =  atl.pop('idCategory')

            cursor.execute('SELECT * FROM modality where idModality = %s', (atl['idModality'],))
            atl['idModality'] = cursor.fetchone()
            atl['modality'] =  atl.pop('idModality')

            entry['idAthlete'] = atl
            entry['athlete'] = entry.pop('idAthlete')

            # --------------------------------------------------
            # --------------------- DOCTOR ---------------------

            cursor.execute('SELECT * FROM doctor WHERE idDoctor = %s', (entry['idDoctor'],))
            dct = cursor.fetchone()

            dct['birthdate'] = str(dct['birthdate'])

            cursor.execute('SELECT * FROM zipcode as z WHERE z.zipcode = %s', (dct['idZipcode'],))
            dct['idZipcode'] = cursor.fetchone()
            dct['zipcode'] = dct.pop('idZipcode')

            cursor.execute('SELECT * FROM expertise WHERE idExpertise = %s', (dct['idExpertise'],))
            dct['idExpertise'] = cursor.fetchone()
            dct['expertise'] = dct.pop('idExpertise')

            entry['idDoctor'] = dct
            entry['doctor'] = entry.pop('idDoctor')

            # --------------------------------------------------
            
            file.write(f'{json.dumps(entry, ensure_ascii=False)}\n')
            

finally:
    connection.close()
    complete = True
    animation_func.join()
    

print('Ficheiros criados com sucesso!')