import xml.etree.ElementTree as ET
import csv
import os

def normalize_name(name):
    return ''.join(name.lower().split())

def extract_items(xml_path, output_csv):
    tree = ET.parse(xml_path)
    root = tree.getroot()

    with open(output_csv, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['name', 'normalized_name', 'id'])

        for item in root.findall('item'):
            item_id = item.get('id')
            item_name = item.get('name')
            if item_id and item_name:
                norm_name = normalize_name(item_name)
                writer.writerow([item_name, norm_name, item_id])

if __name__ == '__main__':
    # Ajuste aqui seu caminho do items.xml
    items_xml_path = r"C:\Users\Note\Documents\GitHub\oldabra1.4.2\data\items\items.xml"
    output_csv_path = os.path.join(os.path.dirname(items_xml_path), 'items_extracted.csv')
    extract_items(items_xml_path, output_csv_path)
    print(f"Extração concluída! Arquivo gerado: {output_csv_path}")
