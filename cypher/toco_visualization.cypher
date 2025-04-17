// 1. Create WiFi Access Point
CREATE (ap:WiFiAccessPoint {
  id: "wifi20",
  driver: "nl80211",
  ssid: "wifi",
  lat: 50.0,
  long: 50.0,
  alt: 0.0
});

// 2. Create Station (User Equipment)
CREATE (sta:WiFiUserEquipment {
  id: "sta1",
  name: "sta1"
});

// 3. Create WiFi Association (Link)
CREATE (assoc:WiFiAssociation {
  id: "sta1_ap",
  bandwidth: 51.5
});

// 4. Create Host
CREATE (h:Host {
  id: "h1"
});


//Create Connections
MATCH (ap:WiFiAccessPoint {id: "wifi20"}), (sta:WiFiUserEquipment {id: "sta1"})
CREATE (ap)-[:`net:STATIONS_IN_RANGE`]->(sta);

MATCH (sta:WiFiUserEquipment {id: "sta1"}), (assoc:WiFiAssociation {id: "sta1_ap"})
CREATE (sta)-[:`net:CONNECTED_TO`]->(assoc);

MATCH (assoc:WiFiAssociation {id: "sta1_ap"}), (h:Host {id: "h1"})
CREATE (assoc)-[:`net:TO`]->(h);


//Display Network
MATCH (ap:WiFiAccessPoint)-[:`net:STATIONS_IN_RANGE`]->(sta:WiFiUserEquipment)
OPTIONAL MATCH (sta)-[:`net:CONNECTED_TO`]->(assoc:WiFiAssociation)
OPTIONAL MATCH (assoc)-[:`net:TO`]->(host:Host)
RETURN ap, sta, assoc, host;


//Create Lifi Access Point
CREATE (ap:LiFiAccessPoint {
  id: "LiFi1",
  gainOfOpticalFilter: 1,
  halfIntensityAngle: 45.0,
  opticalTransmittedPower: 0.3,
  respansivity: 1,
  lat: 50.0,
  long: 50.0
});

CREATE (sta:LiFiUserEquipment {
  id: "sta2",
  fieldOfView: 90,
  gainOfConcentrator: 1
});

CREATE (assoc:LiFiAssociation {
  id: "sta2_ap",
  distance: 9.0,
  incidentAngle: 15.0,
  radianceAngle: 27.5,
  bandwidth: 5.0
});


//Create Connections
MATCH (ap:LiFiAccessPoint {id: "LiFi1"}), (sta:LiFiUserEquipment {id: "sta2"})
CREATE (ap)-[:`net:STATIONS_IN_RANGE`]->(sta);

MATCH (sta:LiFiUserEquipment {id: "sta2"}), (assoc:LiFiAssociation {id: "sta2_ap"})
CREATE (sta)-[:`net:HAS_ASSOCIATION`]->(assoc);


//Display Network
MATCH (ap:LiFiAccessPoint)-[:`net:STATIONS_IN_RANGE`]->(sta:LiFiUserEquipment)
OPTIONAL MATCH (sta)-[:`net:HAS_ASSOCIATION`]->(assoc:LiFiAssociation)
RETURN ap, sta, assoc;



//Create Wired Network Points
CREATE (s:Switch { id: "s1" });
CREATE (h:Host { id: "h1" });

CREATE (s_if:Interface { id: "s1_eth1" });
CREATE (h_if:Interface {
  id: "h1-eth0",
  ip: "10.0.0.1",
  mac: "f6:8a:d8:0b:6d:e7"
});

CREATE (link:WiredLink { id: "s1_h1", bandwidth: 50.0 });


//Create Connections
MATCH (s:Switch {id: "s1"}), (s_if:Interface {id: "s1_eth1"})
CREATE (s)-[:`net:HAS_INTERFACE`]->(s_if);

MATCH (h:Host {id: "h1"}), (h_if:Interface {id: "h1-eth0"})
CREATE (h)-[:`net:HAS_INTERFACE`]->(h_if);

MATCH (s_if:Interface {id: "s1_eth1"}), (link:WiredLink {id: "s1_h1"})
CREATE (s_if)-[:`net:HAS_LINK`]->(link);


//remove redundant nodes
MATCH (h:Host {id: "h1"})-[r:`net:HAS_INTERFACE`]->(h_if:Interface {id: "h1-eth0"})
WITH r ORDER BY id(r)
WITH collect(r) AS rels
CALL {
  WITH rels
  UNWIND tail(rels) AS redundant
  DELETE redundant
}
RETURN 'Cleaned';

//Display Network
MATCH (s:Switch)-[:`net:HAS_INTERFACE`]->(i:Interface)-[:`net:HAS_LINK`]->(l:WiredLink)
OPTIONAL MATCH (h:Host)-[:`net:HAS_INTERFACE`]->(j:Interface)
RETURN s, i, j, l, h;


//Create SDN Flow
CREATE (flow:Flow {
  id: "s1_flow1",
  idleTimeout: 0,
  tableId: 0,
  flags: 0,
  hardTimeout: 0,
  priority: 0,
  cookie: 2
});

CREATE (action:Output { id: "s1_flow1_action0" });
CREATE (port:Port { id: "s1_port1" });


//Create Connections
MATCH (s:Switch {id: "s1"}), (flow:Flow {id: "s1_flow1"})
CREATE (s)-[:`net:HAS_FLOW`]->(flow);

MATCH (flow:Flow {id: "s1_flow1"}), (action:Output {id: "s1_flow1_action0"})
CREATE (flow)-[:`net:HAS_ACTION`]->(action);

MATCH (action:Output {id: "s1_flow1_action0"}), (port:Port {id: "s1_port1"})
CREATE (action)-[:`net:TO_PORT`]->(port);


//Display Network
MATCH (s:Switch)-[:`net:HAS_FLOW`]->(f:Flow)-[:`net:HAS_ACTION`]->(a:Output)-[:`net:TO_PORT`]->(p:Port)
RETURN s, f, a, p;




