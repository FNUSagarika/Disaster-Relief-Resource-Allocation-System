-- DisasterEvent Table
CREATE OR REPLACE TABLE DisasterEvent (
  DisasterID VARCHAR(255),
  Disaster_Group VARCHAR(255),
  Disaster_Subgroup VARCHAR(255),
  Disaster_Type VARCHAR(255),
  Disaster_Subtype VARCHAR(255),
  Event_Name VARCHAR(255),
  Start_date DATE,
  End_date DATE,
  CountryID VARCHAR(255),
  PRIMARY KEY (DisasterID)
);

-- Country Table
CREATE OR REPLACE TABLE Country (
  countryID VARCHAR(255),
  Country VARCHAR(255),
  Region VARCHAR(255),
  Location VARCHAR(2048),
  PRIMARY KEY (countryID)
);

-- ReliefItem Table
CREATE OR REPLACE TABLE ReliefItem (
  ItemID VARCHAR(255),
  ReliefItem VARCHAR(255),
  Unit VARCHAR(255),
  PRIMARY KEY (ItemID)
);

-- Agency Table
CREATE OR REPLACE TABLE Agency (
  AgencyID VARCHAR(255) PRIMARY KEY,
  AgencyName VARCHAR(255)
);

-- Request Table
CREATE OR REPLACE TABLE Request (
  RequestID VARCHAR(255) PRIMARY KEY,
  DisasterID VARCHAR(255) REFERENCES DisasterEvent(DisasterID),
  ItemID VARCHAR(255) REFERENCES ReliefItem(ItemID),
  QuantityNeeded INT
);

-- Distribution Table
CREATE OR REPLACE TABLE Distribution (
  DistributionID VARCHAR(255) PRIMARY KEY,
  AgencyID VARCHAR(255) REFERENCES Agency(AgencyID),
  DisasterID VARCHAR(255) REFERENCES DisasterEvent(DisasterID),
  ItemID VARCHAR(255) REFERENCES ReliefItem(ItemID),
  QuantitySent INT
);

-- Impact Table
CREATE OR REPLACE TABLE Impact (
  ImpactID VARCHAR(255) PRIMARY KEY,
  DisasterID VARCHAR(255) REFERENCES DisasterEvent(DisasterID),
  Deaths INT,
  Injured INT,
  Affected INT,
  DamageUSD FLOAT
);
