def bs4_population():
	# Requests

	try:
		site_1 = requests.get("http://www.idesporto.pt/ListaAtletas.aspx")
	 	#site_2 = requests.get("https://regrasdoesporte.com.br/atletismo-regras-modalidades-corrida-arremessos-e-regras.html")
		#site_1.raise_for_status()
		#site_2.raise_for_status()
		
	except HTTPError as err:
	 	print(f'HTTP Error, ou seja o site não está ativo: {err}')

	except Exception:
		print(f'Not an HTTP Error: {err}')

	else:
		print("Sites encontrados e disponíveis!")

	# BeautifulSoup

	atletas = []
	modalidades = []

	soup_2 = BeautifulSoup(site_2.text, 'html.parser')
	print("Sites processados com bs4!")

	modalidades = soup_2.find_all('strong')[1:len(modalidades)-4]

	# File

	my_file_2 = Path("modalidades.txt")

	if my_file_2.exists():
		
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