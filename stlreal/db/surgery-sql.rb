require 'rubygems'
require 'sqlite3'
require 'csv'

DBNAME = "ca-common-surgeries.sqlite"
DB = SQLite3::Database.open( DBNAME )
TABLE_NAME = "surgery_records"

q = "SELECT procedure, SUM(discharge_count) 
   FROM #{TABLE_NAME} 
   GROUP BY procedure 
   ORDER by procedure DESC"

results = DB.execute(q)  

puts results 
# -- procedures = results.map{|row| row[0].split(' ').map{|s| s[0..3]}[0..2].join.gsub(/[^\w]/,'')}            
# -- discharge_counts = results.map{|row| row[1]}   

# -- G_URL = "https://chart.googleapis.com/chart?cht=bhs&chs=400x600&chds=a&chbh=10&chxt=x,y"
# -- puts "#{G_URL}&chd=t:#{discharge_counts.join(',')}&chxl=1:|#{procedures.join('|')}"    





# -- SELECT 3;

# -- SELECT * FROM loans

# -- SELECT * FROM stars

# -- SELECT name, class FROM stars

# -- SELECT name, class AS starcolor FROM stars

# -- SELECT name, ((class+7)*intensity)*1000000 AS temperature FROM stars

# -- SELECT * FROM stars WHERE starid=2348

# -- SELECT * FROM stars WHERE starid>1000 AND starid<2000 AND class=0

# -- SELECT * FROM stars WHERE starid>1000 AND starid<2000 AND class=0 ORDER BY intensity


# -- SELECT * FROM stars WHERE starid>1000 AND starid<2000 AND class=0 ORDER BY intensity DESC

# -- SELECT COUNT() FROM stars

# -- SELECT MAX(x) FROM stars

# -- SELECT AVG(x*x+y*y+z*z) FROM stars



# -- fyi INSERT INTO tablename (column names) VALUES (values for the columns)

# -- INSERT INTO hilight VALUES (12340)

# -- DELETE FROM hilight

# --  accidents do happen - you can always regenerate it from the file menu -> radical operations -> renegerate database (25k)).

# -- Hilight five stars which have star id between 5000 and 15000, and have class 7. (Hint: don't try to do this with a single query at this point

# -- NSERT INTO tablename (column names) SELECT ..

# -- INSERT INTO hilight SELECT starid FROM stars WHERE x > 0

# -- **Hilight all the stars with starid between 10000 and 11000. (I know, this is not too difficult, but it looks neat).

# -- DELETE FROM tablename WHERE conditions

# -- BEGIN; DELETE FROM stars WHERE x>0 AND y>0; INSERT INTO hilight SELECT starid FROM stars WHERE ((x-0.5)*(x-0.5) + (y+0.5)*(y+0.5)) < 0.02

# -- You can enter multiple queries at once in SQLite if you separate the commands with a semicolon; this may also work on other database engines.


# -- To undo the changes, execute:
# -- ROLLBACK


# -- If you wish to make your changes permanent, execute:
# -- COMMIT
# -- or
# -- END

# -- Kill off all stars with starid lower than 10000. Do this inside a transaction, so that when I run the ROLLBACK command, we're back with the original galaxy.

# -- The syntax for the UPDATE command is:
# -- UPDATE tablename SET operations WHERE conditions

# -- As usual, the WHERE part can be omitted to operate on all rows in the table.
# -- UPDATE can also be rather dangerous, so it's best to use it inside transactions. Try this one:

# -- BEGIN;UPDATE stars SET x=(x/(x*y+0.1))*0.1,y=(y/(x*y+0.1))*0.1

# -- BEGIN; UPDATE stars SET z=z+(starid-12500)*0.00005

# -- Remember to ROLLBACK after you've done looking at that one.

# -- Starting from the normal galaxy, update it so that you swap the x and z coordinates for stars which have star id between 10000 and 15000.

# -- The galaxy consists of three tables - stars, planets and moons. Let's look at planets.

# -- SELECT * FROM planets

# -- To list all stars which have planets, you could try:
# -- SELECT stars.starid FROM planets, stars WHERE planets.starid=stars.starid

