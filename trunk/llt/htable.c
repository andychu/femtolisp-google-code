/*
  functions common to all hash table instantiations
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <limits.h>

#include "dtypes.h"
#include "htable.h"
#include "hashing.h"

htable_t *htable_new(htable_t *h, size_t size)
{
    size = nextipow2(size);
    size *= 2;  // 2 pointers per key/value pair
    size *= 2;  // aim for 50% occupancy
    h->size = size;
    h->table = (void**)malloc(size*sizeof(void*));
    if (h->table == NULL) return NULL;
    size_t i;
    for(i=0; i < size; i++)
        h->table[i] = HT_NOTFOUND;
    return h;
}

void htable_free(htable_t *h)
{
    free(h->table);
}

// empty and reduce size
void htable_reset(htable_t *h, size_t sz)
{
    if (h->size > sz*4) {
        size_t newsz = sz*4;
        void **newtab = (void**)realloc(h->table, newsz*sizeof(void*));
        if (newtab == NULL)
            return;
        h->size = newsz;
        h->table = newtab;
    }
    size_t i, hsz=h->size;
    for(i=0; i < hsz; i++)
        h->table[i] = HT_NOTFOUND;
}
