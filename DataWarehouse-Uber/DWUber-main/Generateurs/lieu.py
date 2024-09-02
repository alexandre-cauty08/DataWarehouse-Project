import pandas as pd
import random



NOM_DE_LA_TABLE = "district"
District = ["HOPITAUX-FACULTES", "MOSSON" ,"LES CEVENNES","PORT MARIANNE","MONTPELLIER CENTRE","CROIX D ARGENT","PRES D ARENE"]
Revenu = [1800, 1200, 1250, 2000, 2200, 1500, 1700]
Population = [15000, 30000, 30000, 10000, 8000, 30000, 25000]
v = "Montpellier"


file = open(NOM_DE_LA_TABLE + ".txt", "w") #"x" si le fichier existe pas

codeP = 34000

for i in range(0, len(District)): 
    
    ville = District[i]
    
    
    file.write("INSERT INTO " + NOM_DE_LA_TABLE + " VALUES (" + str(i) + ", '" + str(codeP) + "','" + v + "', '" + District[i] + "','" + str(Revenu[i]) + "','" + str(Population[i]) + "');\n")
    codeP = codeP+10

file.close()

