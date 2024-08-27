import mido
import requests
import time

# Function to convert MIDI note number to note name
def midi_note_to_name(note):
    notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    octave = (note // 12) - 1
    note_name = notes[note % 12]
    if note_name in ['A', 'A#', 'B']:
        octave += 1
    return f"{note_name}{octave}"

# Track pressed keys
pressed_keys = set()

def update_pressed_keys(msg, add=True):
    note_name = midi_note_to_name(msg.note)
    if add:
        pressed_keys.add(note_name)
    else:
        pressed_keys.discard(note_name)

def send_keys_to_server():
    url = "http://192.168.0.131:5000/send_note"  # Replace with your server's IP
    if pressed_keys:
        keys_list = ",".join(sorted(pressed_keys))
    else:
        keys_list = "@"
    data = {'note': keys_list}

    print(f"Sending data: {data}")  # Debugging output

    try:
        response = requests.post(url, json=data)
        response.raise_for_status()
    except requests.exceptions.RequestException as e:
        print(f"Error sending note to server: {e}")

# Main loop to capture MIDI input and send notes
with mido.open_input('CASIO USB-MIDI 0') as inport:
    while True:
        for msg in inport.iter_pending():
            if msg.type == 'note_on':
                update_pressed_keys(msg, add=True)
            elif msg.type == 'note_off':
                update_pressed_keys(msg, add=False)
        
        send_keys_to_server()
        time.sleep(0.1)  # Adjust the delay as needed
