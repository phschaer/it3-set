#!/opt/local/bin/python
# Small script to search a local solr instance with differnt queries 
# @author: Philipp Schaer
# @email: philipp.schaer@th-koeln.de

####################################################################
# Imports
####################################################################
import urllib.request
import urllib.parse
import json
import xml.etree.ElementTree as ET

####################################################################
# Configuration block 
####################################################################
run = "simpleRun"
topicFiles = ["sampleQueries.xml"]
solrBase = "http://localhost:8983/solr/"
solrInstance = "girt"
params = ['indent=on', 'wt=json', 'fl=score,id', 'rows=1000']
solrParams = '&'.join(params)

####################################################################
# Don't change things behind this line (expect you know what to do).
####################################################################
f = open(run+'.txt', 'w')
for topicFile in topicFiles:
    # parse topicFile
    root = ET.parse(topicFile).getroot()    
    for topic in root.findall('topic'):
        query = topic.find('title').text
        topicId = topic.find('identifier').text
        solrURL = solrBase+solrInstance+"/select?"+solrParams+"&q="+str(urllib.parse.quote(query))
        print("Querying " + topicId + " at " + solrURL)
        
        response = urllib.request.urlopen(solrURL)
        data = json.loads(response.read().decode('utf-8'))
        #print json.dumps(data)
        for i,d in enumerate(data['response']['docs']):
            line = ' '.join([topicId, '0', str(d['id']), str(i), str(d['score']), str(run), str('\n')])
            #print line
            f.write(line)

# close up the runFile
f.close()        
        
    


