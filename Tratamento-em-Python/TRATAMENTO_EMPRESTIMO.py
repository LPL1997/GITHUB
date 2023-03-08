# BIBLIOTECAS
import pandas as pd
import openpyxl
import datetime
import numpy as np

# LER ARQUIVO
Emprestimo_df = pd.read_excel(r"C:\Users\User\Desktop\PYTHON_ATT\EMPRESTIMO.xlsx")

# CRIAR COLUNA
Emprestimo_df ['Salario'] = Emprestimo_df['ValorLimiteRcc'] / 1.6
Emprestimo_df ['Valor_emprestimo'] = Emprestimo_df ['MargemDisponivel'] / 0.02728

# CONVERTER EM DATA
Emprestimo_df['Base_in100_master.DataNascimento'] = pd.to_datetime(Emprestimo_df['Base_in100_master.DataNascimento'])

# CALCULAR IDADE
now = datetime.datetime.now().date()
Emprestimo_df['idade'] = (now - Emprestimo_df['Base_in100_master.DataNascimento'].dt.date) / np.timedelta64(1, 'Y')
Emprestimo_df['idade'] = Emprestimo_df['idade'].astype(int)

# EXCLUIR COLUNA
Emprestimo_df = Emprestimo_df.drop('teste_desconto_268', axis = 1)
Emprestimo_df = Emprestimo_df.drop('teste', axis = 1)
Emprestimo_df = Emprestimo_df.drop('Observacao', axis = 1)
Emprestimo_df = Emprestimo_df.drop('Campo0', axis = 1)
Emprestimo_df = Emprestimo_df.drop('Campo1', axis = 1)

# FILTRAR AS LINHAS ESPECIE BENEFICIO POR IDADE
linhas_remover = Emprestimo_df.loc[(Emprestimo_df['EspecieBeneficio'] == 21) & (Emprestimo_df['idade'] <= 45) | 
                                   (Emprestimo_df['EspecieBeneficio'].isin([32, 88, 92])) & (Emprestimo_df['idade'] <= 60)]

# REMOVER AS LINHAS
Emprestimo_df = Emprestimo_df.drop(linhas_remover.index)

# SALVAR O ARQUIVO FILTRADO
Emprestimo_df.to_excel(r"C:\Users\User\Desktop\PYTHON_ATT\EMPRESTIMO_filtrado.xlsx", index=False)