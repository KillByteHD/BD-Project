from bs4 import BeautifulSoup
import requests
from pathlib import Path
import random

# Dados Iniciais
random.seed()

categorias = ["Escolinhas", "Infantis", "Juvenis", "Juniores", "Seniores"]
cidades = ["Angra do Heroísmo", "Praia da Vitória", "Ponta Delgada", "Lisboa", "Porto", "Funchal", "Coimbra", "Braga", "Faro", "Portimão", "Vila Real", "Alentejo", "Santarém", "Aveiro", "Beja", "Vila do Conde", "Paris", "Angola", "Londres", "Praga", "Bélgica", "Moçambique"]
zipcodes = [f'{random.randint(1000,9999)}-{random.randint(100,999)}' for i in range (len(cidades))]
medicos = ["Asi Lucas", "Belchior Telles", "Boaventura Quintana", "Clarisse Mantas", "Collin Guterres", "Dora García", "Dorindo Naves", "Dulce Barra", "Fulvio Andrade", "Guiomar Saraíba", "Gávio Estrada", "Higino Tabosa", "Iberê Penteado", "Laurinda Gomes", "Levi Tamoio", "Natália Bento", "Noémia Imbassaí","Paula Alcantara", "Quintilien Lago", "Raul Negromonte"]
clubes = ["SL Benfica", "FC Porto", "Sporting CP", "Boavista FC", "SC Braga", "Vitória S.C.", "FC Paços de Ferreira","Vitória de Setúbal","CS Marítimo"	,"Belenenses","CD Nacional"	,"G.D. CUF"	,"Académica","UD Leiria","Leixões SC","SC Beira Mar","SC Salgueiros","Portimonense SC","GD Chaves","SC Farense","Rio Ave","Estrela da Amadora","CD Santa Clara","FC Barreirense"]
modalidades_nomes = []
atletas_nomes = []
especialidades = ["Anatomia Patológica", "Anestesiologia", "Cardiologia", "Cirurgia Geral", "Medicina Desportiva", "Medicina Física e de Reabilitação", "Ortopedia", "Psiquiatria", "Radiologia", "Reumatologia"]


# Requests

try:

	site_1 = requests.get("http://www.idesporto.pt/ListaAtletas.aspx")
	site_2 = requests.get("https://regrasdoesporte.com.br/atletismo-regras-modalidades-corrida-arremessos-e-regras.html")

	site_1.raise_for_status()
	site_2.raise_for_status()

except HTTPError as err:
	print(f'HTTP Error: {err}')

except Exception:
	print(f'Not an HTTP Error: {err}')

else:
	print("Sites encontrados e disponíveis!")

# BeautifulSoup

atletas = []
modalidades = []

soup_1 = BeautifulSoup(site_1.text, 'html.parser')
soup_2 = BeautifulSoup(site_2.text, 'html.parser')
print("Sites processados com bs4!")

atletas = soup_1.find('table').find_all('tr')
modalidades = soup_2.find_all('strong')[1:len(modalidades)-4]

# File

my_file_1 = Path("atletas.txt")
my_file_2 = Path("modalidades.txt")

if my_file_1.exists() and my_file_2.exists():
	with open('atletas.txt', 'w') as file:
		file.write('')

	with open('modalidades.txt', 'w') as file:
		file.write('')

# Escrever os nomes em ficheiros.

for atleta in atletas[1:]:
	nome = atleta.find_all('td')[1].get_text()
	capitalized = list(map(lambda x: x.capitalize(), nome.split()))
	good_name = ' '.join(capitalized)
	
	atletas_nomes.append(good_name)

	with open('atletas.txt', 'a') as file:
		file.write(good_name + '\n')

print("Atletas escritos em atletas.txt!")

for modalidade in modalidades:
	capitalized = list(map(lambda x: x.capitalize(), modalidade.get_text().split()))
	good_name = ' '.join(capitalized)

	modalidades_nomes.append(good_name)

	with open('modalidades.txt', 'a') as file:
		file.write(good_name + '\n')

# Modalidades em Falta

modalidades_nomes.append("Lançamento")

with open('modalidades.txt', 'a') as file:
		file.write("Lançamento")
	

print("Modalidades escritas em modalidades.txt!")

# Gerar SQL

i = 0

