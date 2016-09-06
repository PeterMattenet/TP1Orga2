#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "cuatrotree.h"

int main (void){
    char* name = "maintest.txt";
    FILE *pFile = fopen( name, "a" );
    fprintf(pFile,"-\n");

    ctTree* arbolito;
    ct_new(&arbolito);
    
    ct_add(arbolito, 10);
    ct_add(arbolito,50);
    
    ct_add(arbolito,30);
    ct_add(arbolito,5);
    ct_add(arbolito,20);
    ct_add(arbolito,40);
    ct_add(arbolito,60);
    ct_add(arbolito,19);
    ct_add(arbolito,34);
    ct_add(arbolito,4);
    ctIter* iter = ctIter_new(arbolito);
    ctIter_first(iter);
    uint32_t elem;
    while (ctIter_valid(iter))
    {
        elem = ctIter_get(iter);
        printf("%i\n", elem); 
        ctIter_next(iter);
    }
    
    ctIter_delete(iter);
    ct_delete(&arbolito);

    fclose( pFile );
    return 0;    
}