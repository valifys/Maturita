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

# Vytvoření tabulky při spuštění aplikace
with app.app_context():
    create_table()

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

if __name__ == '__main__':
    app.run(debug=True)