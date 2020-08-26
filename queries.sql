--This database contains pitching, hitting, and fielding statistics for
--Major League Baseball from 1871 through 2016

--Find the name and height of the shortest player in the database.
--How many games did he play in? What is the name of the team for which he played?
--Eddie Gaedel is the shortest player. Player id is gaedeed01. His debut date is the same as his finalgame date so he 
--has only played one game. His team name is Saintlouisbrown.
SELECT * 
FROM people as p
FULL OUTER JOIN fielding f
ON p.playerid = f.playerid
where p.height = 43

SELECT * 
FROM salaries
where playerid = 'gaedeed01'

