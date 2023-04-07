from kruskal import *
from prim import *
from strassen import *
from boruvka import *
from quickhull import *
from Karatsuba import *
import numpy as np


"""
grafo = Grafo(5)
grafo.AgregarAris(0, 1, 2)
grafo.AgregarAris(0, 3, 6)
grafo.AgregarAris(1, 2, 3)
grafo.AgregarAris(1, 4, 5)
grafo.AgregarAris(2, 4, 7)
grafo.AgregarAris(3, 4, 9)
grafo.kruskal()
"""
"""
grafoPrim=Grafo2(5)
grafoPrim.grafo=[[0, 2, 0, 6, 0],[2, 0, 3, 8, 5],[0, 3, 0, 0, 7],[6, 8, 0, 0, 9],[0, 5, 7, 9, 0]]
grafoPrim.prim()
"""
"""
w1= np.array([[1,2], [3,4]])
w2= np.array([[5, 6], [7, 8]])
strassen(w1,w2)
"""
"""
bor = GrafoBorukva(5)
bor.agregaArcos(0, 1, 3)
bor.agregaArcos(0, 3, 5)
bor.agregaArcos(1, 2, 2)
bor.agregaArcos(1, 4, 1)
bor.agregaArcos(2, 4, 3)
bor.agregaArcos(3, 4, 1)
bor.agregaArcos(4, 3, 1)
bor.algBoruvka()
"""
puntos =[(1, 3), (1, 1), (2,2), (4, 4), (0, 0), (1, 2), (3, 1), (3, 3)]
quickhullAux(puntos)

