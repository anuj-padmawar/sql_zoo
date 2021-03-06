
--sql basic select
1.
SELECT population
FROM world
WHERE name = 'Germany'

2.
SELECT name, gdp/population
FROM world
WHERE area > 5000000

3.
SELECT name , continent
FROM world
WHERE area < 2000
AND gdp > 5000000000

4.
SELECT name, population
FROM world
WHERE name IN ('Norway', 'Sweden', 'Finland',
                 'Denmark')
5.
SELECT name
FROM world
WHERE name LIKE 'G%'

6.
SELECT name, area/1000
FROM world
WHERE area BETWEEN 200000 AND 250000






select from world

1.
SELECT name, continent, population
FROM world

2.
SELECT name
FROM world
WHERE population>=200000000

3.

SELECT name, gdp/population
FROM world
WHERE population >= 200000000

4.
SELECT name, population/1000000
FROM world
WHERE continent = 'South America'

5.
SELECT name, population
FROM world
WHERE name in ('France', 'Germany', 'Italy')

6.
SELECT name
FROM world
WHERE name LIKE '%united%'

7.
SELECT name, population, area
FROM world
WHERE area > 3000000 OR population > 250000000

8.
SELECT name, population, area
FROM world
WHERE (area > 3000000 AND population < 250000000)
  OR (area < 3000000 and population > 250000000)

9.
SELECT name , ROUND(population/1000000 , 2), ROUND(gdp/1000000000 , 2)
FROM world
WHERE continent='South America';

10.
SELECT name , ROUND(gdp/population , -3) 
FROM world
WHERE gdp>1000000000000;

11.
SELECT name, capital
  FROM world
 WHERE LENGTH(name)=LENGTH(capital);
 
 
 12.
 SELECT name,capital 
FROM world
WHERE LEFT(name,1)=LEFT(capital,1) AND name<>capital;

13.
SELECT name 
FROM world 
WHERE name LIKE '%a%' AND 
name  LIKE '%e%' AND 
name  LIKE '%i%' AND 
name  LIKE '%o%' AND 
name  LIKE '%u%' AND 
name NOT LIKE '% %';





--SELECT from Nobel Tutorial

1.
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;
 
 2.
 SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'
   
   
   3.
   SELECT yr, subject
  FROM nobel
 WHERE winner = 'Albert Einstein';
 
 4.
 SELECT winner
  FROM nobel
 WHERE yr >= 2000
   AND subject = 'Peace';
   
   
   5.
   SELECT yr,subject,winner
  FROM nobel
 WHERE yr >= 1980 AND yr<=1989
   AND subject = 'Literature';
   
   
   
   6.
   SELECT * FROM nobel
 WHERE
  winner IN ( 'Theodore Roosevelt',
'Woodrow Wilson',
'Jimmy Carter',
'Barack Obama');


7.
SELECT winner FROM nobel
 WHERE winner LIKE 'john%';
 
 8.
 
   SELECT yr,subject,winner
  FROM nobel
 WHERE (yr = 1980 AND subject = 'Physics') OR (yr = 1984 AND subject = 'Chemistry');
 
 9.
   SELECT yr,subject,winner
  FROM nobel
 WHERE  yr=1980 AND subject NOT IN ('Chemistry' , 'Medicine');
 
 
 10.
 SELECT yr,subject,winner
  FROM nobel
 WHERE (yr<1910 AND subject='Medicine') OR (yr>=2004 AND subject='Literature');
 
 11.
 SELECT yr,subject,winner
  FROM nobel
 WHERE winner LIKE 'PETER GR%';
 
 12.
   SELECT yr,subject,winner
  FROM nobel
 WHERE winner='EUGENE O''NEILL';
 
 
 13.
 SELECT winner,yr,subject
  FROM nobel
 WHERE winner LIKE 'Sir%'
ORDER BY yr DESC,winner;
 
 14.
 SELECT winner, subject 
  FROM nobel
 WHERE yr=1984
 ORDER BY 
