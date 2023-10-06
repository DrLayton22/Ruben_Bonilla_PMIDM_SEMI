# Rubén Bonilla Bosch

# Perdida de estado
En el caso de la pérdida de estado, lo que ocurría es que al girar la pantalla se destruía la actividad y se volvía a iniciar el método `onCreate`. Para solucionarlo, he creado un método `onSaveInstanceState` que guarda el valor actual del contador. En el método `onCreate`, he agregado una condición para que si el valor no es nulo, no se modifique el contador.

# Nuevos botones
Con respecto a los botones, he creado dos variables adicionales del mismo tipo que la del botón `btAdd`, modificando el nombre de "ADD" por los nombres de los otros botones. Una vez creadas, he duplicado el código que ya existía para hacer funcionar el botón `btAdd` y he modificado cada caso para que realice la función deseada.

# View Binding
He seguido los pasos de la unidad para añadir ViewBinding y me ha dado un error de sincronización que he solucionado resteando el programa. Una vez ViewBinding se podia usar lo que he hecho a sido eliminar el codigo val de los botones y modificar la forma de iniciar el comptador y los botones mediante biding.