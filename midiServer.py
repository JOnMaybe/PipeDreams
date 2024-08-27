from flask import Flask, request, jsonify

app = Flask(__name__)

note_queue = []

@app.route('/send_note', methods=['POST'])
def send_note():
    data = request.json
    note = data.get('note')
    if note:
        note_queue.append(note)
        return "Note received", 200
    return "No note provided", 400

@app.route('/get_note', methods=['GET'])
def get_note():
    if note_queue:
        return jsonify(note_queue.pop(0))
    return "", 204  # No content

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)  # Change the port if needed