# -- As you can see, we can SELECT from several tables at once, and make choises on what to select based on several table's fields. Like with column names, we can use aliases for table names, like this:

# -- SELECT s.starid FROM planets AS p, stars AS s WHERE p.starid=s.starid

# -- SELECT DISTINCT s.starid FROM planets AS p, stars AS s WHERE p.starid=s.starid

# -- The same applies for the relationship between planets and moons. To list all the planets with moons, try:
# -- SELECT DISTINCT p.planetid FROM planets AS p, moons AS m WHERE p.planetid=m.planetid


# -- Finally, to list all the stars with planets with moons..
# -- SELECT DISTINCT s.starid FROM planets AS p, moons AS m, stars AS s WHERE s.starid=p.starid AND p.planetid=m.planetid

# -- Hilight all stars with starid of at least 20000, which have planets with moons that have an orbit distance of at least 3000. Remember to remove any old hilights before starting.


# -- The results of a query can also be considered to be a table, and can, thus, be queried. (If this doesn't make your head hurt, then nothing in SQL probably will).
# -- Let's say we want to find out how many stars have higher than average intensity.
# -- First, we'd find the average intensity by calling:
# -- SELECT avg(intensity) FROM stars

# -- And we know we can count the resulting rows with COUNT(). Combining these, we get:
# -- SELECT COUNT() FROM stars, (SELECT AVG(intensity) AS ai FROM stars) WHERE intensity > ai

# -- We can continue this by doing a sub-subquery. Here we count the stars that have higher than average intensity of those stars that have higher than average intensity.
# -- SELECT COUNT() FROM stars, (SELECT AVG(intensity) AS ai2 FROM stars, (SELECT AVG(intensity) AS ai FROM stars) WHERE intensity > ai) WHERE intensity > ai2

# -- Hilight the star (or stars) which has the planet with the highest orbit distance in the galaxy. Remember to clear the old hilights before beginning. 

# -- We've seen how it is useful to join several tables into one. There's more to joining than we've used so far; the more advanced 'join' syntax goes like this:
# -- SELECT columns FROM table1 JOIN table2 ON conditions

# -- There are several kinds of JOIN commands. There are INNER JOINs, CROSS JOINs, and LEFT, RIGHT and FULL OUTER JOINs. Other kinds also exist, but the support for different kinds of join operations varies, but the basic INNER JOIN and LEFT OUTER JOIN are usually supported.


# -- Starting from the easy bits, you've already done INNER JOINs.
# -- SELECT stars.name FROM stars, planets WHERE stars.starid=planets.starid

# -- ..is roughly equivalent to..
# -- SELECT stars.name FROM stars JOIN planets ON stars.starid=planets.starid

# -- With a NATURAL JOIN, you could simplify the above to:
# -- SELECT stars.name FROM stars NATURAL JOIN planets


# -- Anyway. JOIN without any extra specifiers gives you INNER JOIN. CROSS JOIN is the same as SELECT without a WHERE clause. Many database engines consider CROSS JOIN and INNER JOIN to be the same thing, allowing the ON clause (or lack thereof) on both.

# -- OUTER JOINs are, however, a different case. In LEFT OUTER JOIN, you select all rows from the first (leftmost) table, padded with the information from the second table, assuming anything is available. If not, NULLs are added.
# -- The effect is easiest to understand by looking at an example:
# -- SELECT stars.name AS sn, planets.name AS pn FROM stars LEFT OUTER JOIN planets ON stars.starid=planets.starid

# -- SELECT stars.name AS sn, planets.name AS pn FROM stars LEFT OUTER JOIN planets ON stars.starid=planets.starid

# -- RIGHT OUTER JOIN would do the same thing, but this time the full selection would be done for the rightmost table, and FULL OUTER JOIN would select all rows from both tables, merging them with NULLs where applicable. SQLite does not support RIGHT or FULL OUTER JOINs, though.

