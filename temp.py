import mido

# List available MIDI input ports
print("Available MIDI input ports:")
for port in mido.get_input_names():
    print(port)
