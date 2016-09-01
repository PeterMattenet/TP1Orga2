#include "cuatrotree.h"


ctNode* ct_aux_search(ctNode** currNode, ctTree* tree, uint32_t newVal) {
	if (*currNode == NULL)
	{
		ctNode* nodoNuevo = malloc(sizeof(ctNode));
		tree->root = nodoNuevo;
		nodoNuevo->len = 0;
		nodoNuevo->child[0] = NULL;
		nodoNuevo->child[1] = NULL;
		nodoNuevo->child[2] = NULL;
		nodoNuevo->child[3] = NULL;
		return nodoNuevo;	
	}
	uint8_t len = (*currNode)->len;
	uint8_t i = 0;
	int salgoDelWhile;
	salgoDelWhile = 0;
	if (len == 3)
	{
		while (i < len - 1 && (salgoDelWhile == 0))
		{
			if (i == 0 && ((*currNode)->value[0] > newVal) )
			{
				salgoDelWhile=1;
			}

			if ( (*currNode)->value[i] < newVal && (*currNode)->value[i+1] > newVal) 
			{	
				salgoDelWhile = 1;
			}
			else
			{
				i = i+1;
			}

			
		}
		if ((*currNode)->value[0] > newVal)
		{
			if ((*currNode)->child[0] == NULL)
			{
				ctNode* nodoNuevo = malloc(sizeof(ctNode));
				nodoNuevo->father = *currNode;
				nodoNuevo->len = 0;
				nodoNuevo->child[0] = NULL;
				nodoNuevo->child[1] = NULL;
				nodoNuevo->child[2] = NULL;
				nodoNuevo->child[3] = NULL;
				(*currNode)->child[0] = nodoNuevo;
				return nodoNuevo;
			}
			else
			{
				return ct_aux_search(&((*currNode)->child[0]), tree, newVal);
			}
		}
		else
		{
			if ((*currNode)->child[i+1] == NULL)
			{
				ctNode* nodoNuevo = malloc(sizeof(ctNode));
				nodoNuevo->father = *currNode;
				nodoNuevo->len = 0;
				nodoNuevo->child[0] = NULL;
				nodoNuevo->child[1] = NULL;
				nodoNuevo->child[2] = NULL;
				nodoNuevo->child[3] = NULL;
				(*currNode)->child[i+1] = nodoNuevo;
				return nodoNuevo;
			}
			else
			{
				return ct_aux_search(&((*currNode)->child[i+1]), tree, newVal);
			}

		}
	}
	else
	{
		return *currNode;
	}
}

void ct_aux_fill(ctNode* currNode, uint32_t newVal) {
				
			uint8_t length = currNode->len;
			if (length == 0)
			{
				currNode->value[0] = newVal;
			} 
			else 
			{
				if (length == 1)
				{
					if (currNode->value[0] > newVal)
					{
						currNode->value[1] = currNode->value[0];
						currNode->value[0] = newVal;
					}
					else 
					{
						currNode->value[1] = newVal;
					}
				}
				else
				{
					if (newVal < currNode->value[0])
					{
						currNode->value[2] = currNode->value[1];
						currNode->value[1] = currNode->value[0];
						currNode->value[0] = newVal;
					}
					else
					{
						if (newVal < currNode->value[1])
						{
							currNode->value[2] = currNode->value[1];
							currNode->value[1] = newVal;
						}
						else
						{
							currNode->value[2] = newVal;
						}
					}

				}
			}

			currNode->len = currNode->len + 1;
			

}

void ct_add(ctTree* ct, uint32_t newVal) {
	ctNode* noditynoderino;
	ctNode** punteroANodo;

	punteroANodo = &(ct->root);
	noditynoderino = ct_aux_search(punteroANodo, ct, newVal);
	ct_aux_fill(noditynoderino, newVal);
	ct->size= ct->size + 1;
}
