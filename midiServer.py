from flask import Flask, request, jsonify

app = Flask(__name__)

note_queue = []

@app.route('/send_note', methods=['POST'])
def send_note():
    data = request.json
    if 'note' in data:
        note = data['note']
        print(f"Received data: {note}")  # Debugging output
        note_queue.append(note)
        return "Note received", 200
    return "Invalid request", 400

@app.route('/get_note', methods=['GET'])
def get_note():
    if note_queue:
        note = note_queue.pop(0)
        return note  # Return raw note without quotes
    return "", 204  # No content

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)  # Change the port if needed
