--Question 1
--This database contains pitching, hitting, and fielding statistics for
--Major League Baseball from 1871 through 2016

--Question 2
--Find the name and height of the shortest player in the database.
--How many games did he play in? What is the name of the team for which he played?
--Eddie Gaedel is the shortest player. Player id is gaedeed01. His debut date is the same as his finalgame date so he 
--has only played one game. His team id is SLA name is St. Louis Browns.
SELECT * 
FROM people as p
FULL OUTER JOIN fielding f
ON p.playerid = f.playerid
where p.height = 43

--get team ID of Eddie Gaedel
SELECT * 
FROM appearances
where playerid = 'gaedeed01'

--get team name of Eddie Gaedel, St. Louis Browns
SELECT *
FROM teams
where teamid = 'SLA'

--Question 3
--find last and first names of players from Vanderbilt University
--total salary 

--find columns associatied with vandy
select t.table_schema,
      t.table_name
from information_schema.tables t
inner join information_schema.columns c
  on c.table_name = t.table_name
     and c.table_schema = t.table_schema
where c.column_name ilike '%school%'
     and t.table_schema not in ('information_schema', 'pg_catalog')
     and t.table_type = 'BASE TABLE'
order by t.table_schema;

--Schoolid of Vanderbily Univeristy is 'vandy'

SELECT *
FROM schools 
WHERE schoolname ILIKE '%Vande%';

--find player id where schoolid is 'vandy'
SELECT playerid
FROM collegeplaying
WHERE schoolid = 'vandy';

--get first, last names and total salary of players [table] (column)
	--[people] (namefirst),(namelast), (playerid)
	--[salries] (salary)
--David Price earned the most with total salary as 81851296 and playerid priceda01
SELECT namefirst, namelast, sum(salary) as total_salary, p.playerid
FROM people p
INNER JOIN salaries s
ON p.playerid = s.playerid
WHERE p.playerid IN
	(SELECT playerid
	FROM collegeplaying
	WHERE schoolid = 'vandy')
GROUP BY p.playerid
ORDER BY total_salary DESC
;

--Question 4
--Group defensive team positions into outfield, infield and battery [table] (column)
--count no. of putouts each group in year 2016 [table] (column)

--Group defensive team positions into outfield, infield and battery [table] (column)
/*[fielding] (pos)   OF as outfield
				SS as infield
				1B
				2B
				3B
				P as battery
				C*/
--count no. of putouts each group in year 2016 [table] (column)
/* [fielding] (po)
			  (yearid) 2016*/
				
SELECT pos,
       PO,
    CASE WHEN pos = 'OF' THEN 'Outfield'
            WHEN pos IN ('SS','1B','2B','3B') THEN 'Infield'
			WHEN pos IN ('P','C') THEN 'Battery'
		ELSE 'Unknown'
		END  AS position
		,yearid
INTO TEMP TABLE PositionGroups 	
FROM fielding
WHERE yearid = '2016'
 
-- select totals by positiongroup, year
SELECT position,
	   SUM(po) AS totalPutOuts,
	   yearid
FROM PositionGroups
GROUP BY position, yearid
ORDER BY position ASC;

--Question 5
--find avg number of strikeouts per game by decade since 1920(round by 2 dp)

--[teams] (so),(g), (yearid) 
SELECT round(sum(so ::NUMERIC)/sum(g :: NUMERIC), 2) as average_strikeouts, floor(yearid / 10) * 10 as decade
FROM teams
WHERE yearid >= 1920
GROUP BY decade
ORDER BY decade ASC
;

--find avg number of homeruns per game by decade since 1920(round by 2 dp)
--[teams] (hr),(g), (yearid)
SELECT round(SUM(hr :: NUMERIC)/SUM(g :: NUMERIC),2) as average_homeruns, floor(yearid / 10) * 10 as decade
FROM teams
WHERE yearid >= 1920
GROUP BY decade
ORDER BY decade ASC

--Both homeruns and strikeouts increase through the decades. 

--Question 6



