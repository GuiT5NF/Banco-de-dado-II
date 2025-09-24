from faker import Faker
import random
from datetime import datetime, timedelta


def gerar_script_sql(nome_do_arquivo="dados_mercado_financeiro.sql"):
    """
    Gera um arquivo .sql com comandos INSERT para todas as tabelas do
    banco de dados Mercado_Financeiro.
    """
    fake = Faker('pt_BR')

    # Listas para armazenar os IDs gerados para as chaves estrangeiras
    setor_ids = []
    pais_ids = []
    empresas_ids = []
    indices_ids = []

    # Dicionário para armazenar os tickers das empresas
    empresas_tickers = {}

    # Definindo as datas de início e fim como objetos datetime.date
    data_inicio_base = datetime(2025, 8, 27).date()
    data_fim_base = datetime(2025, 9, 10).date()

    with open(nome_do_arquivo, 'w', encoding='utf-8') as arquivo:
        # Adiciona um cabeçalho ao arquivo SQL
        arquivo.write("-- Script SQL para popular o banco de dados 'Mercado_Financeiro'\n\n")

        # ==========================================================
        # 1. Popula a tabela 'pais'
        # ==========================================================
        arquivo.write("-- Inserindo dados na tabela 'pais'\n")
        paises_nomes = ["Brasil", "Estados Unidos", "Japão", "Reino Unido", "China", "Alemanha", "França"]
        for i, nome_pais in enumerate(paises_nomes):
            id_pais = i + 1
            pais_ids.append(id_pais)
            sql_insert = f"INSERT INTO pais (id_pais, nome_pais) VALUES ({id_pais}, '{nome_pais}');\n"
            arquivo.write(sql_insert)
        arquivo.write("\n")
        print(f"Inseridos {len(pais_ids)} países.")

        # ==========================================================
        # 2. Popula a tabela 'setor'
        # ==========================================================
        arquivo.write("-- Inserindo dados na tabela 'setor'\n")
        # Lista de setores atualizada conforme solicitado pelo usuário
        setores_dados = {
            "Bens industriais": "Empresas do setor de bens e serviços industriais.",
            "Comunicações": "Empresas de telecomunicações e serviços de mídia.",
            "Imobiliário": "Empresas do setor de desenvolvimento e exploração de imóveis.",
            "Consumo cíclico": "Empresas com negócios que variam com o ciclo econômico.",
            "Consumo não cíclico": "Empresas de bens e serviços essenciais, menos afetadas por ciclos econômicos.",
            "Financeiro": "Bancos, seguradoras e serviços financeiros.",
            "Materiais básicos": "Empresas de mineração, celulose e siderurgia.",
            "Petróleo, gás e biocombustíveis": "Empresas do setor de energia.",
            "Saúde": "Empresas farmacêuticas, hospitais e de equipamentos médicos.",
            "Tecnologia da Informação": "Empresas de software, hardware e serviços de TI.",
            "Utilidade pública": "Empresas de serviços essenciais, como água, luz e saneamento."
        }
        for i, (nome, descricao) in enumerate(setores_dados.items()):
            id_setor = i + 1
            setor_ids.append(id_setor)
            sql_insert = f"INSERT INTO setor (id_setor, nome_setor, descricao) VALUES ({id_setor}, '{nome}', '{descricao}');\n"
            arquivo.write(sql_insert)
        arquivo.write("\n")
        print(f"Inseridos {len(setor_ids)} setores.")

        # ==========================================================
        # 3. Popula a tabela 'dados_economicos'
        # ==========================================================
        arquivo.write("-- Inserindo dados na tabela 'dados_economicos'\n")
        tipos_dados = ["Inflação", "PIB", "Taxa de Juros", "Taxa de Desemprego"]
        for i in range(1, 201):
            data = fake.date_between(start_date=data_inicio_base, end_date=data_fim_base).isoformat()
            tipo_dado = random.choice(tipos_dados)
            valor = round(random.uniform(0.5, 15.0), 2)
            sql_insert = f"INSERT INTO dados_economicos (id_dados_economicos, data, tipo_dado, valor) VALUES ({i}, '{data}', '{tipo_dado}', {valor});\n"
            arquivo.write(sql_insert)
        arquivo.write("\n")
        print("Inseridos 200 dados econômicos.")

        # ==========================================================
        # 4. Popula a tabela 'empresas'
        # ==========================================================
        arquivo.write("-- Inserindo dados na tabela 'empresas'\n")
        for i in range(1, 101):
            id_empresas = i
            empresas_ids.append(id_empresas)
            nome = fake.company().replace("'", "''")
            ticker = ''.join(random.choices('ABCDEFGHIJKLMNOPQRSTUVWXYZ', k=4)) + random.choice(
                ['3', '4', '5', '6', '11'])
            empresas_tickers[id_empresas] = ticker
            setor_id_setor = random.choice(setor_ids)
            sql_insert = f"INSERT INTO empresas (id_empresas, nome, ticker, setor_id_setor) VALUES ({id_empresas}, '{nome}', '{ticker}', {setor_id_setor});\n"
            arquivo.write(sql_insert)
        arquivo.write("\n")
        print("Inseridas 100 empresas.")

        # ==========================================================
        # 5. Popula a tabela 'indices'
        # ==========================================================
        arquivo.write("-- Inserindo dados na tabela 'indices'\n")
        indices_nomes_siglas = {
            "Bovespa": "IBOV",
            "S&P 500": "SPX",
            "NASDAQ Composite": "COMP",
            "Nikkei 225": "NIKK",
            "FTSE 100": "UKX"
        }
        for i, (nome_indice, sigla) in enumerate(indices_nomes_siglas.items()):
            id_indices = i + 1
            indices_ids.append(id_indices)
            pais_id_pais = random.choice(pais_ids)
            sql_insert = f"INSERT INTO indices (id_indices, nome_indices, sigla, pais_id_pais) VALUES ({id_indices}, '{nome_indice}', '{sigla}', {pais_id_pais});\n"
            arquivo.write(sql_insert)
        arquivo.write("\n")
        print("Inseridos 5 índices.")

        # ==========================================================
        # 6. Popula a tabela 'cotacoes_historicos'
        # ==========================================================
        arquivo.write("-- Inserindo dados na tabela 'cotacoes_historicos'\n")
        id_cotacoes = 1

        dias_no_intervalo = (data_fim_base - data_inicio_base).days + 1
        for empresas_id in empresas_ids:
            for i in range(dias_no_intervalo):
                data_cotacao = (data_inicio_base + timedelta(days=i)).isoformat()

                # Gerando preços realistas (abertura, fechamento, maximo, minimo)
                abertura = round(random.uniform(10.0, 500.0), 2)
                fechamento = round(random.uniform(abertura * 0.9, abertura * 1.1), 2)
                maximo = max(abertura, fechamento, round(random.uniform(abertura, abertura * 1.15), 2))
                minimo = min(abertura, fechamento, round(random.uniform(abertura * 0.85, abertura), 2))

                volume = fake.random_int(min=100000, max=50000000)

                sql_insert = f"INSERT INTO cotacoes_historicos (id_cotacoes, empresas_id_empresas, data_cotacao, abertura, fechamento, maximo, minimo, volume) VALUES ({id_cotacoes}, {empresas_id}, '{data_cotacao}', {abertura}, {fechamento}, {maximo}, {minimo}, '{volume}');\n"
                arquivo.write(sql_insert)
                id_cotacoes += 1

        print(f"Inseridas {id_cotacoes - 1} cotações históricas.")
        arquivo.write("\n")

        # ==========================================================
        # 7. Popula a tabela 'cotacoes_indices'
        # ==========================================================
        arquivo.write("-- Inserindo dados na tabela 'cotacoes_indices'\n")
        id_cotacoes_indices = 1
        for _ in range(2000):
            indices_id = random.choice(indices_ids)
            data_cotacao = fake.date_between(start_date=data_inicio_base, end_date=data_fim_base).isoformat()

            abertura = round(random.uniform(5000.0, 35000.0), 2)
            fechamento = round(random.uniform(abertura * 0.95, abertura * 1.05), 2)
            maximo = max(abertura, fechamento, round(random.uniform(abertura, abertura * 1.07), 2))
            minimo = min(abertura, fechamento, round(random.uniform(abertura * 0.93, abertura), 2))

            sql_insert = f"INSERT INTO cotacoes_indices (id_cotacoes_indices, indices_id_indice, data_cotacao, abertura, fechamento, maximo, minimo) VALUES ({id_cotacoes_indices}, {indices_id}, '{data_cotacao}', {abertura}, {fechamento}, {maximo}, {minimo});\n"
            arquivo.write(sql_insert)
            id_cotacoes_indices += 1
        arquivo.write("\n")
        print(f"Inseridas {id_cotacoes_indices - 1} cotações de índices.")

        # ==========================================================
        # 8. Popula a tabela 'composicao_indices'
        # ==========================================================
        arquivo.write("-- Inserindo dados na tabela 'composicao_indices'\n")
        id_composicao = 1
        for indice_id in indices_ids:
            # Seleciona algumas empresas para cada índice
            empresas_do_indice = random.sample(empresas_ids, k=random.randint(5, 20))
            for empresa_id in empresas_do_indice:
                peso = str(round(random.uniform(0.1, 10.0), 2)) + '%'
                data_inicio_item = fake.date_between(start_date=data_inicio_base, end_date=data_fim_base).isoformat()
                data_fim_item = fake.date_between(start_date=data_inicio_base, end_date=data_fim_base).isoformat()

                sql_insert = f"INSERT INTO composicao_indices (id_composicao, empresas_id_empresas, indices_id_indice, peso, data_inicio, data_fim) VALUES ('{id_composicao}', {empresa_id}, {indice_id}, '{peso}', '{data_inicio_item}', '{data_fim_item}');\n"
                arquivo.write(sql_insert)
                id_composicao += 1
        arquivo.write("\n")
        print(f"Inseridas {id_composicao - 1} composições de índices.")

    print(f"Processo concluído. O arquivo '{nome_do_arquivo}' foi gerado.")
    print(
        "Você pode abrir este arquivo, copiar e colar o conteúdo no seu cliente de banco de dados para popular as tabelas.")


if __name__ == "__main__":
    gerar_script_sql()
