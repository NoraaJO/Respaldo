def algKaratsuba(numero1, numero2):
  strNumero1= str(numero1) #Asignación tiempo = c
  strNumero2= str(numero2) #Asignación tiempo = c
  len1 = len(strNumero1) #Asignación tiempo = c
  len2 = len(strNumero2) #Asignación tiempo = c
  if len1 ==1 or len2 == 1: #Condicional tiempo = c
      return numero1 * numero2 # sentencia return tiempo = c
  medio = max(len1, len2)//2 # Asignación tiempo= c

  mitadMenor1, mitadMayor1 = int(strNumero1[medio:]), int(strNumero1[:medio]) #Acceder a los valores del arreglo, y asignar tiempo n
  mitadMenor2, mitadMayor2 = int(strNumero2[medio:]), int(strNumero2[:medio]) #Acceder a los valores del arreglo, y asignar tiempo n

  z0= algKaratsuba(mitadMenor1, mitadMenor2) #Llamado recursivo
  z2= algKaratsuba(mitadMayor1, mitadMayor2)#Llamado recursivo
  z1= algKaratsuba(mitadMayor1+mitadMenor1, mitadMayor2+mitadMenor2)-z2-z0 #Llamado recursivo y operaciones aritmeticas tiempo= c

  return z2 * 10**(medio*2)+z1*10**medio+z0 # Tiempo lineal en realizar las multiplicaciones.

  #llamados recursivos = 3
  # d = 2
  # k = 1
  #3t(n/2)+n

