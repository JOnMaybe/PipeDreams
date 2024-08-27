#chatGPT wrote this, not my own work
from http.server import BaseHTTPRequestHandler, HTTPServer
import mido
import requests

class MidiHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length).decode('utf-8')
        print(f"Received note: {post_data}")
        # Respond to the request
        self.send_response(200)
        self.end_headers()

def midi_note_to_name(note):
    notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    octave = (note // 12) - 1
    note_name = notes[note % 12]
    return f"{note_name}{octave}"

def send_note_to_server(note, action):
    url = '192.168.0.122:8080'  # Replace with your server IP if necessary
    data = f"{note}:{action}"
    requests.post(url, data=data)

def start_midi_server():
    server_address = ('', 8080)  # Use an available port
    httpd = HTTPServer(server_address, MidiHandler)
    print('Starting MIDI HTTP server...')
    httpd.serve_forever()

with mido.open_input('CASIO USB-MIDI 0') as inport:
    for msg in inport:
        if msg.type == 'note_on':
            note_name = midi_note_to_name(msg.note)
            print(f"Note on: {note_name}")
            send_note_to_server(note_name, 'on')
        elif msg.type == 'note_off':
            note_name = midi_note_to_name(msg.note)
            print(f"Note off: {note_name}")
            send_note_to_server(note_name, 'off')

start_midi_server()
