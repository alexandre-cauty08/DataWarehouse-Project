import pandas as pd
import random


        

# Tables de la base

LIEU = "district"
TOD = "timeOfDay"
CHAUFFEUR = "driver"
DATE = "dateC"
UTILISATEUR = "userUber"
COURSE = "ride"
RECHERCHE = "search"

#Données dans les CSV

NOMBRE_DE_USER = 5000
NOMBRE_DE_DRIVER = 250

NB_DATE = 360
NB_TIME = 24

file = open("GenRide" + ".txt", "w") 

        #GENERATION DES RECHERCHE NON ABOUTIES

#Si waiting > 60, recherche non aboutie




    #GENERATION DES COURSES
nbRNAjours = random.randint(50, 150)


for i in range(0,30):
    for j in range(0, random.randint(30, 100)):
        note = random.randrange(1, 5)
        distance = random.gauss(40, 5)
        if distance <= 2:
            distance = 3
        time = random.gauss(50, 25)
        if time < 5:
            time = 5
        if time > 150:
            time = 150
        price = (distance*2) + 6 + (time * 1)
        waiting = random.gauss(20, 10)
        if waiting < 1:
            waiting = 1
        if waiting > 59:
            waiting = 59
            
        idDistrictDep = random.randint(0, 6)
        idDistrictArr = random.randint(0, 6)
        idDate = random.randint(0, NB_DATE)
        idDriver =random.randint(0, NOMBRE_DE_DRIVER)
        idUser =random.randint(0, NOMBRE_DE_USER)
        idOrderTime = random.randint(0, NB_TIME-10)
        idDepTime = random.randint(idOrderTime, NB_TIME-5)
        idArrTime   = random.randint(idDepTime, NB_TIME)
        
        #Faire insert to Course
        
        
        file.write("INSERT INTO " + COURSE + " VALUES (" + str(idUser) + ", " + str(idDistrictDep) + ", " + str(idDistrictArr) + "," + str(i) + "," + str(idDriver) + "," + str(idOrderTime) + "," + str(idDepTime) + "," + str(idArrTime) + "," + str(round(price)) + "," + str(note) + "," + str(round(distance)) + "," + str(round(waiting)) + "," + str(round(time)) + ");\n")



file.close()

























