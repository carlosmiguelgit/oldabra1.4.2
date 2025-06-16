import re

input_path = r"C:\Users\Note\Documents\GitHub\oldabra1.4.2\data\items\items.xml"
output_path = r"C:\Users\Note\Documents\GitHub\oldabra1.4.2\data\items\items_fixed.xml"

with open(input_path, 'r', encoding='utf-8') as file:
    content = file.read()

# Regex para encontrar id="X-Y"
pattern = r'<item id="(\d+)-(\d+)"(.*?)>'
replacement = r'<item fromid="\1" toid="\2"\3>'

new_content = re.sub(pattern, replacement, content)

with open(output_path, 'w', encoding='utf-8') as file:
    file.write(new_content)

print("Correção concluída. Arquivo salvo como 'items_fixed.xml'.")
