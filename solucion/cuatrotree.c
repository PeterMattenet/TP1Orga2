#include "cuatrotree.h"

void ct_add(ctTree* ct, uint32_t newVal) {


}

ctNode* ct_aux_search(ctNode** currNode, ctNode* fatherNode, uint32_t newVal) {
	uint8_t len = (*currNode)->len;
	uint8_t i = 0;
	bool salgoDelWhile = false;
	if (len = 3)
	{
		while (i < len - 1 && !salgoDelWhile))
		{
			if (i = 0 && (*currNode)->value[0] > newVal ) salgoDelWhile=true;

			if ( (*currNode)->value[i] < newVal && (*currNode)->value[i+1] > newVal ) salgoDelWhile = true;

			i = i+1;
		}
		if ((*currNode)->value[0] > newVal)
		{
			if ((*currNode)->child[0] == NULL)
			{
				ctNode *nodoNuevo = (*ctNode)malloc(sizeof(ctNode));
				nodoNuevo->father = *currNode;
				(*currNode)->child[0] = nodoNuevo;
				return nodoNuevo;
			}
			else
			{
				return ct_aux_search(&((*currNode)->child[0]), fatherNode, newVal);
			}
		}
		else
		{
			if ((*currNode)->child[i+1] == NULL)
			{
				ctNode *nodoNuevo = (*ctNode)malloc(sizeof(ctNode));
				nodoNuevo->father = *currNode;
				(*currNode)->child[i+1] = nodoNuevo;
				return nodoNuevo;
			}
			else
			{
				return ct_aux_search(&((*currNode)->child[i+1]), fatherNode, newVal);
			}

		}
	}
	else
	{
		return *currNode;
	}
}

nodoNuevo->value[0] = newVal;
				nodoNuevo->len = 1;
				i = 0;
				while (i<4)
				{
					nodoNuevo->child[i] = NULL;
					i = i+1;
				}