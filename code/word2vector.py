import sys
from gensim.models import Word2Vec
#import pandas as pd
import numpy as np
import pickle
import pdb
import gzip
import random
#from sklearn.metrics import f1_score

def read_uniprot_domain_old(datafile = 'vertex_class.csv'):
    data = []
    all_domain_set = set()
    #pdb.set_trace()
    line_num = 0
    head = False
    with open(datafile, 'r') as fp:
        for line in fp:
            if head:
                head = False
                continue
            values = line.rstrip().split(',')
            #pdb.set_trace()
            protein = values[0]
            for domain in values[1:]:
                all_domain_set.add(domain)
            if len(values[1:]):
                data.append(values[1:])

    '''all_proteins = list(all_domain_set)
    fw = open('../rr/domain_list', 'w')
    for val in all_proteins:
        fw.write(val + b'\n')
    fw.close() 
    '''
    '''
    print(len(data), len( all_domain_set))
    protein_domains = []
    for key, val in data.items():
        #pro_d = []
        #for dom in val:
        #    ind = all_proteins.index(dom)
        #    pro_d.append(ind)
        #random.shuffle(val)
        protein_domains.append(val)
    '''
    data = {}
    return data, all_domain_set
    #return protein_domains, all_domain_set

def read_uniprot_domain(datafile = 'GO_KEGG_gene.txt'):
    data = {}
    all_domain_set = set()
    #pdb.set_trace()  # 调试代码，程序运行到此处会暂停
    line_num = 0
    head = False  # if the inputfile has the header, change head to True
    with open(datafile, 'r') as fp:
        for line in fp:
            if head:
                head = False
                continue
            values = line.rstrip().split(',')
            #pdb.set_trace()
            protein = values[0]
            for domain in values[1:]:
                all_domain_set.add(domain)
            data[protein] = values[1:]

    '''all_proteins = list(all_domain_set)
    fw = open('../rr/domain_list', 'w')
    for val in all_proteins:
        fw.write(val + b'\n')
    fw.close()
    '''
    print(len(data), len(all_domain_set))
    protein_domains = []
    for key, val in data.items():
        #pro_d = []
        #for dom in val:
        #    ind = all_proteins.index(dom)
        #    pro_d.append(ind)
        #random.shuffle(val)
        protein_domains.append(val)

    data = {}
    return protein_domains, all_domain_set

 
def train_word2vec(inputfile, outfile='IPR_embedding_all.gz'):
    min_count = 1
    dim = 256
    window = 5
     
    sentences, all_domain_set = read_uniprot_domain(inputfile) # sentence is the list of the list
    #pdb.set_trace()
    model = None
    model = Word2Vec(sentences, min_count=min_count, size=dim, window=window, sg=1, iter = 50, batch_words=100)
    #pdb.set_trace()
    allWeights = model.wv
    
    #vocab = list(model.vocab.keys())
    #embeddingWeights = np.empty([len(vocab), dim])

    #for i in range(len(vocab)):
    #    embeddingWeights[i,:] = model[vocab[i]]  

    #allWeights.append(embeddingWeights)

    with gzip.open(outfile, 'w') as f:
         for val in all_domain_set:
             w2v = allWeights.get_vector(val)
             newstr = ','.join(map(str, w2v))
             newstr = val + ',' + newstr + '\n'
             f.write(newstr.encode())
         #pickle.dump(allWeights, f)

def read_uniprot_id(datafile = '../rr/protein_domain.gz'):
    pro_domain = {}
    with gzip.open(datafile) as fp:
        for line in fp:
            values = line.decode().rstrip().split()
            pro_domain[values[0]] = values[1:]
    return pro_domain

inputfile = sys.argv[1] # inptufile file for corpus
outfile = sys.argv[2] # compressed file name such as embedding.gz
train_word2vec(inputfile, outfile)