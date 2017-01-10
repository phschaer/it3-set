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
measures = ["P_5 ","P_10 ","map ","bpref "]

####################################################################
# Function block
####################################################################

f1 = open('mini-trec126-200.csv', 'w')
f2 = open('mini-trec201-225.csv', 'w')

for file in os.listdir(root):
    if file.endswith(".txt"):
        teamname = file.split('-')[0]
        known = file.split('-')[1]
        lang = file.split('-')[3]
        run = file.split('-')[4].split('.')[0]
        
        filepath = os.path.join(root, file)
        print(filepath)
        result = check_output(['trec_eval', qrelsDE, filepath], universal_newlines=True)
        call(["trec_eval", qrelsDE, filepath], universal_newlines=True)
        
        for line in result.split('\n'):
            for m in measures:
                if line.startswith(m):
                    line = '\t'.join([teamname, lang, run, m, line.split()[2], str('\n')])
                    if "126-200-DE" in file:
                        f1.write(line)
                    if "201-225-DE" in file:
                        f2.write(line)
                    
                


                
                