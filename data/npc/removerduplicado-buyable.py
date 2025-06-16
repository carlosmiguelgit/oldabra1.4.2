import os
import xml.etree.ElementTree as ET

def remove_duplicates(shop_value):
    items = shop_value.strip().split(';')
    seen = set()
    unique_items = []
    for item in items:
        if not item.strip():
            continue
        parts = item.split(',')
        if len(parts) < 2:
            continue
        key = (parts[0].strip().lower(), parts[1].strip())
        if key not in seen:
            seen.add(key)
            unique_items.append(item)
    return ';'.join(unique_items) + ';'

def fix_npc_file(file_path):
    tree = ET.parse(file_path)
    root = tree.getroot()

    changed = False
    for param in root.findall('.//parameter[@key="shop_buyable"]'):
        old_value = param.attrib['value']
        new_value = remove_duplicates(old_value)
        if old_value != new_value:
            print(f"Corrigindo duplicados em {file_path}")
            param.set('value', new_value)
            changed = True

    if changed:
        tree.write(file_path, encoding='UTF-8', xml_declaration=True)

def main():
    folder = r'C:\Users\Note\Documents\GitHub\oldabra1.4.2\data\npc'  # caminho Windows
    for filename in os.listdir(folder):
        if filename.endswith('.xml'):
            fix_npc_file(os.path.join(folder, filename))

if __name__ == '__main__':
    main()
