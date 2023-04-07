class GrafoBorukva:
    def __init__(self, Vertices):
        self.Vertices = Vertices
        self.Grafo = []
    def agregaArcos(self, origen, destino, peso):
        self.Grafo.append([origen, destino, peso])
    def buscar(self, parent, i):
        if parent[i] ==-1:
            return i
        if parent[i] != i:
            return self.buscar(parent, parent[i])
    def union(self, Rango, padre, nodo1, nodo2):
        raiz1 = self.buscar(padre, nodo1)
        raiz2 = self.buscar(padre, nodo2)
        if Rango[raiz1] < Rango[raiz2]:
                padre[raiz1] = raiz2
        elif Rango[raiz1] > Rango[raiz2]:
            padre[raiz2] = raiz1
        else:
            padre[raiz2] = raiz1
            Rango[raiz1] += 1
    def algBoruvka(self):
        padre= [-1]* self.Vertices #Inicialización de lista tiempo lineal
        rango = [0]* self.Vertices #Inicialización de lista tiempo lineal
        resultado=[] #Asignanción de variable tiempo constante
        numTrees = self.Vertices # Asignación tiempo constante
        while numTrees>1: # Ciclo while
            baratos = [-1]*self.Vertices
            for i in range(len(self.Grafo)):
                origen, destino, peso = self.Grafo[i]
                padreOri = self.buscar(padre, origen)
                padreDest = self.buscar(padre, destino)

                if padreOri != padreDest:
                    if baratos[padreDest]==-1 or baratos[padreDest][2] > peso:
                        baratos[padreDest] = [padreOri, padreDest, peso]
                    if baratos[padreOri]==-1 or baratos[padreOri][2] > peso:
                        baratos[padreOri]=[padreOri, padreDest, peso]
            for nodos in range(self.Vertices):
                if baratos[nodos]!=-1:
                    origen, destino, peso = baratos[nodos]
                    padreOri = self.buscar(padre, origen)
                    padreDest = self.buscar(padre, destino)
                    if padreOri!=padreDest:
                        resultado.append([origen, destino, peso])
                        self.union(rango, padre, padreOri, padreDest)
                        numTrees-=1
        print("Origen---Destino---peso")
        for n in range(len(resultado)):
            print(f"{resultado[n][0]}---{resultado[n][1]}---{resultado[n][2]}")

