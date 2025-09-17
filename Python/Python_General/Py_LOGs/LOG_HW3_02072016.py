# -*- coding: utf-8 -*-
"""
LOG of Python code for HW3

"""

#%%
from sklearn import datasets
from sklearn.datasets import fetch_mldata
spambase = fetch_mldata('uci 20070111 spambase')

#HTTPError: Dataset 'uci-20070111-spambase' not found on mldata.org.
#%%
import tempfile
test_data_home = tempfile.mkdtemp()


#%%
from sklearn import datasets
from sklearn.datasets import get_data_home
datasets.get_data_home


#%%
'''data : Bunch

Dictionary-like object, the interesting attributes are: 
	‘data’, the data to learn, 
	‘images’, the images corresponding to each sample, 
	‘target’, the classification labels for each sample, 
	‘target_names’, the meaning of the labels, and 
	‘DESCR’, the full description of the dataset.

'''
#Either this
from sklearn.datasets import load_digits
digits = load_digits()

#or this
digits = sklearn.datasets.load_digits(n_class=10)

print(digits.data.shape)
print(digits.target.shape)


#%%
from sklearn.datasets import load_svmlight_file
test = load_svmlight_file("/home/bmarron/Desktop/spambase.txt", n_features=57)

#%%
import csv

with open('inputfile.txt', newline='') as inputfile:
    results = list(csv.reader(inputfile))

#%%
from numpy import *
>>>
>>> data = loadtxt("myfile.txt")                       # myfile.txt contains 4 columns of numbers
>>> t,z = data[:,0], data[:,3]                         # data is 2D numpy array
>>>
>>> t,x,y,z = loadtxt("myfile.txt", unpack=True)                  # to unpack all columns
>>> t,z = loadtxt("myfile.txt", usecols = (0,3), unpack=True)     # to select just a few columns
>>> data = loadtxt("myfile.txt", skiprows = 7)                    # to skip 7 rows from top of file
>>> data = loadtxt("myfile.txt", comments = '!')                  # use '!' as comment char instead of '#'
>>> data = loadtxt("myfile.txt", delimiter=';')                   # use ';' as column separator instead of whitespace
>>> data = loadtxt("myfile.txt", dtype = int)   

#%%
import numpy as np

f = open("filename.txt")
f.readline()  # skip the header
data = np.loadtxt(f)#%%



#If the stock price is what you want to predict (your y value, 
#in scikit-learn terms), then you should split data using

X = data[:, 0:7]  # select columns 1 through end
y = data[:, 8]   # select column 0, the stock price

#Alternatively, you might be able to massage 
#the standard Python csv module into handling this type of file.


#%%
# Load the Pima Indians diabetes dataset from CSV URL
import numpy as np
import urllib
# URL for the Pima Indians Diabetes dataset (UCI Machine Learning Repository)
url = "http://goo.gl/j0Rvxq"
# download the file
raw_data = urllib.urlopen(url)
# load the CSV file as a numpy matrix
dataset = np.loadtxt(raw_data, delimiter=",")
print(dataset.shape)
# separate the data from the target attributes
X = dataset[:,0:7]
y = dataset[:,8]



#%% Alternate 

import numpy as np

# load the CSV file as a numpy matrix
test = np.loadtxt("/home/bmarron/Desktop/spambase.txt", delimiter=",")
print(test.shape)

# separate the data from the target attributes
X = test[:,0:56]
y = test[:,57]

#%%

x = np.arange(9.).reshape(3, 3)
np.where( x > 5 )

#%%
values = np.array([1,2,3,1,2,4,5,6,3,2,1,4]).reshape(6,2)

searchval = 5
np.where(values == searchval)
values[:, 1]

np.any(values[:, 1] == 6)
#Out[19]: True

np.where(values[:, 1] == 6)
#Out[20]: (array([3]),)

np.where(values[:, 1] == 2)
#Out[21]: (array([0, 4]),)

#%%

test=np.where(spambase[:, 57] == 1)

#%%sorts on first axis

arr = np.arange(12).reshape((4, 3))
np.random.permutation(arr[1:,])


#%% a = np.array([[1, 2], [3, 4]])
b = np.array([[5, 6]])
np.concatenate((a, b), axis=0)
#array([[1, 2],
#       [3, 4],
#       [5, 6]])
#%%

X_train = scaler.fit_transform(X_train)

X_test = scaler.transform(X_test)

#%%

clf = svm.SVC(kernel='linear', C=1)
scores = cross_validation.cross_val_score(clf, iris.data, iris.target, cv=5)
scores                                              
array([ 0.96...,  1.  ...,  0.96...,  0.96...,  1.        ])

The mean score and the 95% confidence interval of the score estimate are hence given by:

print("Accuracy: %0.2f (+/- %0.2f)" % (scores.mean(), scores.std() * 2))
Accuracy: 0.98 (+/- 0.03)

#%%
keys = ['a', 'b', 'c']
>>> values = [1, 2, 3]
>>> dictionary = dict(zip(keys, values))
>>> print dictionary
{'a': 1, 'b': 2, 'c': 3}

#%%
a = np.array([np.array([1,2,3]),np.array([2,3,4,5]),np.array([6,7,8])])


