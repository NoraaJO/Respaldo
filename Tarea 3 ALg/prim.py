import sys
class Grafo2:
    def __init__(self, Vertices):
        self.Vertices = Vertices
        self.grafo=[]
    def obtenerKeyMinima(self, key, ConjunSolucio):
        indice=0 #Asignacion es tiempo constante
        min = sys.maxsize #Asignación es tiempo constante.
        for n in range(self.Vertices): #Recorre la lista tiempo lineal
            if key[n] < min and ConjunSolucio[n] == False: #Condicion tiempo constante
                minimo = key[n] #Asignación tiempo constante
                indice = n #Asignanción tiempo constante
        return indice #Sentencia return tiempo constante
    def prim(self):
        key =[sys.maxsize]*self.Vertices # Asignanción de los valores  tiempo lineal
        padre = [None]*self.Vertices #Asignanción de una lista con valores None tiempo lineal
        key[0]=0 #Cambiar los valores de la lista tiempo constante
        conjSolucion = [False]* self.Vertices #Asignanción de una lista con valores False tiempo lineal
        padre[0] = -1 #Cambiar valores de la lista tiempo constante.
        for i in range(self.Vertices): #Recorre la cantidad de vertices tiempo lineal
            nodo=self.obtenerKeyMinima(key, conjSolucion) #Algoritmo obtenerKeymenor tiempo lineal
            conjSolucion[nodo]=True #Cambiar valores de la lista tiempo constante
            for v in range(self.Vertices): #Recorre los nodos tiempo cuadratico
                if(self.grafo[nodo][v] > 0 and conjSolucion[v] != True #Condicional tiempo constante
                        and key[v] > self.grafo[nodo][v]):
                    key[v]=self.grafo[nodo][v] #CAmbiar valor en lista tiempo constante
                    padre[v]= nodo #Cambiar valor en lista en tiempo constante
        print("Nodo Padre--- Nodo Destino --- Peso") # Sentencia print tiempo constante
        for i in range(1, self.Vertices): #Recorren los arcos guardados tiempo lineal.
            print(f"{padre[i]}---{i}---{self.grafo[i][padre[i]]}") #Sentencia print tiempo constante