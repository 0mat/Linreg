# Version 1

import sqlite3

conn = sqlite3.connect('star.sqlite')
conn
c = conn.cursor()
c
for row in c.execute("SELECT * FROM `starwars` WHERE (`species` = 'Droid')"):
    print(row)

# Version 2

import pandas as pd
 
query = "SELECT * FROM `starwars` WHERE (`species` = 'Droid');"
df = pd.read_sql_query(query, conn)
df