# -- Generate a list of stars with star ids below 100 with columns "starname", "startemp", "planetname", and "planettemp". The list should have all stars, with the unknown data filled out with NULL. These values are, as usual, fictional. Calculate the temperature for a star with ((class+7)*intensity)*1000000, and a planet's temperature is calculated from the star's temperature minus 50 times orbit distance. 

# -- I mentioned before (when discussing subqueries) that query results are just like tables. Sometimes these results are useful to keep around, and made "somewhat permanent" - this is where VIEWs come in.
# -- The sytax for creating a VIEW is as follows:
# -- CREATE VIEW viewname AS query

# -- CREATE VIEW relations AS SELECT stars.starid AS star, planets.planetid AS planet, moons.moonid AS moon FROM stars LEFT OUTER JOIN planets ON stars.starid=planets.starid LEFT OUTER JOIN moons ON planets.planetid=moons.planetid

# -- After this, the view can be queried just like a table:
# -- SELECT * FROM relations

# -- There are some limitations, though. SELECT will work, but just about any other operation will depend on the database engine. SQLite will only let you perform SELECTs on VIEWs.
# -- You can get rid of an undesired VIEW with the DROP VIEW command:

# -- DROP VIEW viewname

# -- This command will only remove the VIEW; no actual data will be removed. Thus, to remove the VIEW we created above, you'd run:
# -- DROP VIEW relations


# -- Create a VIEW called "numbers" with the columns "three", "intensity" and "x", where "x" and "intensity" come from the stars-table, "three" contains the number 3 on all rows. For additional fun, sort the whole thing by "x" - although I won't care. 

# -- In order to be able to input any data into a database, you will first need to plan and create tables. While designing good tables and their relations is a challenge, creating a single table is not very complicated.

# -- Tables are created with CREATE TABLE, with the syntax:
# -- CREATE TABLE tablename (columnname datatype constraints, ...) 

# -- Typically, a database engines have data types such as CHAR(length), VARCHAR(length), NUMERIC(length.decimals), INTEGER, REAL, FLOAT(length), DOUBLE, DATE, TIME, MONEY, BLOB.. The supported data types vary from one database to another.

# -- Let's say we want to create a table about persons.
# -- CREATE TABLE persons (personid INTEGER PRIMARY KEY, name TEXT, hats INTEGER)

# -- This will create a table with columns personid (which is type INTEGER and is the PRIMARY KEY of this table - we'll look deeper into this in the next chapter), name (which is TEXT) and hats (the number of hats this person owns - definitely INTEGER).

# -- We can use INSERT INTO to populate this table a bit.
# -- INSERT INTO persons (name, hats) VALUES ('John', 3);INSERT INTO persons (name, hats) VALUES ('Mary', 2)

# -- To destroy the 'persons' table, try:
# -- DROP TABLE persons


# -- Create a table named 'colors' with the columns 'color' and 'description'. Color is integer, description is text. Populate the table with color values from -3 to 10; each star class has its own color; fill the description with something (I won't care exactly what). Basic idea is that it will be possible to make a join between stars and colors where stars' class is compared to colors' color number. 

# -- Databases often contain lots of important information, such as people's money, customer data, or the parameters of a virtual universe. If this information goes out of sync, disastrous things might happen (if nothing else, the person responsible for the database might get fired).

# -- CREATE TABLE months (monthid INTEGER PRIMARY KEY, name TEXT UNIQUE NOT NULL) 

# -- PRIMARY KEY
# -- The primary key of a table is used to single out a specific row in the table. Hence, it must be unique and (most likely) also not NULL. SQLite generates unique values to the PRIMARY KEY at least if the PRIMARY KEY is INTEGER.

# -- FOREIGN KEY
# -- Pair for PRIMARY KEY. Having this constraint enforces that the value in FOREIGN KEY can be found as PRIMARY KEY on some other table. SQLite does not support FOREIGN KEYs.

# -- Create a table called "quotes" with two columns: "id", which is primary key, and takes integers, and "quote" which contains non-null text strings, such as quote of the day (http://www.qotd.org/). Fill in a couple of rows so that I have something to query for. 

# -- The syntax for the ALTER TABLE command is:
# -- ALTER TABLE tablename alteration

