#!/usr/bin/env python
# encoding: utf-8

import sys
from argparse import ArgumentParser
from xml.dom import minidom
try:
  from urllib.request import urlopen
  from urllib.parse import urlencode
except ImportError:
  from urllib import urlopen, urlencode


#API_URL = "http://www.google.com/ig/api?"
API_URL = "https://www.bbc.co.uk/weather/2633948"
FKN_URL = "http://thefuckingweather.com/?"


def main():
  arguments = ArgumentParser(prog="weather")
  arguments.add_argument("--unit", choices="CF", dest="unit", default="C", help="Which unit to display the temperatures in")
  arguments.add_argument("location", nargs="+")
  args = arguments.parse_args(sys.argv[1:])

  for location in args.location:
    url = API_URL + urlencode({"weather": location})
    f_url = FKN_URL + urlencode({"where": location})
    html = urlopen(f_url).read()
    f_doc = minidom.parseString(html)
    xml = urlopen(url).read()
    doc = minidom.parseString(xml)

    divs =  f_doc.documentElement.getElementsByTagName("p")
    remark = flavor = ""
    for i in divs:
      val = i.getAttribute("class")
      if val == "remark":
        remark = i.firstChild.data 
      elif val == "flavor":
        flavor = i.firstChild.data

    forecast_information = doc.documentElement.getElementsByTagName("forecast_information")[0]
    city = forecast_information.getElementsByTagName("city")[0].getAttribute("data")

    current_conditions = doc.documentElement.getElementsByTagName("current_conditions")[0]
    temp = current_conditions.getElementsByTagName("temp_f" if args.unit == "F" else "temp_c")[0].getAttribute("data")
    condition = current_conditions.getElementsByTagName("condition")[0].getAttribute("data")
    wind_condition = current_conditions.getElementsByTagName("wind_condition")[0].getAttribute("data")
    humidity = current_conditions.getElementsByTagName("humidity")[0].getAttribute("data")



    indent = "  "
    print("Weather for {0}:".format(city))
    if remark and flavor:
      print(indent + remark + " (" + flavor + ")")
    print(indent + "{0}°{1}".format(temp, args.unit))
    print(indent + condition)
    print(indent + wind_condition)
    print(indent + humidity)

if __name__ == "__main__":
  main()

"""
john@battlestation:~/workspace/2692047$ ./weather.py London Bucharest "New York"
Weather for London:
  IT'S FUCKING ...ALRIGHT (At least you aren't living in a small town in Alaska)
  46°F
  Clear
  Wind: SW at 10 mph
  Humidity: 76%
Weather for Bucharest, Bucuresti:
  IT'S FUCKING ...ALRIGHT (Listen, weather. We need to have a talk.)
  54°F
  Cloudy
  Wind: NE at 16 mph
  Humidity: 58%
Weather for New York, NY:
  IT'S FUCKING NICE (Enjoy.)
  70°F
  Overcast
  Wind: N at 5 mph
  Humidity: 63%
Note : The Fucking Weather is a bit peculiar with city names. "SF" works better than "San Francisco", for instance.
"""
