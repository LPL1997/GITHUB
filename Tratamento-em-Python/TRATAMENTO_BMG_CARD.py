# BIBLIOTECAS
import pandas as pd
import openpyxl
import datetime
import numpy as np

# LER ARQUIVO
BMG_CARD_df = pd.read_excel(r"C:\Users\User\Desktop\PYTHON_ATT\BMG_CARD.xlsx")

# CRIAR COLUNA
BMG_CARD_df ['Salario'] = BMG_CARD_df['ValorLimiteRcc'] / 1.6
BMG_CARD_df ['Valor_saque'] = BMG_CARD_df['ValorLimiteCartao'] * 0.7

# CONVERTER EM DATA
BMG_CARD_df['DataNascimento'] = pd.to_datetime(BMG_CARD_df['DataNascimento'])

# CALCULAR IDADE
now = datetime.datetime.now().date()
BMG_CARD_df['idade'] = (now - BMG_CARD_df['DataNascimento'].dt.date) / np.timedelta64(1, 'Y')
BMG_CARD_df['idade'] = BMG_CARD_df['idade'].astype(int)

# EXCLUIR COLUNA
BMG_CARD_df = BMG_CARD_df.drop('teste_desconto_268', axis = 1)
BMG_CARD_df = BMG_CARD_df.drop('teste', axis = 1)
BMG_CARD_df = BMG_CARD_df.drop('Observacao', axis = 1)
#BMG_CARD_df = BMG_CARD_df.drop('Campo0', axis = 1)
#BMG_CARD_df = BMG_CARD_df.drop('Campo1', axis = 1)

# FILTRAR AS LINHAS ESPECIE BENEFICIO POR IDADE
linhas_remover = BMG_CARD_df.loc[(BMG_CARD_df['EspecieBeneficio'] == 21) & (BMG_CARD_df['idade'] <= 45) | 
                                   (BMG_CARD_df['EspecieBeneficio'].isin([32, 88, 92])) & (BMG_CARD_df['idade'] <= 60)]

# REMOVER AS LINHAS
BMG_CARD_df = BMG_CARD_df.drop(linhas_remover.index)

# SALVAR O ARQUIVO FILTRADO
BMG_CARD_df.to_excel(r"C:\Users\User\Desktop\PYTHON_ATT\BMG_CARD_filtrado.xlsx", index=False)