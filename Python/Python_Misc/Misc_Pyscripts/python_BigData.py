# -*- coding: utf-8 -*-
"""
Dumping Python files
Nielsen's mnist data
Trial Runs

Created on Sat Jan 23 11:32:51 2016

@author: bmarron
"""

#%%
import random
import cPickle
import string
import pandas as pd
import numpy as np

#%%Dumping Python files
    #HowTo:
    #save and retreive Python np arrays (output)
    #save the NNtargets array
with open("NNtargets_output.pkl", 'wb') as f:
    cPickle.dump(NNtargets, f, protocol=2)

        #check
data=cPickle.load(open("NNtargets_output.pkl","rb"))

#%%Loading Python files 

    #load current training data
tr_d=cPickle.load(open("/home/bmarron/Desktop/PSU/PhD_EES/SoE/2016SoE009_CS545_MachineLearning/_PWFs_work_inprogress/Hwk2/DataFiles/Processed/tr_d.pkl","rb"))



#%%Nielsen's mnist data

    #The training_data is a list of tuples (x, y) 
    #representing the training inputs and corresponding 
    #desired outputs (targets). 

Ntr_d, Nte_d, Nva_d =cPickle.load(open('/home/bmarron/Desktop/PSU/PhD_EES/SoE/2016SoE009_CS545_MachineLearning/_PWFs_work_inprogress/mnist.pkl',"rb"))

   #Neilsen's preprocessing (from mnist_loader)
N_training_inputs = [np.reshape(x, (784, 1)) for x in Ntr_d[0]]
N_training_results = [vectorized_result(y) for y in Ntr_d[1]]
N_training_data = zip(N_training_inputs, N_training_results)

N_validation_inputs = [np.reshape(x, (784, 1)) for x in Nva_d[0]]
N_validation_data = zip(validation_inputs, Nva_d[1])

N_test_inputs = [np.reshape(x, (784, 1)) for x in Nte_d[0]]
N_test_data = zip(test_inputs, Nte_d[1])
 
#%% Nielsen's vectorized
 
def vectorized_result(j):
    e = np.zeros((10, 1))
    e[j] = 1.0
    return e
    
 #%%Trial Run1
    
    #initialize the network
testnet1=NN(NNsize)

    #run just the feedforward method
trial1=testnet1.feedforward(tr_d[0][0])

#%%Trial Run2

    #initialize the network
testnet2=NN(NNsize)

    #run w/o test data
trial2 = testnet2.SGD(tr_d, 5, 10, .5)
