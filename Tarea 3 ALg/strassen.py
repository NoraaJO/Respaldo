import numpy as np
def strassen(matriz1, matriz2):
    n= matriz1.shape[0] #Asignación lineal
    m= matriz2.shape[1] #Asignación Lineal
    if n!=m: #Condicional constante
        print("error") #Print Error
        return 0 #Sentencia return tiempo constante
    if n==1: #Condicional tiempo constante
        return matriz1 * matriz2 #Multiplicación tiempo constante
    medio= n//2 #Condicional tiempo constante
    a11,a12,a21,a22 = matriz1[:medio, :medio], matriz1[:medio, medio:], matriz1[medio:, :medio], matriz1[medio:, medio:] #Asignancion de division de matrices tiempo lineal
    b11,b12,b21,b22 = matriz2[:medio, :medio], matriz2[:medio, medio:], matriz2[medio:, :medio], matriz2[medio:, medio:] #Asignancion de division de matrices tiempo lineal

    M1=strassen(a11+a22,b11+b22) #Llamados recursivos tiempo constante
    M2=strassen(a21+a22, b11) #Llamados recursivos tiempo constante
    M3=strassen(a11, b12-b22)#Llamados recursivos tiempo constante
    M4=strassen(a22,b21-b11)#Llamados recursivos tiempo constante
    M5=strassen(a11+a12,b22)#Llamados recursivos tiempo constante
    M6=strassen(a21-a11,b11+b12)#Llamados recursivos tiempo constante
    M7=strassen(a12-a22,b21+b22)#Llamados recursivos tiempo constante

    C11=M1+M4-M5+M7 #Operaciones Aritmeticas constante
    C12=M3+M5 #Operaciones Aritmeticas constante
    C21=M2+M4 #Operaciones Aritmeticas constante
    C22=M1-M2+M3+M6 #Operaciones Aritmeticas constante
    nuevaMatriz= np.vstack((np.hstack((C11,C12)), np.hstack((C21, C22)))) #Union de matrices tiempo
    print(nuevaMatriz) #sentencia print tiempo constante.
    
