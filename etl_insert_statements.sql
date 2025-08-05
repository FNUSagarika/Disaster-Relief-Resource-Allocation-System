-- Data Insertion Logic (ETL)
-- This file contains the SQL insert statements used to populate the normalized tables from the cleaned EM-DAT dataset.

-- DisasterEvent Table
INSERT INTO DisasterEvent (
  DisasterID,
  Disaster_Group,
  Disaster_Subgroup,
  Disaster_Type,
  Disaster_Subtype,
  Event_Name,
  Start_date,
  End_date,
  CountryID
)
SELECT
  `DisasterID`,
  `Disaster Group` AS Disaster_Group,
  `Disaster Subgroup` AS Disaster_Subgroup,
  `Disaster Type` AS Disaster_Type,
  `Disaster Subtype` AS Disaster_Subtype,
  `Event Name` AS Event_Name,
  TO_DATE(
    CONCAT(
      LPAD(TRY_CAST(`Start Year` AS INT), 4, '0'), '-',
      LPAD(TRY_CAST(`Start Month` AS INT), 2, '0'), '-',
      LPAD(TRY_CAST(`Start Day` AS INT), 2, '0')
    ), 'yyyy-MM-dd'
  ) AS Start_date,
  TO_DATE(
    CONCAT(
      LPAD(TRY_CAST(`End Year` AS INT), 4, '0'), '-',
      LPAD(TRY_CAST(`End Month` AS INT), 2, '0'), '-',
      LPAD(TRY_CAST(`End Day` AS INT), 2, '0')
    ), 'yyyy-MM-dd'
  ) AS End_date,
  `CountryID`
FROM emdat_data;

-- Country Table
INSERT INTO Country (
  countryID,
  Country,
  Region,
  Location
)
SELECT DISTINCT
  countryID,
  Country,
  Region,
  Location
FROM emdat_data;

-- ReliefItem Table
INSERT INTO ReliefItem (
  ItemID,
  ReliefItem,
  Unit
)
SELECT DISTINCT
  ItemID,
  ReliefItem,
  Unit
FROM emdat_data;

-- Agency Table
INSERT INTO Agency (
  AgencyID,
  AgencyName
)
SELECT DISTINCT
  AgencyID,
  Agency AS AgencyName
FROM emdat_data
WHERE AgencyID IS NOT NULL AND Agency IS NOT NULL;

-- Distribution Table
INSERT INTO Distribution (
  DistributionID,
  AgencyID,
  DisasterID,
  ItemID,
  QuantitySent
)
SELECT DISTINCT
  DistributionID,
  AgencyID,
  DisasterID,
  ItemID,
  QuantitySent
FROM emdat_data
WHERE DistributionID IS NOT NULL
  AND AgencyID IS NOT NULL
  AND DisasterID IS NOT NULL
  AND ItemID IS NOT NULL
  AND QuantitySent IS NOT NULL;

-- Request Table
INSERT INTO Request (
  RequestID,
  DisasterID,
  ItemID,
  QuantityNeeded
)
SELECT DISTINCT
  RequestID,
  DisasterID,
  ItemID,
  QuantityNeeded
FROM emdat_data
WHERE RequestID IS NOT NULL
  AND DisasterID IS NOT NULL
  AND ItemID IS NOT NULL
  AND QuantityNeeded IS NOT NULL;

-- Impact Table
INSERT INTO Impact (
  ImpactID,
  DisasterID,
  Deaths,
  Injured,
  Affected,
  DamageUSD
)
SELECT
  uuid() AS ImpactID,
  DisasterID,
  TRY_CAST(`Total Deaths` AS INT) AS Deaths,
  TRY_CAST(`No_Injured` AS INT) AS Injured,
  TRY_CAST(`Total Affected` AS INT) AS Affected,
  TRY_CAST(`Total Damage` AS DECIMAL(18,2)) AS DamageUSD
FROM emdat_data
WHERE DisasterID IS NOT NULL;
