# -*- coding: utf-8 -*-
"""
Created on Tue Nov 23 10:05:13 2021

@author: loicc
"""

import pandas as pd
import random





def is_Holiday(m,d):
    if d > 20 and m == 12 :
        return 1
    if d < 3 and m == 1 :
        return 1
    if d > 1 and d < 16 and m == 8:
        return 1
    return 0

def is_Week(j):
    if j <= 4 :
        return 1
    return 0

def is_AMPM(h):
    if h < 12:
        return "AM"
    return "PM"

LIEU = "district"
TOD = "timeOfDay"
CHAUFFEUR = "driver"
DATE = "dateC"
UTILISATEUR = "userUber"
COURSE = "ride"
RECHERCHE = "search"
NB_DATE = 360
NB_TIME = 24
District = ["HOPITAUX-FACULTES", "MOSSON" ,"LES CEVENNES","PORT MARIANNE","MONTPELLIER" "CENTRE","CROIX D ARGENT","PRES D ARENE"]





mois = ["Janvier",  "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"]
jours = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
annee = '2020'

idDate = 0

file = open("GenAll" + ".txt", "w" )

for m in range(1, 13, 1): 
    for j in range(1, 31, 1): 
        dateCourant = "TO_DATE('" + str(j) + "-" + str(m)+ "-2020','DD-MM-YYYY')"
        file.write("INSERT INTO " + DATE + " VALUES (" + str(idDate) + ", " + dateCourant + ", '" + jours[idDate%7] + "', '" + mois[m-1] + "', '" + "2020" + "', " + str(is_Holiday(m, j))+ ", " + str(is_Week(j))+ ");\n")
        idDate+=1
        
cmt = 0
for h in range(0, 24):  
    file.write("INSERT INTO " + TOD + " VALUES (" + str(cmt) + ",'"+"null"+"', " + str(h) + ", " + str(0) + ", " + str(0) + ",'"+ is_AMPM(h) +"');\n")
    cmt+=1



for i in range(1,NB_DATE):
    for j in range(1,NB_TIME):
        for k in range(0,7):
       
            district = random.randint(0,len(District))
                
            NbDriver = random.randint(1, 50)
                
            waiting = random.randint(60,120)
                
            NbSearch = random.randint(1, 100)
                
            NbSearchSucc = NbSearch - random.randint(0, NbSearch)
                
            NbSearchUnSucc = NbSearch - NbSearchSucc
                
            ratioUnSucc = round(NbSearchUnSucc/NbSearch, 2)
                
            NbDriver = random.randint(1, 100)
                
            freeDriver = NbDriver - random.randint(0, NbDriver)
                
            ratioFreeDriver = round(freeDriver/NbDriver, 2)
                
            waiting = round(random.gauss(40, 25))
            if waiting < 2:
                waiting = 2
            if waiting > 150:
                waiting = 150
                    
                
            file.write("INSERT INTO " + RECHERCHE + " VALUES (" + str(i) + ", " + str(j) + ", " + str(k) + "," + str(NbSearch) + "," + str(NbSearchSucc) + "," + str(NbSearchUnSucc) + "," + str(ratioUnSucc) + "," + str(round(1-ratioUnSucc,2)) + "," + str(NbDriver) + "," + str(freeDriver) + "," + str(NbDriver-freeDriver) + "," + str(ratioFreeDriver) + "," + str(round(1-ratioFreeDriver,2)) + "," + str(waiting) + ");\n")





file.close()
