# Import mysql-connector-python to connect to the MySQL database
# Import traceback to display detailed error information
# Import DB_CONFIG variables from /config/database.py
import mysql.connector
import traceback
from config.database import DB_CONFIG

# Global variable
connection = None

# Function to connect to the database
# Returns:
# - If success: connection object
# - If error: None
def connect_to_database():
    global connection
    try :
        # Database information
        connection = mysql.connector.connect(
            **DB_CONFIG
        )

        if connection.is_connected():
            print("Connected to database")
            return connection

    except Exception as err:
        print("Failed connecting to database: {}".format(err))
        traceback.print_exc()

# Function that contains all execute logic
# - command: SQL command to execute
# - values: data needed for the command
# - is_insert: needed to know the id just created by the command
# Returns:
# - If insert: created row ID
# - If select: fetched results
# - If update: number of affected rows
# - If error: None
def execute_command(command, values=None, is_insert=False ):
    global connection
    # Check for connection availability, if no connection, try to reconnect
    if connection is None or not connection.is_connected():
        print("Connection lost or not initialized. Reconnecting...")
        connection = connect_to_database()
    # If after the check connection is still None
    if connection is None:
        print("Error connecting to MySQL database")
        return None
    # Cursor helps to execute SQL commands
    cursor = connection.cursor(dictionary=True)
    try:
        # If there is no values, we send empty
        cursor.execute(command, values or ())
        # If command is an insert, we return the id just created
        if is_insert:
            result = cursor.lastrowid
        # If command is a select, we return the list or item selected
        elif command.strip().upper().startswith("SELECT") :
            result = cursor.fetchall()
        # If command is an update, we return the number of affected rows
        else :
            result = cursor.rowcount
        connection.commit()
        return result
    except Exception as err:
        print(f"Failed executing command: {command}. Error: {err}")
        traceback.print_exc()
        connection.rollback()
        return None
    finally:
        cursor.close()


# SSH connection:
# If we want to connect to a distant database server, we can use an SSH tunnel (sshtunnel library).
# In this way, instead of using the database port (which is risky for malicious users), we can use the SSH port forwarding (port 22) in a secure way:
# - We create a tunnel between our computer and the database server by using the SSH protocol
# - We code a Python script that connects to the SSH tunnel just created
# - The database thinks the connection is local, but in reality data is transferred through the SSH tunnel to the database server