#%%
class sklearn.svm:
    SVC
        fit
        predict
        
class sklearn.metrics:
    classification_report
    precision_score
    recall_score
    roc_score
#%%
    
import numpy as np
np.__file__
Out[8]: '/home/bmarron/anaconda2/lib/python2.7/site-packages/numpy/__init__.pyc'

np.version.version
Out[9]: '1.9.3'

pip uninstall scikit-learn
pip install scikit-learn

pip uninstall numpy
pip uninstall pandas
pip install pandas==0.13.1
Note that installing pandas also installs it's dependencies such as numpy.


scipy:0.16.0-np110py27_1 defaults --> 0.16.0-np19py27_1 defaults

#%%
exp2_svm57 = svm.SVC(kernel='linear', C=0.6, probability=False)
exp2_svm57.fit(tr_d_features_scaled, tr_d_classification)

    #b/c read-only this does not define a read-write variable!
wgts = exp2_svm57.coef_

    #export
with open('wgts.csv', 'w+') as f:
    a= csv.writer(f, delimiter=',')
    a.writerows(wgts)

    #import 'wgts.csv' with spyder (green arrow) import
    # ==> wgtscsv (57,) == the dictionary values
    # define the dictionary keys
features =np.arange(57)

    #zip(keys, values) and create dictionary
wgts_features = dict(zip(features, wgtscsv))


sorted(wgts_features.keys(), reverse=True)
sorted(wgts_features.values(), reverse=True)




wgts_id = list(enumerate(wgtscsv))
test=[i[1] for i in wgts_id]

wgts_sorted = wgtscsv.sort()
wgts = sorted(wgtscsv, reverse=True)


# 
s = sorted(wgts_features.values(), reverse=True)

for i in s:
    print(i, wgts_features.keys()[i])

wgts_id = list(enumerate(wgtscsv))
test=[i[1] for i in wgts_id]

wgts_sorted = wgtscsv.sort()
wgts = sorted(wgtscsv, reverse=True)


#%%

It is not possible to sort a dict, only to get a representation of a 
dict that is sorted. Dicts are inherently orderless, but other types, 
such as lists and tuples, are not. So you need a sorted representation, 
which will be a list—probably a list of tuples.

For instance,

import operator
x = {1: 2, 3: 4, 4: 3, 2: 1, 0: 0}
sorted_x = sorted(x.items(), key=operator.itemgetter(1))

sorted_x will be a list of tuples sorted by the second element in each tuple. 
dict(sorted_x) == x.

And for those wishing to sort on keys instead of values:
import operator
x = {1: 2, 3: 4, 4: 3, 2: 1, 0: 0}
sorted_x = sorted(x.items(), key=operator.itemgetter(0))



#%%
#WHOA!! Python makes changes following connection variables!!!
#ie, tr_d_features_scaled AND tr_d are both affected by the changes below
test = tr_d_features_scaled

for i,n in enumerate(test[0]):
    if not i==52:
        test[0][i]=0
test[0]



for i,n in enumerate(test[1]):
    if not (i==52 or i==6):
        test[1][i]=0
test[1]


#%%

for i in range(len(test)):
    for j,k in enumerate(test[i]):
        if not (j==52 or j==6):
            test[i][j]=0


#%%
a=[1,2,3,4,5,1,2,3,4,5,1]
for i,n in enumerate(a):
    if not i==0:
        a[i]=10
a


a=[1,2,3,4,5,1,2,3,4,5,1]
for i,n in enumerate(a):
    if i==1:
        a[n]=10
a
[1, 2, 10, 4, 5, 1, 2, 3, 4, 5, 1]


a=[1,2,3,4,5,1,2,3,4,5,1]
for i,n in enumerate(a):
    if not i==1:
        a[n]=10
a
[1, 10, 10, 10, 10, 10, 2, 3, 4, 5, 10]



a=[1,2,3,4,5,1,2,3,4,5,1]
enumerate(a)
Out[114]: <enumerate at 0xa578c194>
for n,i in enumerate(a):
    if i==1:
        a[n]=10
a
[10, 2, 3, 4, 5, 10, 2, 3, 4, 5, 10]



a=[1,2,3,4,5,1,2,3,4,5,1]
for n,i in enumerate(a):
    if not i==1:
        a[n]=10
a
[1, 10, 10, 10, 10, 1, 10, 10, 10, 10, 1]


a=[1,2,3,4,5,1,2,3,4,5,1]
for i,n in enumerate(a):
    if not n==1:
        a[i]=10
a
[1, 10, 10, 10, 10, 1, 10, 10, 10, 10, 1]


a=[1,2,3,4,5,1,2,3,4,5,1]
for i,n in enumerate(a):
    if not i==0:
        a[i]=10
a







mylist = [111, -222, 333, -444]
for (i, item) in enumerate(mylist):
    if item < 0:
        mylist[i] = 0
print mylist
Results:
[111, 0, 333, 0]


l = [('a', 1), ('b', 2), ('c', 3)]
k = 1
l_without_num = [elt for num, elt in enumerate(l) if not num == k]

#%%
sorted_wgts_features[56]







