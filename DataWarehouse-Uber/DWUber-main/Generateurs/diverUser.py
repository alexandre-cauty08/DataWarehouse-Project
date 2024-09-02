import pandas as pd
import random

df_prenom = pd.read_csv('prenoms.csv', sep=";", encoding='latin-1')
df_nom = pd.read_csv('noms.csv', sep=",", encoding='latin-1')

p = df_prenom['prenom']
n = df_nom['patronyme']

LIEU = "district"
TOD = "timeOfDay"
CHAUFFEUR = "driver"
DATE = "dateC"
UTILISATEUR = "userUber"
COURSE = "ride"
RECHERCHE = "search"
NOMBRE_DE_USER = 5000
NOMBRE_DE_DRIVER = 250

file = open("DUGen" + ".txt", "w") #"x" si le fichier existe pas

for i in range(0, NOMBRE_DE_USER): 
    file.write("INSERT INTO " + UTILISATEUR + " VALUES (" + str(i)+ ",'" + random.choice(p) + "', '" + random.choice(n) + "', " + str(random.randint(15, 75)) + ");\n")
    
    
for j in range(0, NOMBRE_DE_DRIVER): 
    file.write("INSERT INTO " + CHAUFFEUR + " VALUES (" + str(j)+ ",'" + random.choice(p) + "', '" + random.choice(n) + "');\n")
    
file.close()