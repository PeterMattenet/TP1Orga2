#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "cuatrotree.h"

int main (void){
    char* name = "cambiameporotronombremegustoelnombreasiquelodejoasinomedigascomovivirmivida.txt";
    FILE *pFile = fopen( name, "a" );
    fprintf(pFile,"-\n");

    ctTree* arbolito;
    ct_new(&arbolito);
    printf("Cree el arbol\n");
    ct_add(arbolito, 5);
    ct_add(arbolito,4);
    
    ct_add(arbolito,2);
    ct_add(arbolito,7);
    ct_add(arbolito,9);
    ct_add(arbolito,8);
    ct_add(arbolito,6);
    ctIter* iter = ctIter_new(arbolito);
    printf("Cree el iter\n");
    ctIter_first(iter);
    printf("Inicialize el iter\n");
    uint32_t elem = ctIter_get(iter);
    printf("%i\n", elem); 
    printf("Largo del nodo %i\n", iter->node->len );
    printf("Current del iter %i\n", iter->current );
    printf("Count del iter %i\n", iter->count );
    printf("Size del arbol %i\n", iter->tree->size );
    
    
    ctIter_next(iter);
    printf("Avanze el iter \n");
    printf("Posicion del nodo %i\n", iter->node );
    elem = ctIter_get(iter);
    printf("El siguiente es %i\n", elem); 

    ctIter_next(iter);
    printf("Avanze el iter \n");
    printf("Posicion del nodo %i\n", iter->node );
    elem = ctIter_get(iter);
    printf("El siguiente es %i\n", elem); 

	ctIter_next(iter);
    printf("Avanze el iter \n");
    printf("Posicion del nodo %i\n", iter->node );
    elem = ctIter_get(iter);
    printf("El siguiente es %i\n", elem); 
    
    ctIter_next(iter);
    printf("Avanze el iter \n");
    printf("Posicion del nodo %i\n", iter->node );
   	elem = ctIter_get(iter);
    printf("El siguiente es %i\n", elem); 
     ctIter_next(iter);
    printf("Avanze el iter \n");
    printf("Posicion del nodo %i\n", iter->node );
   	elem = ctIter_get(iter);
    printf("El siguiente es %i\n", elem); 
     ctIter_next(iter);
    printf("Avanze el iter \n");
    printf("Posicion del nodo %i\n", iter->node );
   	elem = ctIter_get(iter);
    printf("El siguiente es %i\n", elem); 
    printf("Es valido? %i\n", ctIter_valid(iter)); 
    
     ctIter_next(iter);
    printf("Avanze el iter \n");
    printf("Posicion del nodo %i\n", iter->node );

    printf("Es valido? %i\n", ctIter_valid(iter)); 
    
    //ct_print(arbolito, pFile);
        
    fclose( pFile );
    return 0;    
}