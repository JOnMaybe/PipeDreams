import mido
import requests

# Function to convert MIDI note number to note name
def midi_note_to_name(note):
    notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    octave = (note // 12) - 1
    note_name = notes[note % 12]
    return f"{note_name}{octave}"

def send_note_to_server(note_name):
    url = "http://192.168.0.131:5000/send_note"  # Replace with your server's IP
    data = {'note': note_name}
    try:
        response = requests.post(url, json=data)
        response.raise_for_status()
    except requests.exceptions.RequestException as e:
        print(f"Error sending note to server: {e}")

# Main loop to capture MIDI input and send notes
with mido.open_input('CASIO USB-MIDI 0') as inport:
    for msg in inport:
        if msg.type == 'note_on':
            note_name = midi_note_to_name(msg.note)
            print(f"Sending note: {note_name}")
            send_note_to_server(note_name)