# -- ALTER TABLE stars RENAME TO bright_objects

# -- ADD COLUMN
# -- To add new fields to a table, you can use the ADD COLUMN alteration. For example:
# -- ALTER TABLE hilight ADD COLUMN notes TEXT

# -- Note that this will add NULL values to every row for that column. There are some limitations on what you can add; see the reference for details.

# -- RENAME COLUMN.. TO..
# -- This command can be used to rename a column. SQLite does not support RENAME COLUMN. Example:
# -- ALTER TABLE hilight RENAME COLUMN notes TO remarks 

# -- MODIFY COLUMN
# -- To change the data type of a column, you could use this command. SQLite does not support MODIFY COLUMN.
# -- ALTER TABLE hilight MODIFY COLUMN remarks CHAR(200) NOT NULL 

# -- DROP COLUMN
# -- Removes a column from a table. SQLite does not support DROP COLUMN.
# -- ALTER TABLE hilight DROP COLUMN remarks 



# -- First, create and populate a table using command below.
# --  Rename the table to 'my_table', and add a column called 'moredata'. Add one whole new row and change the 'moredata' value of at least one existing row. (Yes, I'm aware you could do all that by changing the creation commands, but that is not the point of this excersize).
# -- CREATE TABLE alter_test (id INTEGER PRIMARY KEY, data TEXT NOT NULL); INSERT INTO alter_test (data) VALUES ('Foo'); INSERT INTO alter_test (data) VALUES ('Bar'); INSERT INTO alter_test (data) VALUES ('Baz');



# -- Let's look at couple of SELECT operations we haven't covered yet, namely GROUP BY and HAVING.
# -- The syntax for these operations looks like this:
# -- SELECT columns FROM table GROUP BY column HAVING expression 


# -- Let's look at couple of SELECT operations we haven't covered yet, namely GROUP BY and HAVING.
# -- The syntax for these operations looks like this:
# -- SELECT columns FROM table GROUP BY column HAVING expression 

# -- The GROUP BY command in a SELECT causes several output rows to be combined into a single row. This can be very useful if, for example, we wish to generate new statistical data as a table.


# -- For example, to find out the highest intensities from stars for each class, we would do:
# -- Select Class, Max(Intensity) As Brightness From Stars Group By Class Order By Brightness Desc


# -- The HAVING operator works pretty much the same way as WHERE, except that it is applied after the grouping has been done. Thus, we could calculate the sum of brightnesses per class, and crop out the classes where the sum is higher than, say, 150.


# -- SELECT class, SUM(intensity) AS brightness FROM stars GROUP BY class HAVING brightness < 150 ORDER BY brightness DESC


# -- When combined with joins, GROUP BY becomes rather handy. To find out the number of planets per star, we can do:
# -- SELECT stars.starid AS starid, COUNT(planets.planetid) AS planet_count FROM planets, stars WHERE stars.starid=planets.starid GROUP BY stars.starid

# -- Hilight the star with most orbitals (combined planets and moons). (Note that the validation query is somewhat heavy, so be patient after pressing "Ok, I'm done.."). 

# -- SQL databases can perform boolean operations on queries. This can be handy when you need to do something that normal queries just don't seem to handle. You can take two queries and perform union, intersection or substraction operations between them. (The supported operations, as always, vary from one database engine to another).


# -- The syntax for the boolean operations looks like this:
# -- SELECT .. boolean operation SELECT .. 


# -- The operations are:
# -- UNION
# -- Union combines the two queries and discards the duplicates. For instance,
# -- SELECT 1 UNION SELECT 1 UNION SELECT 3

# -- returns only two rows, as 1 is duplicated.

# -- SELECT COUNT() FROM (SELECT starid FROM stars UNION SELECT starid FROM planets)

# -- UNION ALL
# -- The union all works the same way as union, except that it does not discard the duplicates. Looking at the same examples with UNION ALL:
# -- SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 3


# -- SELECT COUNT() FROM (SELECT starid FROM stars UNION ALL SELECT starid FROM planets)

