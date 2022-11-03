# import socket
# from datetime import datetime

# date_time = datetime.now()
# timestamp = datetime.timestamp(date_time)

# print("Date and time is ", date_time)
# print("Timestamp is ", timestamp)
# print("Hostname is " + socket.gethostname())

from flask import Flask
import os
import socket
from datetime import datetime

app = Flask(__name__)

@app.route("/")
def hello_world():
    date_time = datetime.now()
    timestamp = datetime.timestamp(date_time)
    hostname  = socket.gethostname()
    return ("Date: " + str(date_time ) + "<br/>Timestamp: " +str(timestamp) + "<br/>Hostname: " + str(hostname) )

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 4000))
    app.run(debug=True, host='0.0.0.0', port=port)