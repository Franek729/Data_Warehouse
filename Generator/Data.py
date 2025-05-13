from Constants import *

possible_names = [
    # Meskie imiona
    "Adam", "Adrian", "Aleksander", "Andrzej", "Antoni",
    "Arkadiusz", "Artur", "Bartlomiej", "Bartosz", "Blazej",
    "Bogdan", "Boleslaw", "Cezary", "Cyprian", "Damian",
    "Daniel", "Dariusz", "Dawid", "Dominik", "Edward",
    "Emil", "Eryk", "Filip", "Franciszek", "Gabriel",
    "Grzegorz", "Henryk", "Hubert", "Ignacy", "Ireneusz",
    "Jacek", "Jakub", "Jan", "Janusz", "Jaroslaw",
    "Jerzy", "Jozef", "Kacper", "Kajetan", "Karol",
    "Kazimierz", "Krzysztof", "Lech", "Leon", "Lukasz",
    "Maciej", "Marek", "Marian", "Mariusz", "Mateusz",
    # Damskie imiona
    "Agnieszka", "Aleksandra", "Alicja", "Amelia", "Aneta",
    "Anita", "Anna", "Barbara", "Beata", "Bogumila",
    "Bozena", "Celina", "Czeslawa", "Dagmara", "Danuta",
    "Dorota", "Edyta", "Elzbieta", "Emilia", "Ewa",
    "Gabriela", "Grazyna", "Halina", "Hanna", "Helena",
    "Irena", "Izabela", "Jadwiga", "Janina", "Joanna",
    "Jolanta", "Julia", "Justyna", "Kamila", "Karolina",
    "Katarzyna", "Kazimiera", "Kinga", "Krystyna", "Laura",
    "Lidia", "Lucyna", "Magdalena", "Malgorzata", "Maria",
    "Marianna", "Marta", "Monika", "Natalia", "Nina"
]

possible_male_surnames = ["Nowak", "Kowalski", "Wisniewski", "Wojcik", "Kowalczyk",
    "Kaminski", "Lewandowski", "Zielinski", "Szymanski", "Wozniak",
    "Dabrowski", "Kozlowski", "Jankowski", "Mazur", "Wojciechowski",
    "Kwiatkowski", "Krawczyk", "Kaczmarek", "Piotrowski", "Grabowski",
    "Zajac", "Pawlowski", "Michalski", "Krol", "Wieczorek",
    "Jablonski", "Wrobel", "Nowakowski", "Majewski", "Olszewski",
    "Stepien", "Malinowski", "Jaworski", "Adamczyk", "Dudek",
    "Nowicki", "Pawlak", "Gorski", "Witkowski", "Walczak",
    "Sikora", "Baran", "Rutkowski", "Michalak", "Szewczyk",
    "Ostrowski", "Tomaszewski", "Pietrzak", "Zalewski", "Wroblewski"]

possible_female_surnames = ["Nowak", "Kowalska", "Wisniewska", "Wojcik", "Kowalczyk",
    "Kaminska", "Lewandowska", "Zielinska", "Szymanska", "Wozniak",
    "Dabrowska", "Kozlowska", "Jankowska", "Mazur", "Wojciechowska",
    "Kwiatkowska", "Krawczyk", "Kaczmarek", "Piotrowska", "Grabowska",
    "Zajac", "Pawlowska", "Michalska", "Krol", "Wieczorek",
    "Jablonska", "Wrobel", "Nowakowska", "Majewska", "Olszewska",
    "Stepien", "Malinowska", "Jaworska", "Adamczyk", "Dudek",
    "Nowicka", "Pawlak", "Gorska", "Witkowska", "Walczak",
    "Sikora", "Baran", "Rutkowska", "Michalak", "Szewczyk",
    "Ostrowska", "Tomaszewska", "Pietrzak", "Zalewska", "Wroblewska"]

possible_cities = ["Warszawa", "Krakow", "Lodz", "Gdansk", "Poznan"]

possible_streets = [ "ul. Marszalkowska", "ul. Krakowskie Przedmiescie", "ul. Nowy Swiat", "ul. Piotrkowska", "ul. Dluga",
    "ul. Swietokrzyska", "ul. Grojecka", "ul. Chmielna", "ul. Mokotowska", "ul. Pulawska",
    "ul. Jana Pawla II", "ul. Targowa", "ul. Zlota", "ul. Zwirki i Wigury", "ul. Wspolna",
    "Al. Jerozolimskie", "Al. Solidarnosci", "Al. Niepodleglosci", "Al. Wojska Polskiego", "Al. Wilanowska",
    "Al. Rzeczypospolitej", "Al. Jana III Sobieskiego", "Al. KEN", "Al. Prymasa Tysiaclecia", "Al. Armii Ludowej",
    "Al. Zieleniecka", "Al. Waszyngtona", "Al. Stanow Zjednoczonych", "Al. Krakowska", "Al. Wilanowska"]

possible_status = ["pending", "resolved"]

possible_specialization = ["Automobile", "Property", "Health", "Life", "Industrial", "Agricultural", "Travel", "Other"]

possible_coverage_details = ["Auto insurance", "Home insurance", "Health insurance", "Life insurance", "Travel insurance",
                              "Business insurance", "Agricultural insurance"]

possible_insurance_price = [50,100,150,200,350]
