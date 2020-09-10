import urllib
from xml.dom import minidom

wurl = 'http://xml.weather.yahoo.com/forecastrss?p=%s'
wser = 'http://xml.weather.yahoo.com/ns/rss/1.0'

def weather_for_zip(zip_code):
    url = wurl % zip_code +'&u=c'
    dom = minidom.parse(urllib.urlopen(url))
    forecasts = []
    for node in dom.getElementsByTagNameNS(wser, 'forecast'):
        forecasts.append({
            'date': node.getAttribute('date'),
            'low': node.getAttribute('low'),
            'high': node.getAttribute('high'),
            'condition': node.getAttribute('text')
        })
    ycondition = dom.getElementsByTagNameNS(wser, 'condition')[0]
    return {
        'current_condition': ycondition.getAttribute('text'),
        'current_temp': ycondition.getAttribute('temp'),
        'forecasts': forecasts ,
        'title': dom.getElementsByTagName('title')[0].firstChild.data
    }
def main():
    a=weather_for_zip("ROXX0003")
    print '=================================='
    print '|',a['title'],'|'
    print '=================================='
    print '|current condition=',a['current_condition']
    print '|current temp     =',a['current_temp']
    print '=================================='
    print '|  today     =',a['forecasts'][0]['date']
    print '|  hight     =',a['forecasts'][0]['high']
    print '|  low       =',a['forecasts'][0]['low']
    print '|  condition =',a['forecasts'][0]['condition']
    print '=================================='
    print '|  tomorrow  =',a['forecasts'][1]['date']
    print '|  hight     =',a['forecasts'][1]['high']
    print '|  low       =',a['forecasts'][1]['low']
    print '|  condition =',a['forecasts'][1]['condition']
    print '=================================='

main()