# -- ..returns a number that's higher than the star count - in fact, it's the sum of the number of stars and the number of planets in the galaxy.

# -- galaxy.INTERSECT
# -- Intersection returns only the rows which match. If we replace the UNION with INTERSECT in our stars-planets count query:
# -- SELECT COUNT() FROM (SELECT starid FROM stars INTERSECT SELECT starid FROM planets)



# -- EXCEPTThe except-query performs substraction, which is the opposite of the intersection. Looking at the same example again:
# -- SELECT COUNT() FROM (SELECT starid FROM stars EXCEPT SELECT starid FROM planets)

# -- ..will return the number of stars which do not have any planets.

# -- Build a query which returns starids from planets.
# -- The starids should be selected so that for each starid (x) in the list:
# -- - there should exist a planet with a starid that's three times x
# -- but
# -- - there should not exist a planet with starid two times x.
# -- Only use starid:s from the planets table.

# -- Syntax for creating a trigger looks like this:
# -- CREATE TRIGGER name when event ON tablename action 

# -- where 'when' can be BEFORE or AFTER, and 'event' can be any of DELETE, INSERT or UPDATE.

# -- 'action' can be FOR EACH ROW BEGIN .. END, FOR EACH STATEMENT BEGIN .. END or WHEN expression BEGIN .. END.



# -- Special table references OLD and NEW exist that can be used in the triggered queries. Several, semicolon-separated actions can be included between BEGIN and END.

# -- For instance, to delete planets when a star is deleted, we could do:
# -- CREATE TRIGGER stardeleted BEFORE DELETE ON stars FOR EACH ROW BEGIN DELETE FROM planets WHERE planets.starid=OLD.starid; END

# -- Similarily, to delete moons when a planet is deleted, we could do:
# -- CREATE TRIGGER planetdeleted BEFORE DELETE ON planets FOR EACH ROW BEGIN DELETE FROM moons WHERE OLD.planetid=moons.planetid; END


# -- After the above, you can delete all stars (inside transaction):
# -- BEGIN; DELETE FROM stars
# -- (Try it!) 
# -- (this query will take a while, so be patient)


# -- Be sure to run rollback after you're done. Some database engines support cascades to perform the above kinds of cleanup tasks.
# -- Triggers are deleted with the DROP TRIGGER command:
# -- DROP TRIGGER name 


# -- Most database engines also support stored procedures and stored functions which can be used to add further intelligence to the database. They are, however, very database engine specific, so we won't be covering them.

# -- Create a trigger which, when a new star is created, clears the hilight table and inserts the new star id to the hilight table.

# -- Indexes are used to speed up the database. As such, they may be quite different on different database engines.


# -- Let's say we create a new table, here:
# -- CREATE TABLE gateway (star1 INTEGER PRIMARY KEY, star2 INTEGER)


# -- Let's say we create a new table, here:
# -- CREATE TABLE gateway (star1 INTEGER PRIMARY KEY, star2 INTEGER)

# -- And we populate it with some random data:
# -- INSERT INTO gateway SELECT starid, RANDOM()%12500+12500 FROM stars WHERE starid%100=0

# -- (The RANDOM() function and the % modulo operator are SQLite specific, and may not appear in other database engines).

# -- After this, a very innocent-looking query, like the following, can take a very long time: (if GalaXQL seems slow to you generally, you may wish to skip this one)
# -- SELECT starid FROM stars, gateway WHERE star2=starid

# -- The reason for the slowness is that the database engine has no idea on where to find the 'star2' value that matches the 'starid' value, and thus has to go through the gateway table completely for each star.


# -- Now, if we add an index to the table:
# -- CREATE INDEX gateways_star2 ON gateway (star2)

# -- ..we will find that the very same SELECT query is faster by several orders of magnitude. (The reason why we don't need an index for the PRIMARY KEY is that SQLite creates indexes for primary keys automatically).


# -- You may have noticed that the 'gateway' table is singular while stars, planets and moons are plural.

# -- Use ALTER TABLE to rename the 'gateway' table to 'gateways'. (ALTER TABLE was covered in chapter 16).