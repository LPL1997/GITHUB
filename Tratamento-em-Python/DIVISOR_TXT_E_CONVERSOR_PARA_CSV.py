import os
import math
import csv

# definir o diretório dos arquivos de texto originais
input_directory = "C:\\Users\\User\\Desktop\\PYTHON_ATT\\"

# definir o diretório de saída para os arquivos divididos
output_directory = "C:\\Users\\User\\Desktop\\PYTHON_ATT\\whats_dividido_csv_2"

# definir o número de partes em que os arquivos serão divididos
num_parts = 4

# criar o diretório de saída se ele ainda não existir
if not os.path.exists(output_directory):
    os.makedirs(output_directory)

# percorrer todos os arquivos de texto na pasta de entrada
for filename in os.listdir(input_directory):
    # ignorar arquivos que não são de texto
    if not filename.endswith(".txt"):
        continue
    
    # obter o caminho completo para o arquivo de texto
    filepath = os.path.join(input_directory, filename)
    
    # abrir o arquivo de texto original para leitura
    with open(filepath, "r") as f:
        # ler todo o conteúdo do arquivo
        text = f.read()
        
        # dividir o texto em partes iguais
        part_size = math.ceil(len(text) / num_parts)
        parts = [text[i:i+part_size] for i in range(0, len(text), part_size)]
        
        # salvar cada parte em um arquivo separado
        for i, part in enumerate(parts):
            # criar o nome do arquivo de saída com a extensão .csv
            base_filename, extension = os.path.splitext(filename)
            output_filename = f"{base_filename}_part{i+1}.csv"
            
            # criar o caminho completo para o arquivo de saída
            output_filepath = os.path.join(output_directory, output_filename)
            
            # escrever a parte em um arquivo CSV separado
            with open(output_filepath, "w", newline='') as f_out:
                writer = csv.writer(f_out)
                writer.writerow(["part"])
                writer.writerow([part])