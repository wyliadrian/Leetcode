# Write your MySQL query statement below
WITH 
INIT AS (
SELECT @PCOUNT:=0, @ACCUM:=0
),

TEMP AS (
SELECT BUS_ID, CAPACITY, COUNT(PASSENGER_ID) AS COUNTS
FROM BUSES
LEFT JOIN PASSENGERS
ON BUSES.ARRIVAL_TIME >= PASSENGERS.ARRIVAL_TIME
GROUP BY BUS_ID
)

SELECT BUS_ID, PASSENGERS_CNT FROM
(SELECT BUS_ID, @PCOUNT:=LEAST(CAPACITY, COUNTS-@ACCUM) PASSENGERS_CNT, @ACCUM:=@ACCUM+@PCOUNT 
FROM TEMP, INIT) T
ORDER BY BUS_ID