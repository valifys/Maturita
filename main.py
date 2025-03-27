from flask import Flask, jsonify, request
import mysql.connector

app = Flask(__name__)

# Konfigurace databáze
db_config = {
    'host': 'dbs.spskladno.cz',  
    'user': 'student6',  
    'password': 'spsnet', 
    'database': 'vyuka6'
}
def validation(username, password):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('''SELECT password FROM hraci WHERE username=%s''', (username,))
    correct_password=cursor.fetchone()[0]
    if correct_password==password:
        return True
    else:
        return False



# Funkce pro vytvoření připojení k databázi
def get_db_connection():
    conn = mysql.connector.connect(**db_config)
    return conn

# Vytvoření tabulky hráčů (pokud neexistuje)
def create_table():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS hraci (
            id INT AUTO_INCREMENT PRIMARY KEY,
            jmeno VARCHAR(255) NOT NULL,
            skore INT NOT NULL
        )
    ''')
    conn.commit()
    cursor.close()
    conn.close()

def get_users():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('''
        SELECT username, score FROM hraci ORDER BY score DESC LIMIT 2
    ''')
    users=cursor.fetchall()
    cursor.close()
    conn.close()
    return users

def create_user(username, password):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('''
        INSERT INTO hraci (username, password)
                   VALUES(%s, %s)
    ''',(username, password,))
    conn.commit()
    cursor.close()
    conn.close()

# Vytvoření tabulky při spuštění aplikace
with app.app_context():
    create_table()

@app.route('/users', methods=['GET'])
def get_users_endpoint():
    if request.method=="GET":
        users = get_users()
        return jsonify({'data': users})

# Endpoint pro získání skóre hráče
@app.route('/skore/<jmeno>', methods=['GET'])
def get_skore(jmeno):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT * FROM hraci WHERE jmeno = %s', (jmeno,))
    hrac = cursor.fetchone()
    cursor.close()
    conn.close()
    if hrac:
        return jsonify({'jmeno': hrac['jmeno'], 'skore': hrac['skore']})
    else:
        return jsonify({'chyba': 'Hráč nenalezen'}), 404

# Endpoint pro aktualizaci skóre hráče
@app.route('/skore/<jmeno>', methods=['PUT'])
def update_skore(jmeno):
    nove_skore = request.json.get('skore')
    if nove_skore is None:
        return jsonify({'chyba': 'Chybí skóre'}), 400

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM hraci WHERE jmeno = %s', (jmeno,))
    hrac = cursor.fetchone()
    if hrac:
        cursor.execute('UPDATE hraci SET skore = %s WHERE jmeno = %s', (nove_skore, jmeno))
    else:
        cursor.execute('INSERT INTO hraci (jmeno, skore) VALUES (%s, %s)', (jmeno, nove_skore))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({'jmeno': jmeno, 'skore': nove_skore})

@app.route("/login", methods=["POST"])
def login():
    if request.method=="POST":
        data=request.get_json()
        username=data.get("username")
        password=data.get("password")
        auth=validation(username, password)
        if auth:
            return jsonify({"success":"uzivatel prihlasen","username":username})
        else: 
            return jsonify({"chyba":"spatne jmeno nebo heslo"}), 403
        


@app.route("/register", methods=["POST"])
def register():
    if request.method=="POST":
        data=request.get_json()
        username=data.get("username")
        password=data.get("password")
        create_user(username, password)
        return jsonify({"success":"uzivatel uspesne registrovan"})

if __name__ == '__main__':
    app.run(debug=True)