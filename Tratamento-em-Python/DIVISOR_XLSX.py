# BIBLIOTECAS
import pandas as pd

# carregar o arquivo .xlsx em um dataframe
df = pd.read_excel(r"C:\Users\User\Desktop\PYTHON_ATT\EMPRESTIMO_filtrado.xlsx")

# identificar o número de linhas no dataframe
num_linhas = df.shape[0]

# dividir o número de linhas pelo número de partes desejadas
num_partes = 2
tamanho_parte = num_linhas // num_partes

# criar as partes e salvar cada uma como um arquivo .xlsx separado
for i in range(num_partes):
    inicio = i * tamanho_parte
    fim = inicio + tamanho_parte
    df_parte = df.iloc[inicio:fim]
    df_parte.to_excel(f"./parte_{i+1}.xlsx", index=False)