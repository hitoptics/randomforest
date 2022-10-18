##
##     Multioutput regressor using random forest: 3 parameters
##

from sklearn.ensemble import RandomForestRegressor
from sklearn.multioutput import MultiOutputRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score
import pandas as pd
import numpy as np
import statistics
import matplotlib.pyplot as plt

def create_data(n):
    labels= pd.read_csv(r'model_r_n_z.csv')
    data = pd.read_csv(r'myData.csv')
    
    print(labels)
    print(data)   
    print(labels.shape)
    print(data.shape)

    Y= labels
    X = data;
    X=data
    X = np.array(X)
    Y = np.array(Y)
    return X, Y
        
X, Y = create_data(n=9000)

plt.plot(X)
plt.show()

print("X:", X.shape, "Y:", Y.shape)
in_dim = X.shape[1]
out_dim = Y.shape[1]

 
f = plt.figure()
f.add_subplot(1,2,1)
plt.title("Xs input data")
plt.plot(X)
plt.xlabel("Samples")
f.add_subplot(1,2,2)
plt.title("Ys output data")
plt.plot(Y)
plt.xlabel("Samples")
plt.show()
 
xtrain, xtest, ytrain, ytest=train_test_split(X, Y, test_size=0.1)
print("xtrain:", xtrain.shape, "ytrain:", ytrain.shape)

testdata=xtest
testy=ytest

print("xtest:", testdata.shape, "tesy:", testy.shape)

X = testdata

xtest= np.array(X)
ytest=np.array(testy)

model = MultiOutputRegressor(RandomForestRegressor(n_jobs=-1))

print(model)
model.fit(xtrain, ytrain)
ytrain_pred = model.predict(xtrain)
ypred= model.predict(xtest)
nch=len(xtest)


for i in range(0,nch,100):  
 print("%d %.4f %.4f %.4f" %( i,ytest[i,0], ypred[i,0],(ytest[i,0]-ypred[i,0])*1000))
for i in range(0,nch,100):
 print("%d %.3f %.3f %.3f" %(i,ytest[i,1], ypred[i,1],(ytest[i,1]-ypred[i,1])*1000))
for i in range(0,nch,100):
 print("%d %.3f %.3f %d" %(i,ytest[i,2], ypred[i,2],(ytest[i,2]-ypred[i,2])*1000))

xtest0=xtest[0:nch]
ytest0=ytest[0:nch]
ypred0=ypred[0:nch]

for i in range(nch):    
    if i==0:
        with open('estimated_r.txt', 'a') as f:  
            print('\n',file=f)

            print("%.4f %.4f %.4f" %( ytest0[i,0], ypred0[i,0],(ytest0[i,0]-ypred0[i,0])*1000),file=f)
    else:
         with open('estimated_r.txt', 'a') as f:  
            print("%.4f %.4f %.4f" %( ytest0[i,0], ypred0[i,0],(ytest0[i,0]-ypred0[i,0])*1000),file=f)
for i in range(nch):    
    if i==0:
         with open('estimated_n.txt', 'a') as f:
             print('\n',file=f)
             print("%.3f %.3f %.3f" %(ytest0[i,1], ypred0[i,1],(ytest0[i,1]-ypred0[i,1])*1000),file=f)
    else:
        with open('estimated_n.txt', 'a') as f:
            print("%.3f %.3f %.3f" %(ytest0[i,1], ypred0[i,1],(ytest0[i,1]-ypred0[i,1])*1000),file=f)
for i in range(nch):    
    if i==0:
        with open('estimated_z.txt','a') as f:
            print('\n',file=f)
            print("%.3f %.3f %d" %(ytest0[i,2], ypred0[i,2],(ytest0[i,2]-ypred0[i,2])*1000),file=f)
    else:
        with open('estimated_z.txt','a') as f:
            print("%.3f %.3f %d" %(ytest0[i,2], ypred0[i,2],(ytest0[i,2]-ypred0[i,2])*1000),file=f)


f.close()

print('R^2 train : %.6e, test : %.6e \n' % (r2_score(ytrain, ytrain_pred, multioutput="variance_weighted" ),
                                                r2_score(ytest0, ypred0, multioutput="variance_weighted")))

with open('3_parameters_results.txt', 'a') as f: 
  f.write('\n')
  f.write(str(model))
  f.write('\n') 

  f.write("r %.4f ± %.4f \n" % (statistics.mean((ytest0[:,0]-ypred0[:,0])*1000), statistics.pstdev((ytest[:,0]-ypred[:,0])*1000)))
  f.write("n %.4f ± %.4f \n" % (statistics.mean((ytest0[:,1]-ypred0[:,1])*1000), statistics.pstdev((ytest[:,1]-ypred[:,1])*1000)))
  f.write("z %.4f ± %.4f \n" % (statistics.mean((ytest0[:,2]-ypred0[:,2])*1000), statistics.pstdev((ytest[:,2]-ypred[:,2])*1000)))
  f.write('R^2 train : %.6e, test : %.6e \n' % (r2_score(ytrain, ytrain_pred, multioutput="variance_weighted" ),
                                                r2_score(ytest0, ypred0, multioutput="variance_weighted")))

   
 