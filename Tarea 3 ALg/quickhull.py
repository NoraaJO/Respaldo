hull = []
def direccion(punto1, punto2, puntoAnl):
    return (puntoAnl[1]-punto1[1])*(punto2[0]-punto1[0])-(punto2[1]-punto1[1])*(puntoAnl[0]-punto1[0]) > 0 #operaciones Aritmeticas tiempo constante

def distancia(punto1, punto2, puntoAnl):
    return abs((puntoAnl[1]-punto1[1])*(punto2[0]-punto1[0])-(punto2[1]-punto1[1])*(puntoAnl[0]-punto1[0])) #operaciones Aritmeticas tiempo constante

def quickhull(puntos, cantidad, punto1, punto2, lado):
    mayor= () #Asignación tiempo = c
    distanciaMax=0 # Asignacion tiempo = c
    for n in range(cantidad): #For recorre la cantidad de puntos tiempo lineal
        distAnl = distancia(punto1, punto2, puntos[n]) #Tiempo constante.
        if direccion(punto1, punto2, puntos[n]) == lado and distAnl > distanciaMax: #Condicional Tiempo constante
            mayor= puntos[n] #Asignación Tiempo constante
            distanciaMax = distAnl #Asignación Tiempo constante
    if mayor ==(): #Condicional tiempo constante
        if punto1 not in hull: #Condicional tiempo constante
            hull.append(punto1) #Agrega elementos a lista tiempo lineal
        if punto2 not in hull: #Condicional tiempo constante
            hull.append(punto2) #Agrega elementos a lista tiempo lineal
        return #Sentencia de return tiempo constante
    quickhull(puntos, cantidad, mayor, punto1, not direccion(mayor, punto1, punto2)) #llamado recursivo tiempo constante
    quickhull(puntos, cantidad, mayor, punto2, not direccion(mayor, punto2, punto1)) #llamado recursivo tiempo constante

def quickhullAux(puntos):
    cantidad = len(puntos) #Asignación tiempo constantes
    if cantidad < 3: # Condicional tiempo constante
        print("No se puede obtener el Cierre convexo") #Print tiempo constante
        return #Sentencia return tiempo constante
    puntoMinx= min(puntos, key=lambda x: x[0]) #Recorre la lista tiempo lineal
    puntoMax= max(puntos, key=lambda x: x[0]) #Recorre la lista tiempo lineal

    quickhull(puntos, cantidad, puntoMinx, puntoMax, True) #llamado recursivo tiempo constante
    quickhull(puntos, cantidad, puntoMinx, puntoMax, False) #llamado recursivo tiempo constante

    print("Los puntos del cierre convexo son") # print tiempo constante
    for punto in hull: # for tiempo lineal
        print(punto, end =" ") #print tiempo constante.



