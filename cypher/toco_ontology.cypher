CALL n10s.graphconfig.init({ handleVocabUris: "SHORTEN" });

CALL n10s.rdf.import.inline(
"""
@prefix net: <http://example.org/toco#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

##############################
# Classes with Labels
##############################

net:WiFiAccessPoint a owl:Class ;
  rdfs:label "WiFi Access Point" ;
  rdfs:comment "A device that broadcasts WiFi to nearby user equipment." .

net:WiFiUserEquipment a owl:Class ;
  rdfs:label "WiFi User Equipment" ;
  rdfs:comment "A client device that connects to a WiFi AP." .

net:WiFiAssociation a owl:Class ;
  rdfs:label "WiFi Association" ;
  rdfs:comment "A link representing a WiFi connection between user and AP." .

net:LiFiAccessPoint a owl:Class ;
  rdfs:label "LiFi Access Point" ;
  rdfs:comment "An access point providing LiFi connectivity." .

net:LiFiUserEquipment a owl:Class ;
  rdfs:label "LiFi User Equipment" ;
  rdfs:comment "A LiFi-capable user device." .

net:LiFiAssociation a owl:Class ;
  rdfs:label "LiFi Association" ;
  rdfs:comment "Represents a LiFi link between device and AP." .

net:Switch a owl:Class ;
  rdfs:label "Switch" ;
  rdfs:comment "A network switch that connects interfaces." .

net:Host a owl:Class ;
  rdfs:label "Host" ;
  rdfs:comment "A host or endpoint in the network." .

net:Interface a owl:Class ;
  rdfs:label "Interface" ;
  rdfs:comment "A network interface with IP/MAC addressing." .

net:WiredLink a owl:Class ;
  rdfs:label "Wired Link" ;
  rdfs:comment "A wired link between two interfaces." .

net:Flow a owl:Class ;
  rdfs:label "Flow" ;
  rdfs:comment "A network flow entry in an SDN switch." .

net:Output a owl:Class ;
  rdfs:label "Output Action" ;
  rdfs:comment "An output action for a flow rule." .

net:Port a owl:Class ;
  rdfs:label "Port" ;
  rdfs:comment "A port associated with a device or action." .
  
##############################
# Object Properties with Labels
##############################

net:STATIONS_IN_RANGE a owl:ObjectProperty ;
  rdfs:domain net:WiFiAccessPoint, net:LiFiAccessPoint ;
  rdfs:range net:WiFiUserEquipment, net:LiFiUserEquipment ;
  rdfs:label "Stations in Range" ;
  rdfs:comment "Devices detected within range of access point." .

net:HAS_ASSOCIATED_STATIONS a owl:ObjectProperty ;
  rdfs:domain net:WiFiAccessPoint ;
  rdfs:range net:WiFiUserEquipment ;
  rdfs:label "Associated Stations" ;
  rdfs:comment "WiFi devices associated with this access point." .

net:CONNECTED_TO a owl:ObjectProperty ;
  rdfs:domain net:WiFiUserEquipment ;
  rdfs:range net:WiFiAssociation ;
  rdfs:label "Connected To" ;
  rdfs:comment "Association from a user to an access point." .

net:TO a owl:ObjectProperty ;
  rdfs:domain net:WiFiAssociation ;
  rdfs:range net:Host ;
  rdfs:label "To Host" ;
  rdfs:comment "Target host connected to by the WiFi link." .

net:HAS_ASSOCIATION a owl:ObjectProperty ;
  rdfs:domain net:LiFiUserEquipment ;
  rdfs:range net:LiFiAssociation ;
  rdfs:label "Has Association" ;
  rdfs:comment "A LiFi device's link to an AP." .

net:HAS_INTERFACE a owl:ObjectProperty ;
  rdfs:domain net:Switch, net:Host ;
  rdfs:range net:Interface ;
  rdfs:label "Has Interface" ;
  rdfs:comment "Relationship from device to interface." .

net:HAS_LINK a owl:ObjectProperty ;
  rdfs:domain net:Interface ;
  rdfs:range net:WiredLink ;
  rdfs:label "Has Link" ;
  rdfs:comment "Wired connection from an interface." .

net:HAS_FLOW a owl:ObjectProperty ;
  rdfs:domain net:Switch ;
  rdfs:range net:Flow ;
  rdfs:label "Has Flow" ;
  rdfs:comment "Flow rules managed by the switch." .

net:HAS_ACTION a owl:ObjectProperty ;
  rdfs:domain net:Flow ;
  rdfs:range net:Output ;
  rdfs:label "Has Action" ;
  rdfs:comment "Action executed when flow matches." .

net:TO_PORT a owl:ObjectProperty ;
  rdfs:domain net:Output ;
  rdfs:range net:Port ;
  rdfs:label "To Port" ;
  rdfs:comment "The port that the output action targets." .
  
##############################
# Data Properties
##############################

net:id a owl:DatatypeProperty ; rdfs:range xsd:string .
net:ssid a owl:DatatypeProperty ; rdfs:domain net:WiFiAccessPoint ; rdfs:range xsd:string .
net:driver a owl:DatatypeProperty ; rdfs:domain net:WiFiAccessPoint ; rdfs:range xsd:string .
net:lat a owl:DatatypeProperty ; rdfs:range xsd:float .
net:long a owl:DatatypeProperty ; rdfs:range xsd:float .
net:alt a owl:DatatypeProperty ; rdfs:range xsd:float .
net:bandwidth a owl:DatatypeProperty ; rdfs:range xsd:float .
net:ip a owl:DatatypeProperty ; rdfs:range xsd:string .
net:mac a owl:DatatypeProperty ; rdfs:range xsd:string .
""",
"Turtle");

