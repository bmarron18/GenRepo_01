# -*- coding: utf-8 -*-
"""
looping over tuples


@author: bmarron
"""

#%%
import random
import cPickle
import string
import pandas as pd
import numpy as np


#%%

b=[12,13,14,15,16,17,18,19,20,21,-22]
a=[1,2,3,4,5,1,2,3,4,5,1]
c=zip(b,a)
np.argmax(c, axis=1)
Out[122]: array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1])



a=[1,2,3,4,5,1,2,3,4,5,1]
b=[12,13,14,15,16,17,18,19,20,21,-22]
c=zip(a,b)
np.argmax(c, axis=1)
Out[123]: array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0])

#%%
#Return the index of the biggest element in items and the element itself.
from operator import itemgetter
index, element = max(enumerate(items), key=itemgetter(1))


from itertools import *
# given an iterable of pairs return the key corresponding to the greatest value
def argmax(pairs):
    return max(pairs, key=itemgetter(1))[0]
# given an iterable of values return the index of the greatest value
def argmax_index(values):
    return argmax(enumerate(values))
# given an iterable of keys and a function f, return the key with largest f(key)
def argmax_f(keys, f):
    return max(keys, key=f)


def argmax(iterable):
    return max(enumerate(iterable), key=lambda x: x[1])[0]

#%%list to array

myarray = np.asarray(mylist)


#convert number/integer types
a = numpy.array([1, 2, 3, 4], dtype=numpy.float64)
a
#array([ 1.,  2.,  3.,  4.])

a.astype(numpy.int64)
#array([1, 2, 3, 4])

#%%convert list of 'numbers' (w/ quotes) to floats

map(float, mylist)

#%%find loction of item in a list

[1,2,3].index(2) # => 1
[1,2,3].index(4) # => ValueError

#%% loop over tuples; store to another array 

a=[1,2,3,4,5,1,2,3,4,5,1]
b=[12,13,14,15,16,17,18,19,20,21,22]
c=zip(a,b)

vm = []
for i,j in c:
    if i==1:
        vm.append(j)
        
list(enumerate(c))
Out[114]: 
[(0, (1, 12)),
 (1, (2, 13)),
 (2, (3, 14)),
 (3, (4, 15)),
 (4, (5, 16)),
 (5, (1, 17)),
 (6, (2, 18)),
 (7, (3, 19)),
 (8, (4, 20)),
 (9, (5, 21)),
 (10, (1, 22))]        
        
        
        
list(enumerate(c[0]))
Out[110]: [(0, 1), (1, 12)]

        
#%%

a=[1,2,3,4,5,1,2,3,4,5,1]
for n,i in enumerate(a):
    if i==1:
        a[n]=10
a
[10, 2, 3, 4, 5, 10, 2, 3, 4, 5, 10]
        
        
#%% operands

#  c += a is equivalent to c = c + a   
c=5
a=13
c += a       
c
#Out[120]: 18

#%%
logsumexp(jll, axis=1)

#The result, np.log(np.sum(np.exp(a))) calculated in a numerically 
#more stable way. If b is given then np.log(np.sum(b*np.exp(a))) is returned.        

#%% Scientific notation

1e+2
#Out[30]: 100.0

1e-2
#Out[31]: 0.01
