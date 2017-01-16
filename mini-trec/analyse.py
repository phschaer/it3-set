#!/opt/local/bin/python
# Small script to search a local solr instance with differnt queries
# @author: Philipp Schaer
# @email: philipp.schaer@th-koeln.de

####################################################################
# Imports
####################################################################
import os
from subprocess import check_output
from subprocess import call

####################################################################
# Configuration block
####################################################################
root = "/Users/schaer/sciebo/AIW-Suchmaschinen/Abgaben-03"
qrelsDE = '/Users/schaer/sciebo/AIW-Suchmaschinen/Abgaben-03/qrels/all-DE.txt'
qrelsEN = '/Users/schaer/sciebo/AIW-Suchmaschinen/Abgaben-03/qrels/all-EN.txt'
measures = ["P_5 ","P_10 ","map ","bpref ","num_rel_ret", "recip_rank"]

####################################################################
# Function block
####################################################################

f1 = open('mini-trec126-200.csv', 'w')
f2 = open('mini-trec201-225.csv', 'w')

header = "teamname;lang;run;measure;value\n"
f1.write(header)
f2.write(header)

for file in os.listdir(root):
    if file.endswith(".txt"):
        teamname = file.split('-')[0]
        known = file.split('-')[1]
        lang = file.split('-')[3]
        run = file.split('-')[4].split('.')[0]
        
        filepath = os.path.join(root, file)
        print(filepath)
        if '-DE-' in file:
            result = check_output(['trec_eval', qrelsDE, filepath], universal_newlines=True)
        if '-EN-' in file:
            result = check_output(['trec_eval', qrelsEN, filepath], universal_newlines=True)
        #call(["trec_eval", qrelsDE, filepath], universal_newlines=True)
        
        for line in result.split('\n'):
            for m in measures:
                if line.startswith(m):
                    line = ';'.join([teamname, lang, run, m, line.split()[2].replace('.',','), str('\n')])
                    if "126-200" in file:
                        f1.write(line)
                    if "201-225" in file:
                        f2.write(line)
                    
                


                
                