CASE WHEN subject IN ('Physics','Chemistry') THEN 1 ELSE 0 END ,subject ,winner;



--SELECT within SELECT Tutorial
1.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
      
      
  2.
      SELECT name 
FROM world
  WHERE continent='Europe' AND 
        gdp/population > (
        SELECT gdp/population 
        FROM world
        WHERE name='United Kingdom')
   


3.
SELECT name, continent
FROM world
WHERE continent IN (SELECT  DISTINCT(continent) FROM world WHERE name IN('Argentina' , 'Australia'))
ORDER BY name;


4.
SELECT name , population 
FROM world
WHERE population > (SELECT population FROM world WHERE name='Canada')  AND 
population < (SELECT population FROM world WHERE name='Poland')




5.
SELECT name, CONCAT(ROUND((population*100)/(SELECT population FROM world WHERE name='Germany'), 0), '%') AS percentage
FROM world
WHERE continent='Europe';


6.
SELECT name FROM world 
WHERE gdp > ALL(SELECT gdp from world 
 WHERE continent='Europe' 
   AND gdp IS NOT NULL)
   
   
7.
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)
          
 8.
    SELECT continent, MIN(name) 
FROM world 
GROUP BY continent
ORDER by continent;


   9.
   SELECT name,continent , population
FROM world
WHERE continent IN (SELECT continent FROM world x WHERE 25000000 >= (SELECT MAX(population) FROM world y WHERE x.continent = y.continent));




10.
SELECT name, continent 
FROM world x
WHERE population > ALL(SELECT 3*population FROM world y WHERE x.continent = y.continent AND x.name != y.name)
   
   
   
   
   
   
   
   
   
   
   SUM and COUNT


1.
SELECT SUM(population)
FROM world

2.
SELECT DISTINCT(continent)
FROM world

3.
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa'

4.
SELECT COUNT(name)
FROM world
WHERE area >= 1000000

5.
SELECT SUM(population)
FROM world
WHERE name IN  ('Estonia', 'Latvia', 'Lithuania')


6.SELECT continent, count(name)
FROM world
GROUP BY continent;


7.
SELECT continent, count(name)
FROM world
WHERE population>10000000
GROUP BY continent;


8.
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;




The JOIN operation


1.
SELECT matchid, player 
FROM goal 
  WHERE teamid='GER';

2.SELECT id,stadium,team1,team2
  FROM game WHERE id=1012;;
  
  
3.SELECT player, teamid, stadium , mdate
  FROM game 
JOIN goal ON (id=matchid)
WHERE teamid='GER';


4.
SELECT team1, team2 , player
  FROM game 
JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%';


5.SELECT player, teamid,coach, gtime
  FROM goal 
JOIN eteam ON teamid=id
 WHERE gtime<=10
 
 
6.SELECT game.mdate , eteam.teamname
FROM  game JOIN eteam ON (team1=eteam.id)
WHERE coach='Fernando Santos';


7.SELECT goal.player 
FROM  goal JOIN game ON (goal.matchid=game.id)
WHERE stadium='National Stadium, Warsaw';


8.SELECT DISTINCT player 
FROM game JOIN goal ON (id = matchid)
WHERE (team1 = 'GER' OR team2 = 'GER') AND teamid != 'GER'


9. SELECT teamname, COUNT(*)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname
 
 
10.SELECT stadium, COUNT(*) 
FROM game JOIN goal ON id = matchid
GROUP BY stadium;



11.SELECT matchid,mdate, COUNT(*)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid,mdate;



12.SELECT matchid, mdate, COUNT(*) 
FROM game JOIN goal ON id = matchid
WHERE teamid='GER'
GROUP BY matchid,mdate;


13.SELECT mdate, 
       team1, 
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1, 
       team2, 
       SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2 
FROM game LEFT JOIN goal ON (id = matchid)
GROUP BY id,mdate,team1,team2
ORDER BY mdate, matchid;



