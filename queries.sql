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
--Find the player who had the most success stealing bases in 2016 
--success is measured as the percentage of stolen base attempts which are successful (attempts>= 20)
--[Batting] (playerid),(SB), (CS), sum(SB, CS) as attempts, (yearid) = 2016
--join [people] (playerid), (namefirst), (namelast)
--ANS: Chris Owings has the highest sucess in stealing bases in 2016 with 91.3 sucessful rate with 23 attempts. 
SELECT 
playerid, 
stolen_base_attempts, 
namefirst,
namelast, 
success
FROM
(
SELECT 
DISTINCT b.playerid,
CASE
    WHEN 
    (b.sb:: NUMERIC) + (b.cs ::NUMERIC) = 0 THEN 0 
    ELSE
	(b.sb:: NUMERIC) + (b.cs ::NUMERIC) 
	END AS stolen_base_attempts,
p.namefirst,
p.namelast,
CASE 
	WHEN 
    (b.sb:: NUMERIC) + (b.cs ::NUMERIC) = 0 THEN 0 
    ELSE
	ROUND(((b.sb:: NUMERIC)*100/((b.sb:: NUMERIC) +(b.cs ::NUMERIC))), 2)
	END AS success 
FROM batting b
JOIN people p
ON b.playerid = p.playerid
WHERE b.yearid = 2016
GROUP BY b. playerid, b.sb, b.cs, p.namefirst, p.namelast
ORDER BY success DESC
) subquery
WHERE stolen_base_attempts >= 20;

--Question 7: 
/*From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? What is the
smallest number of wins for a team that did win the world series? Doing this will probably result in an unusually
small number of wins for a world series champion – determine why this is the case. Then redo your query,
excluding the problem year. How often from 1970 – 2016 was it the case that a team with the most wins also won
the world series? What percentage of the time?*/

--Find largest number of wins who is N to world series
--[teams] (teamid),(name), (w) DESC, (wswin) = 'N', (yearid)
--ANS: The largest number of win who is Not a world series winners are Seattle Mariners (SEA) in 2001
--and Chicago Cubs (CHN) with 116 wins in 1906.
SELECT teamid,name, w, yearid
FROM teams
WHERE wswin = 'N'
ORDER BY w DESC;

SELECT *
FROM teams
WHERE teamid = 'SEA' and yearid = 2001
--Find smallest number of wins for a team who is Y to world series, why?
--[teams] (teamid),(name), (w) ASC, (wswin) = 'Y', (yearid)
--exclude problem year.
--Los Angeles Dodgers has 63 wins in 1981 with the smallest wins. 
SELECT teamid,name, w, yearid
FROM teams
WHERE wswin = 'Y'
ORDER BY w ASC;

--
SELECT *
FROM teams
WHERE teamid = 'LAN' and yearid = 1981 --smallest number of wins world series champion
UNION ALL
SELECT *
FROM teams
WHERE teamid ='SEA' and yearid = 2001 --largest number of wins not a world series champion

--In 1981, the games played and game played at home in total is nearly half less with 110 games vs 162 in 2001. 

-- --inning, strikeout (SOA), subtract hit (H), ER, R,BB

--Question 7 redo query
--exclude problem year (yearid) = 1981
--How often from 1970 – 2016 was it the case that a team with the most wins also won
--the world series? What percentage of the time?
--[teams] max(w), wswin = 'Y', group by (yearid)
--how often happen max(win)

WITH max_wins_per_year AS (
     SELECT yearid, MAX(w) as max_wins
       FROM teams
      GROUP BY yearid
)
SELECT
       SUM(match) as match_count,
       COUNT(*) as total_years,
       ROUND((SUM(match) / COUNT(*)::numeric)*100, 3) as pct_match
FROM (
     SELECT CASE WHEN max_wins_per_year.max_wins = teams.w THEN 1 ELSE 0 END as match
       FROM teams
            INNER JOIN max_wins_per_year USING(yearid)
      WHERE wswin = 'Y'
) as sub;

--ANS: match_count is 50, total_years: 117 and percentage_match is 42.74. 

--second queries for question 7 with better accuracy.
WITH winners as	(	SELECT teamid as champ, 
				           yearid, w as champ_w
	  				FROM teams
	  				WHERE 	(wswin = 'Y')
				 			AND (yearid BETWEEN 1970 AND 2016) ),
max_wins as (	SELECT yearid, 
			           max(w) as maxw
	  			FROM teams
	  			WHERE yearid BETWEEN 1970 AND 2016
				GROUP BY yearid)
SELECT 	COUNT(*) AS all_years,
		COUNT(CASE WHEN champ_w = maxw THEN 'Yes' end) as max_wins_by_champ,
		to_char((COUNT(CASE WHEN champ_w = maxw THEN 'Yes' end)/(COUNT(*))::real)*100,'99.99%') as Percent
FROM 	winners LEFT JOIN max_wins
		USING(yearid)
--Question 8
/* Find the teams names and parks names had top 5 and lowest 5 average attendance per game in 2016 (total attendance/total game)
[homegames] (park) id, (team) id, (attendance/games) avg_attendance
join [teams] (teamid), (name), (park)
filter parks >= 10 games played.*/

WITH attendance AS(SELECT 
h.park AS parkid, 
h.team AS teamid, 
ROUND((h.attendance :: NUMERIC/h.games :: NUMERIC),2) AS avg_attendance,
t.name AS team,
t.park 
FROM homegames h
INNER JOIN teams t
ON h.team = t.teamid
WHERE h.games >=10
ORDER BY avg_attendance DESC),

avg_attendance as (SELECT 
DISTINCT avg_attendance
FROM attendance
ORDER BY avg_attendance DESC)

SELECT team, park, 


--Question 10
/*Analyze all the colleges in the state of Tennessee. Which college has had the most success in the major leagues.
Use whatever metric for success you like - number of players, number of games, salaries, world series wins, etc.*/

/*[collegeplaying] (playerid), (schoolid) (yearid)
join [schools] on (schoolid), (schoolname), (schoolcity), (schoolstate) = 'Tennessee'*/

--My purpose is to group TN college by salary and number of major league players.
WITH tn_college AS (SELECT DISTINCT 
c.playerid, 
c.schoolid, 
c.yearid,
s.schoolname,
s.schoolcity,
s.schoolstate
FROM collegeplaying c
INNER JOIN schools s
ON c.schoolid = s.schoolid
WHERE s.schoolstate = 'TN'),
tn_salaries AS (
SELECT 
s.playerid, 
s.yearid, 
s.teamid, 
s.lgid as league, 
SUM(s.salary) AS college_total_salary,
t.schoolid, 
t.schoolname as tn_college,
t.schoolcity,
t.schoolstate
FROM salaries s
INNER JOIN tn_college t
ON s.playerid = t.playerid
WHERE s.yearid BETWEEN 1970 AND 2016
GROUP BY s.yearid,t.schoolname, s.salary,s.playerid, s.teamid, league, t.schoolid,t.schoolcity,t.schoolstate
ORDER BY s.salary DESC, s.yearid DESC
),

salary AS (SELECT 
SUM(college_total_salary) AS college_total_salary,
tn_college
FROM tn_salaries
GROUP BY tn_college)

SELECT *
FROM salary
ORDER BY college_total_salary DESC --between year 1970 and 2016

/*join tn_college cte to [salaries] * on (playerid), (yearid), (teamid), (lgid) as league, (salary)*/

