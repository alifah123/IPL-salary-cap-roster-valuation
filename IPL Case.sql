-- Q1 find the total spending on players for each team.

SELECT Team, SUM(Price_in_cr) AS total_spending
FROM iplplayers
GROUP BY Team
ORDER BY total_spending DESC;

-- Q2 find the top three highest paid all-rounders across all teams. 

SELECT Player, Team, Price_in_cr
FROM iplplayers
WHERE Role = 'All-rounder'
ORDER BY Price_in_cr DESC
LIMIT 3;

-- Q3 find the highest price player in each of the team. 

-- This is to find player by price from higest to lowest
SELECT *
FROM iplplayers
ORDER BY Price_in_cr DESC;

-- This is to find the maximum price for each team
SELECT Team, MAX(Price_in_cr)
FROM iplplayers
GROUP BY Team
ORDER BY MAX(Price_in_cr) DESC;

-- to combine both, we use CTE and join

WITH CTE_MP AS
( SELECT Team, MAX(Price_in_cr) AS max_price
FROM iplplayers
GROUP BY Team
)

SELECT i.Team, i.Player, i.Price_in_cr
FROM iplplayers i
JOIN CTE_MP c ON c.Team = i.Team
WHERE i.Price_in_cr = c.max_price
ORDER BY i.Price_in_cr DESC;

-- Q4 rank the players by their price within each team and list the top two ​for every team.

/* First need to create additional column to rank the player by using row number and partition
After that, the partition will be treated as CTE as to find top 2
*/

WITH RankPlayer AS (
SELECT Player, Team, Price_in_cr,
ROW_NUMBER () OVER (PARTITION BY Team ORDER BY Price_in_cr DESC) AS RankWithinTeam
FROM iplplayers
)

SELECT Player, Team, Price_in_cr, RankWithinTeam
FROM RankPlayer
WHERE RankWithinTeam < 3;

-- Q5 find the most expensive player from each team along ​with the second most expensive player name and price. 

WITH RankPlayer AS (
SELECT Player, Team, Price_in_cr,
ROW_NUMBER () OVER (PARTITION BY Team ORDER BY Price_in_cr DESC) AS RankWithinTeam
FROM iplplayers
)

SELECT Team, 
MAX(CASE WHEN RankWithinTeam = 1 THEN Player END) AS MostExpensivePlayer,
MAX(CASE WHEN RankWithinTeam = 1 THEN Price_in_cr END) AS HighestPrice,
MAX(CASE WHEN RankWithinTeam = 2 THEN Player END) AS SecondMostExpensivePlayer,
MAX(CASE WHEN RankWithinTeam = 2 THEN Price_in_cr END) AS SecondHighestPrice
FROM RankPlayer
GROUP BY Team;

-- Q6 calculate the percentage contribution of each player's price ​to their team's total spending.

SELECT player, Team, Price_in_cr,
ROUND((Price_in_cr / SUM(Price_in_cr) OVER(PARTITION BY Team))*100,2) AS ContributionPercentage
FROM iplplayers
ORDER BY ContributionPercentage DESC;

/* Q7 classify players as high, medium or low based on the price. ​So we have the conditions. ​
If the price is greater than 15 K, ​then it will be the high. 
If it is between five and 15, then it will be medium. ​
If it is less than five, then it is low. ​
And find out the number of players in each bracket */

WITH CTE_BR AS (
SELECT Team, Player, Price_in_cr,
		CASE
			WHEN Price_in_cr > 15 THEN 'High'
            WHEN Price_in_cr BETWEEN 5 AND 15 THEN 'Medium'
            ELSE 'Low'
		END AS PriceCategory
FROM iplplayers )

SELECT TEam, PriceCategory, COUNT(*) AS 'NoOfPlayers'
FROM CTE_BR
GROUP BY Team, PriceCategory
ORDER BY Team, PriceCategory

-- Q8 Find the average price of Indian players and compare it with overseas players using a subquery:

SELECT * FROM iplplayers

SELECT
		'Indian' AS PlayerType,
				(SELECT AVG(Price_in_cr) 
				FROM iplplayers
				WHERE Type LIKE 'Indian%') AS AvgPrice
UNION ALL
SELECT
		'Overseas' AS PlayerType,
					(SELECT AVG(Price_in_cr) 
					FROM iplplayers
					WHERE Type LIKE 'Overseas%' ) AS AvgPrice
                    
-- Q9 Identify players who earn more than the average price of their team: 

SELECT *
FROM iplplayers

SELECT Player, Team, Price_in_cr
FROM iplplayers p
WHERE Price_in_cr > (
			SELECT AVG(Price_in_cr)
			FROM iplplayers
			WHERE Team = p.Team )

-- Q10 For each role, find the most expensive player and their price using a correlated subquery

SELECT *
FROM iplplayers

SELECT Player, Team, Role, Price_in_cr
FROM iplplayers p
WHERE Price_in_cr = (
					SELECT MAX(Price_in_cr)
					FROM iplplayers
					WHERE Role = p.Role)
