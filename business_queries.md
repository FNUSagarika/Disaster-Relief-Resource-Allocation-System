-- 1. Summary of disaster impact by group
SELECT 
  Disaster_Group,
  COUNT(*) AS Event_Count,
  SUM(Total_Deaths) AS Total_Deaths,
  SUM(No_Injured) AS Total_Injured,
  SUM(Total_Affected) AS Total_Affected,
  SUM(Total_Damage) AS Total_Damage
FROM DisasterEvent
GROUP BY Disaster_Group;

-- 2. Most impactful disasters by fatalities
SELECT DisasterID, Event_Name, Disaster_Type, Total_Deaths
FROM DisasterEvent
WHERE Total_Deaths IS NOT NULL AND NOT isnan(Total_Deaths)
ORDER BY Total_Deaths DESC
LIMIT 100;

-- 3. Distribution of disaster types
SELECT 
  Disaster_Type, 
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS Event_Percentage
FROM DisasterEvent
GROUP BY Disaster_Type
ORDER BY Event_Percentage DESC;

-- 4. Total damage by disaster type
SELECT 
  Disaster_Type, 
  SUM(Total_Damage) AS Total_Damage,
  ROUND(100.0 * SUM(Total_Damage) / SUM(SUM(Total_Damage)) OVER (), 2) AS Damage_Percentage
FROM DisasterEvent
WHERE Total_Damage IS NOT NULL AND NOT isnan(Total_Damage)
GROUP BY Disaster_Type;

-- 5. Relief supply gap (percentage difference)
SELECT
  Disaster_Type,
  SUM(r.QuantityNeeded) AS QuantityNeeded,
  SUM(d.QuantitySent) AS QuantitySent,
  ROUND(
    100.0 * (SUM(d.QuantitySent) - SUM(r.QuantityNeeded)) / NULLIF(SUM(r.QuantityNeeded), 0), 2
  ) AS PercentageDifference
FROM Distribution d
JOIN Request r ON d.DisasterID = r.DisasterID AND d.ItemID = r.ItemID
JOIN DisasterEvent de ON d.DisasterID = de.DisasterID
GROUP BY Disaster_Type;

-- 6. Top 3 most needed items by disaster type
WITH RankedItems AS (
  SELECT 
    de.Disaster_Type, 
    ri.ReliefItem,
    SUM(r.QuantityNeeded) AS Total_Requested,
    ROW_NUMBER() OVER (PARTITION BY de.Disaster_Type ORDER BY SUM(r.QuantityNeeded) DESC) AS rn
  FROM Request r
  JOIN DisasterEvent de ON r.DisasterID = de.DisasterID
  JOIN ReliefItem ri ON r.ItemID = ri.ItemID
  GROUP BY de.Disaster_Type, ri.ReliefItem
)
SELECT * FROM RankedItems WHERE rn <= 3;

-- 7. Top 10 countries by disaster-related deaths
SELECT 
  c.Country, 
  SUM(de.Total_Deaths) AS Total_Deaths
FROM DisasterEvent de
JOIN Country c ON de.CountryID = c.countryID
WHERE de.Total_Deaths IS NOT NULL AND NOT isnan(de.Total_Deaths)
GROUP BY c.Country
ORDER BY Total_Deaths DESC
LIMIT 10;
