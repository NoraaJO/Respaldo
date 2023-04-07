class Grafo:
    def __init__(self, Aristas):
        self.aristas =Aristas
        self.grafo= []
    def AgregarAris(self, vert1, vert2, peso):
        self.grafo.append([vert1, vert2, peso])
    def encontrar(self, padre, numero): #Toma tiempo constante
        if padre[numero]==numero: #Condicional constante
            return numero #Sentencia return constante
        else: # Condicional constante
            return self.encontrar(padre, padre[numero]) #Sentencia más llamada return tiempo constante.
    def unir(self, padre, Rango, numero1, numero2):
        raiz1 = self.encontrar(padre, numero1) # tiempo constante
        raiz2 = self.encontrar(padre, numero2) # tiempo constante
        if Rango[raiz1] <Rango[raiz2]: # Condicional tiempo constante
            padre[raiz1]= raiz2 # Cambiar valor tiempo constante
        elif Rango[raiz1] > Rango[raiz2]: #Condicional tiempo constante
            padre[raiz2] = raiz1 # Cambiar valor tiempo constante
        else: #Condicional tiempo constante
            padre[raiz2] = raiz1 # Cambiar valor tiempo constante
            Rango[raiz1]+=1 #Operación aritmetica
    def kruskal(self):
        Resultado= [] # Asignanción de variable tiempo constante
        Arista = 0 # Asignanción de variable tiempo constante
        ArisResul =0 # Asignación de variable tiempo constante
        self.grafo =sorted(self.grafo, key=lambda item: item[2]) #Ordena los valores de menor a mayor, tiempo lineal
        padre=[] # Asignanción de variable tiempo constante
        Rango=[] # Asignanción de variable tiempo constante

        for nodo in range(self.aristas): # Recorre la cantidad de aristas
            padre.append(nodo) #Agregar valor a la lista tiempo lineal
            Rango.append(0) #Agregar valor a la lista tiempo lineal
        while ArisResul < self.aristas-1: #Repite n-1 veces
            nodo1, nodo2, peso = self.grafo[Arista]# Obtener el valor en la lista tiempo constante
            Arista+=1 #Operación Aritmetica tiempo lineal
            raiz1= self.encontrar(padre, nodo1) #Tiempo constante
            raiz2= self.encontrar(padre, nodo2) #Tiempo constante
            if raiz1 != raiz2: # Condicional tiempo constante.
                ArisResul+=1 # Operacion aritmetica tiempo constante
                Resultado.append([nodo1, nodo2, peso]) #Agregar elementos a lista Lineal
                self.unir(padre, Rango, nodo1, nodo2) #Tiempo Constante
        print("nodo Origen ---- Nodo destino----Peso") #sentencia print tiempo constante
        for nodo1, nodo2, peso in Resultado: #Recorrer la lista tiempo lineal
            print(str(nodo1)+"--"+str(nodo2)+"--"+str(peso)) #Sentencia print tiempo constante


