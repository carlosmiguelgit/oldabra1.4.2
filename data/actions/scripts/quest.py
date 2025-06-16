import re
import csv
import os

def normalize_name(name):
    return ''.join(name.lower().split())

def load_item_ids(csv_path):
    item_map = {}
    with open(csv_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            norm_name = row['normalized_name']
            item_id = row['id']
            item_map[norm_name] = item_id
    return item_map

def replace_cf_vars_in_script(script_path, item_map, output_path):
    with open(script_path, 'r', encoding='utf-8') as f:
        script_text = f.read()

    # Regex para encontrar variáveis que começam com Cf + palavra com letras e números
    pattern = re.compile(r'\bCf([A-Za-z0-9_]+)\b')

    def replacer(match):
        var_name = match.group(1)  # exemplo: noblearmor
        norm_name = normalize_name(var_name)
        if norm_name in item_map:
            return item_map[norm_name]
        else:
            print(f"Variável Cf{var_name} não encontrada no CSV.")
            return match.group(0)  # deixa original se não achar

    new_script = pattern.sub(replacer, script_text)

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(new_script)

    print(f"Substituição concluída! Arquivo salvo em {output_path}")

if __name__ == '__main__':
    items_csv = r"C:\Users\Note\Documents\GitHub\oldabra1.4.2\data\items\items_extracted.csv"
    quest_script = r"C:\Users\Note\Documents\GitHub\oldabra1.4.2\data\actions\scripts\quest.lua"
    output_script = r"C:\Users\Note\Documents\GitHub\oldabra1.4.2\data\actions\scripts\quest_converted.lua"

    item_map = load_item_ids(items_csv)
    replace_cf_vars_in_script(quest_script, item_map, output_script)