More JOIN operations
1.SELECT id, title
 FROM movie
 WHERE yr=1962
 
 
2.SELECT yr
 FROM movie
 WHERE title='Citizen Kane'
 
 
3.SELECT id, title,yr
 FROM movie
 WHERE title LIKE '%Star Trek%'
ORDER BY yr


4.SELECT id FROM actor
WHERE name = 'Glenn Close';


5.SELECT id FROM movie
WHERE title = 'Casablanca';


6.SELECT name
FROM casting JOIN actor ON actorid=id
WHERE movieid = 11768;



7. 
SELECT actor.name
FROM actor
JOIN casting ON casting.actorid = actor.id
JOIN movie ON movie.id = casting.movieid
WHERE movie.title = 'Alien';



8.
SELECT movie.title
FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford';


9.
SELECT movie.title
FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford' AND casting.ord !=1;;



10.
SELECT movie.title , actor.name
FROM movie 
JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE movie.yr = 1962 AND casting.ord = 1;


11.
SELECT movie.yr,COUNT(*) 
FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2


12.
SELECT title , name
FROM movie
JOIN casting ON movieid=movie.id AND ord=1
JOIN actor   ON actorid=actor.id
WHERE movie.id 
IN (SELECT movieid FROM casting WHERE actorid IN(SELECT id FROM actor WHERE name='Julie Andrews'))



13.
SELECT actor.name
FROM actor
JOIN casting ON casting.actorid = actor.id
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(*) >= 15;


14.
SELECT title, COUNT(actorid) 
FROM movie 
JOIN casting ON movie.id = movieid 
WHERE yr = 1978
GROUP BY title 
ORDER BY COUNT(actorid) DESC, title;



15.

SELECT distinct actor.name
FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE movie.id 
IN (SELECT movieid FROM casting JOIN actor ON id=actorid WHERE actor.name='Art Garfunkel') 
AND actor.name != 'Art Garfunkel'





Using Null
1.
SELECT name 
FROM teacher
WHERE dept IS NULL;


2.
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)
           
           
3.
SELECT teacher.name, dept.name 
FROM teacher 
LEFT JOIN dept ON (teacher.dept = dept.id);


4.
SELECT teacher.name, dept.name 
FROM teacher 
RIGHT JOIN dept ON (teacher.dept = dept.id);


5.
SELECT name, COALESCE(mobile, '07986 444 2266') AS mobile 
FROM teacher;


6.
SELECT teacher.name, COALESCE(dept.name , 'None') 
FROM teacher 
LEFT JOIN dept ON (teacher.dept = dept.id);


7.
SELECT COUNT(name), COUNT(mobile)
FROM teacher


8.
SELECT dept.name, COUNT(teacher.name) 
FROM teacher RIGHT JOIN dept ON dept.id = teacher.dept 
GROUP BY dept.name;


9.
SELECT name, 
CASE WHEN dept IN (1, 2) THEN 'Sci' ELSE 'Art' END 
FROM teacher;


10.
SELECT name, 
CASE WHEN dept IN (1, 2) THEN 'Sci' 
     WHEN dept = 3 THEN 'Art' 
     ELSE 'None' 
END 
FROM teacher;


Self join

1.
SELECT COUNT(DISTINCT(id))
FROM stops

2.
SELECT id
FROM stops
WHERE name='Craiglockhart'

3.
SELECT id, name
FROM stops
JOIN route ON id=stop
WHERE num = '4' AND company = 'LRT';

4.
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) >= 2;


5.
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = 149;

6.
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name = 'London Road';

7.
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=115 AND b.stop = 137;


8.
SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name = 'Tollcross';

9.
SELECT DISTINCT stopb.name, a.company, a.num
FROM route a  JOIN route b  ON a.company = b.company AND a.num = b.num
JOIN stops stopa ON a.stop = stopa.id
JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart';





















































   
   
   
   
   
   
   
   
   



