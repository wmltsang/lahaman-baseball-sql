## Lahman Baseball Database Analysis (1871-2016)

**Data Source**
- this data has been made available [online](http://www.seanlahman.com/baseball-archive/statistics/) by Sean Lahman
- you can find a data dictionary [here](http://www.seanlahman.com/files/database/readme2016.txt)

![image](https://www.gannett-cdn.com/presto/2020/06/14/USAT/8e424956-0b2a-49ef-902e-aab9996ba6bf-baseball-field.jpg?auto=webp&crop=618,348,x722,y472&format=pjpg&width=1200)


**Major Data Questions**

(Applied Advanced SQL queries 

Examples: 

-Finding data queries and applying aggragate functions: `SELECT`, `AS`, `DISTNCT`, `WHERE`,`ORDER BY`, `ILKIE`, `GROUP BY`, aggregate functions such as `COUNT`, `SUM`, `MIN`, `MAX`, `AVG`, `HAVING`; `CASE WHEN`, `ROUND`, `::` to change data type

-Join queries: `INNER JOIN`, `LEFT JOIN`

-Temp Table/CTEs)

1. What range of __years__ does the provided database cover? 

1. Find the __name and height of the shortest player__ in the database. How many games did he play in? What is the name of the team for which he played?
   

1. Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. __Which Vanderbilt player earned the most money__ in the majors?
	

2. Using the fielding table, __group players__ into three groups based on their position: label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery". Determine the __number of putouts made__ by each of these three groups in 2016.
   
1. Find the average __number of strikeouts__ per game by decade since 1920. Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see __any trends__?
   

1. Find the player who had the __most success stealing bases__ in 2016, where __success__ is measured as the percentage of stolen base attempts which are successful. (A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted _at least_ 20 stolen bases.
	

1.  From 1970 – 2016, what is the __largest number of wins for a team that did not win the world series__? What is the smallest number of wins for a team that did win the world series? Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case. Then redo your query, excluding the problem year. How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?

### __Other analysis__ ###

### __Topic__ ###

Which college has had the most sucess in the major leagues in Tennessee?

__Metrics__ 

* Number of players and salaries by college

SQL Queries

* Used `CTEs` to create [tables] of [tn_college] and [tn_salaries]

* [tn_college] used `SELECT` to locate school identification columns,`INNER JOIN` two database tables to find schools in Tennessee on common primary keys

* [tn_salaries] used `SELECT` to locate major league players identification columns, `SUM` to calculate college salaries, `INNER JOIN` table `tn_college` 

* `COUNT` player numbers from [tn_salaries] and used `ORDER BY` and `DESC` from [tn_salaries] to get college total salaries

__University of Tennessee has the highest total earnings between 1970-2016__
![image](https://user-images.githubusercontent.com/66088051/106625417-3d8c9a80-653c-11eb-965e-c73f91d9b55c.png)

__University of Tennessee has the highest numbers of major league players between 1970-2016__
![image](https://user-images.githubusercontent.com/66088051/106625785-9fe59b00-653c-11eb-9eda-cea647e12bdc.png)

**Bonus** 

By attending UT Camp, you have a chance of over 85 percent of to  become a Tennessee ball players and possibly land a major league deal!!

**Reference**

https://utsports.com/sports/2019/9/30/baseball-recruiting-central.aspx

<!-- 8. Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game in 2016 (where average attendance is defined as total attendance divided by number of games). Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance. -->


<!-- 8. Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? Give their full name and the teams that they were managing when they won the award. -->


<!-- **Open-ended questions** -->

<!-- 10. Analyze all the colleges in the state of Tennessee. Which college has had the most success in the major leagues. Use whatever metric for success you like - number of players, number of games, salaries, world series wins, etc.  -->

<!-- 6. Is there any correlation between number of wins and team salary? Use data from 2000 and later to answer this question. As you do this analysis, keep in mind that salaries across the whole league tend to increase together, so you may want to look on a year-by-year basis. -->

<!-- 6. In this question, you will explore the connection between number of wins and attendance. -->

<!-- <ol type="a">  -->
<!-- <li>Does there appear to be any correlation between attendance at home games and number of wins? </li> -->
<!-- <li>Do teams that win the world series see a boost in attendance the following year? What about teams that made the playoffs? Making the playoffs means either being a division winner or a wild card winner.</li> -->
<!-- </ol>  -->


<!-- 1. It is thought that since left-handed pitchers are more rare, causing batters to face them less often, that they are more effective. Investigate this claim and present evidence to either support or dispute this claim. First, determine just how rare left-handed pitchers are compared with right-handed pitchers. Are left-handed pitchers more likely to win the Cy Young Award? Are they more likely to make it into the hall of fame? -->

  
