# Prediction of mouse protein functional labels

***Functions***：In this study, we preprocessed the 24 functional classifications of mouse proteins, divided the 24 functional classifications into groups using community detection algorithms, and finally got 3 groups, then processed the original data according to these 3 groups. Then use a popular multi-label classification algorithm, Random k-Labelsets (RAKEL) algorithm to build the classifier, and select Random Forest, RBFKernel and PolyKernel support vector machine algorithm as the basic classification algorithm, using ten-fold cross-validation to evaluate performance. We first merge the calculation results of the grouped dataset. Then compare it with the calculation result of ungrouped data. We use Accuracy, Exact match and hamming loss to measure our results. The calculation results of grouped data perform better than ungrouped data.

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