with open('db_populate.sql', 'w') as file:
	# Clubes
	file.write("/* Inserir os Clubes na tabela \"club\" */\n")
	file.write("INSERT INTO club (idClub, name)\nVALUES\n")
	for clube in clubes:
		if (i == len(clubes) - 1):
			file.write(f'\t({i}, \'{clube}\');\n')

		else:
			file.write(f'\t({i}, \'{clube}\'),\n')

		i += 1

	# Modalidades
	i = 0
	file.write("\n/* Inserir as Modalidades na tabela \"modality\" */\n")
	file.write("INSERT INTO modality (idModality, name)\nVALUES\n")
	for modalidade in modalidades_nomes:
		if (i == len(modalidades_nomes) - 1):
			file.write(f'\t({i}, \'{modalidade}\');\n\n')

		else:
			file.write(f'\t({i}, \'{modalidade}\'),\n')

		i += 1

	# Especialidades 
	i = 0
	file.write("/* Inserir as Especialidades na tabela \"expertise\" */\n")
	file.write("INSERT INTO expertise (idExpertise, designation)\nVALUES\n")
	for especialidade in especialidades:
		if (i == len(especialidades) - 1):
			file.write(f'\t({i}, \'{especialidade}\');\n\n')

		else:
			file.write(f'\t({i}, \'{especialidade}\'),\n')

		i += 1

	# Código Postal
	i = 0
	file.write("/* Inserir os Códigos Postais na tabela \"zipcode\" */\n")
	file.write("INSERT INTO zipcode (zipcode, city)\nVALUES\n")
	for zipcode in zipcodes:
		if (i == len(zipcodes) - 1):
			file.write(f'\t({zipcode}, \'{cidades[random.randint(0, len(zipcodes) - 1)]}\');\n\n')

		else:
			file.write(f'\t({zipcode}, \'{cidades[random.randint(0, len(zipcodes) - 1)]}\'),\n')

		i += 1

	# Categorias
	i = 0
	file.write("/* Inserir as Categorias na tabela \"category\" */\n")
	file.write("INSERT INTO category (idCategory, name)\nVALUES\n")
	for categoria in categorias:
		if (i == len(categorias) - 1):
			file.write(f'\t({i}, \'{categoria}\');\n\n')

		else:
			file.write(f'\t({i}, \'{categoria}\'),\n')

		i += 1

	# Médicos
	i = 0
	file.write("/* Inserir os Médicos na tabela \"doctor\" */\n")
	file.write("INSERT INTO doctor (idDoctor, birthdate, name, idZipcode, cellphone, idExpertise)\nVALUES\n")
	for medico in medicos:
		ano = random.randint(1970,1989)
		mes = random.randint(1,12)
		dias = random.randint(1,28)

		if dias < 10 and mes < 10:
			birthdate = f'{ano}-0{mes}-0{dias}'
		elif dias < 10 and mes >= 10:
			birthdate = f'{ano}-{mes}-0{dias}'
		elif dias >= 10 and mes < 10:
			birthdate = f'{ano}-0{mes}-{dias}'
		else:
			birthdate = f'{ano}-{mes}-{dias}'



		if (i == len(medicos) - 1):
			file.write(f'\t({i}, \'{birthdate}\', \'{medico}\', \'{zipcodes[random.randint(0, len(cidades) - 1)]}\', 91{random.randint(1000000,9999999)}, {random.randint(0, len(especialidades) - 1)});\n\n')

		else:
			file.write(f'\t({i}, \'{birthdate}\', \'{medico}\', \'{zipcodes[random.randint(0, len(cidades) - 1)]}\', 91{random.randint(1000000,9999999)}, {random.randint(0, len(especialidades) - 1)}),\n')

		i += 1

	# Atletas
	i = 0
	file.write("/* Inserir os Atletas na tabela \"athlete\" */\n")
	file.write("INSERT INTO doctor (idAthlete, name, birthdate, weight, idModality, idCategory, idClub, idZipcode)\nVALUES\n")
	for nome in atletas_nomes:
		ano = random.randint(1990,2019)
		mes = random.randint(1,12)
		dias = random.randint(1,28)

		if dias < 10 and mes < 10:
			birthdate = f'{ano}-0{mes}-0{dias}'
		elif dias < 10 and mes >= 10:
			birthdate = f'{ano}-{mes}-0{dias}'
		elif dias >= 10 and mes < 10:
			birthdate = f'{ano}-0{mes}-{dias}'
		else:
			birthdate = f'{ano}-{mes}-{dias}'

		if (i == len(atletas_nomes) - 1):
			file.write(f'\t({i}, \'{nome}\', \'{birthdate}\', {round(random.uniform(40,120), 1)}, {random.randint(0, len(modalidades_nomes) - 1)}, {random.randint(0, len(categorias) - 1)}, {random.randint(0, len(clubes) - 1)}, \'{zipcodes[random.randint(0, len(zipcodes) - 1)]}\');\n\n')

		else:
			file.write(f'\t({i}, \'{nome}\', \'{birthdate}\', {round(random.uniform(40,120), 1)}, {random.randint(0, len(modalidades_nomes) - 1)}, {random.randint(0, len(categorias) - 1)}, {random.randint(0, len(clubes) - 1)}, \'{zipcodes[random.randint(0, len(zipcodes) - 1)]}\'),\n')

		i += 1

	# Consultas
	i = 0
	number = 400
	file.write("/* Inserir as Consultas na tabela \"appointment\" */\n")
	file.write("INSERT INTO appointment (idDoctor, idAthlete, observations, price, date, finished)\nVALUES\n")
	for i in range(number):
		ano = random.randint(1990,2019)
		mes = random.randint(1,12)
		dias = random.randint(1,28)
		horas = random.randint(10,24)
		minutos = random.randint(0, 60)
		segundos = random.randint(0,60)


		if dias < 10 and mes < 10:
			date = f'{ano}-0{mes}-0{dias}'
		elif dias < 10 and mes >= 10:
			date = f'{ano}-{mes}-0{dias}'
		elif dias >= 10 and mes < 10:
			date = f'{ano}-0{mes}-{dias}'
		else:
			date = f'{ano}-{mes}-{dias}'

		datetime = f'{date} {horas}-{minutos if minutos > 9 else "0" + str(minutos)}-{segundos if segundos > 9 else "0" + str(segundos)}'

		if (i == number - 1):
			file.write(f'\t({random.randint(0, len(medicos) - 1)}, {random.randint(0, len(atletas_nomes) - 1)}, \'Nada a declarar.\', {round(random.uniform(10,1000), 2)}, \'{datetime}\', {random.randint(0,1)});\n\n')

		else:
			file.write(f'\t({random.randint(0, len(medicos) - 1)}, {random.randint(0, len(atletas_nomes) - 1)}, \'Nada a declarar.\', {round(random.uniform(10,1000), 2)}, \'{datetime}\', {random.randint(0,1)}),\n')

		i += 1


print("Ficheiro db_populate.sql gerado com sucesso!")