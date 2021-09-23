# Identification of protein functions in mouse

***Functions***: In this study, we proposed a novel multi-label classifier to identify protein functions in mouse. This classifier employed a procedure of analyzing the associations between function labels. Labels were divided into some partitions. On each partition, a multi-label classifier was set up on the basis of RAKEL. The finally classifier integrated the multi-label classifiers on all partitions. The test results indicated that the classifiers employing the label partition were superior to generally classifiers without label partition or those with random label partitions.

![论文流程图2](https://typora-lixuan.oss-cn-shanghai.aliyuncs.com/论文流程图2.png)

### MEKA Command

----------------

Suppose the Meka installation root directory is `D:\meka1.9.3`

#### Ten-fold cross-validaion command for Meka

1. `cd D:\meka1.9.3`
2. `D:\meka1.9.3> java -cp "./lib/*" meka.classifiers.multilabel.RAkEL -M 10 -k 4 -P 0 -N 0 -S 0 -verbosity 5 -t path\par0.arff -x 10 -W weka.classifiers.trees.RandomForest -- -P 100 -I 100 -num-slots 1 -K 0 -M 1.0 -V 0.001 -S 1 > path\RAkEL_RF_-k_4_-l_100_CV10.txt`

### Other requirements

The running environment of these codes is `Python 3.7.11`. Information of used packages is listed below.

* Matlab 2016a
* Meka 1.9.2                      download address: http://meka.sourceforge.net/
* Mashup                           download address: http://mashup.csail.mit.edu
* MfunGD                          download address: https://academic.oup.com/nar/article/34/suppl_1/D568/1133126
* InterPro database         download address: http://www.ebi.ac.uk/interpro/
