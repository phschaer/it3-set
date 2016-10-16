import urllib, json

####################
# Minimal script to import all available data sets from IMBD/OMDB on the search on Star Wars
# the output is no valid and wellformed XML 
# This is on purpose since this is an excercise.
#
# @author: philipp.schaer@th-koeln.de
####################

idList = list()

for i in range(1, 37):
    print "Get data set ids - " + str(i)
    url = "http://www.omdbapi.com/?s=Star Wars&page="
    url = url+str(i)
    #print url
    response = urllib.urlopen(url)
    data = json.loads(response.read())
    for d in data['Search']:
        idList.append(d['imdbID'])

print "Done with the ids"

for i in idList:
    print "Get data set " + str(i)
    url = "http://www.omdbapi.com/?&plot=full&r=xml&i="
    url = url+str(i)
    response = urllib.urlopen(url)
    #print response.read()
    f = open('workfile.xml', 'a')
    f.write(response.read())
    f.close()

print "Ready"
