CREATE TABLE regions (
  region_id INT AUTO_INCREMENT PRIMARY KEY,
  region_name VARCHAR(255) NOT NULL
);

CREATE TABLE states (
  state_id INT AUTO_INCREMENT PRIMARY KEY,
  state_name VARCHAR(255) NOT NULL,
  region_id INT,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE markets (
  market_id INT AUTO_INCREMENT PRIMARY KEY,
  market_name VARCHAR(255) NOT NULL,
  region_id INT,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE submarkets (
  submarket_id INT AUTO_INCREMENT PRIMARY KEY,
  submarket_name VARCHAR(255) NOT NULL,
  market_id INT,
  polygon_id INT,
  FOREIGN KEY (market_id) REFERENCES markets(market_id)
);

CREATE TABLE polygons (
  polygon_id INT AUTO_INCREMENT PRIMARY KEY,
  polygon_name VARCHAR(255) NOT NULL,
  polygon_coordinates VARCHAR(255) NOT NULL
);

INSERT INTO regions (region_name) VALUES ('Region 1'), ('Region 2');

INSERT INTO states (state_name, region_id) VALUES ('New York', 1), ('California', 2);

INSERT INTO markets (market_name, region_id) VALUES ('Market 1', 1), ('Market 2', 2);

INSERT INTO submarkets (submarket_name, market_id, polygon_id) VALUES ('Submarket 1', 1, 1), ('Submarket 2', 2, 2);

INSERT INTO polygons (polygon_name, polygon_coordinates) VALUES ('41 Seaver Wy, Queens, NY, USA', 'Coordinates 1'), ('44 Silver road, Slivers, CA, USA', 'Coordinates 2');


SELECT sm.submarket_name, m.market_name, s.state_name, r.region_name
FROM submarkets sm
JOIN markets m ON sm.market_id = m.market_id
JOIN states s ON m.region_id = s.region_id
JOIN regions r ON s.region_id = r.region_id
JOIN polygons p ON p.polygon_id = m.polygon_id
WHERE ST_Within({point}, p.polygon_coordinates);


-- if the product team can only provide polygons that match the markets and not the submarkets, the database construction would need to be adjusted. 
-- And now we have one-to-many relation between markets and polygon (each market can have multiple polygons associated with it, but each polygon belongs to only one market)
-- The query mentioned above would need to be also adjusted 


