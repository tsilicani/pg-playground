import yfinance as yf
import psycopg2
from datetime import datetime

# Download all available data
msci_world = yf.Ticker("SWDA.MI")
df = msci_world.history(period="max")

# Connect to the database
print("Connecting to database...")
conn = psycopg2.connect(
    dbname="postgres",
    user="postgres",
    password="postgres",
    host="localhost",
    port="5432"
)

# Insert data
try:
    cur = conn.cursor()
    print(f"Inserting {len(df)} records for SWDA.MI...")
    start_time = datetime.now()
    for idx, row in df.iterrows():
        close = float(row['Close'])
        cur.execute(
            "INSERT INTO etf_data (time, close) VALUES (%s, %s)",
            (idx, close)
        )
    conn.commit()
finally:
    cur.close()
    conn.close()
