-- START OF FILE ================================================================
--
--		    ============================
--
--          MICE CINEMAS -- ASSIGNMENT 2
--
--          ============================
--
-- TASK ONE - Insertion of data ( 3 parts )
-- TASK TWO - Queries ( 12 in total )
--
-- PLESE READ THIS DOCUMENT CAREFULLY.
-- -----------------------------------
--
-- BEFORE YOU START you must check you have completed the following:
-- 
--  0 Download MICE_Table_and_Data.sql from CANVAS. It is available
--    from the assignment description window
--  0 Upload and run script (F5) on MICE_Table_and_Data.sql in an
--    SQL Developer worksheet.
--    You should see the following output:
--
-- Dropping Tables ...
-- Create Tables ...
--  ... A2_CINEMA
--  ... A2_STAFF
--  ... A2_CINEMA (FK Manager added)
--  ... A2_SCREEN
--  ... A2_FILM
--  ... A2_SHOWING
--  ... A2_PERFORMANCE
 
-- All tables created.

-- Populate Tables ...
--  ... A2_Cinema
--  ... A2_Staff
--  ... A2_Film
--  ... A2_Screen
--  ... A2_Showing
--  ... A2_Performance
--
-- All tables populated.
--
--  0 Confirm that 6 new tables exist all starting in A2_ and they contain data
--
--  0 PLEASE NOTE: all tables referenced in your inserts and queries must start
--    with A2_ . This distinguishes them from previous tables and they all appear
--    in a group on the SQL Developer connections window.
--
--  0 Check each table contains data records. The number of records in each is
--    given above as reported when running MICE_Table_and_Data.sql.
--
--  0 ONLY once you are happy with the tables and data, should you progress to
--    the two tasks:
--
--
-- TASK ONE - ADDING DATA - 16 marks in total
-- ======================
--
-- You must add the following data to that already inserted into the 6 table
-- schema.
-- DO NOT remove any existing records
--
-- ADD the following:
--
--  1 - Create a yourself as a member of staff which includes your name and where
--      the Employee_No is  your SRN. The remaining attributes can be data you make
--      up. There should be no duplication between your SRN and the data in the
--      dataset, but if this does occur, add 1 to your SRN.
--      You can choose which cinema you are employed at unsupervised!!
--                                                                  [ 4 marks ]
--
--  2 - Create two showings at a cinema and screen of your choice from the database.
--
--      Showing 1 MUST contain a single performance of a new film you must also add
--      to the film table. 
--						  						                    [ 6 marks ]
--
--  3 - Showing 2 MUST contain three performances of a film already in the
--      database showing on consecutive days.
--								  				                    [ 6 marks ]
--
--
--  NOTES:
--	Its a good idea to store your final INSERT commands in a script file
--
--	If during this process, you corrupt the dataset, go back and use the
--      script downloaded to reset the original tables and data
--
--	Once you are happy ALL INSERTS are correct, it may be a good idea to
--      run the two scripts ( supplied and yours) again to refresh the
--      dataset before starting Task 2
--
-- END OF ASSIGNMENT TASK ONE ----------------------------------------------------
--
--
-- TASK TWO - QUERYING  [ 7 marks per query ] 84 in total
-- ===================
--
-- For this task use SQL Developer to build queries that provide the correct
-- answer to the question asked. Once the query is correct, COPY THE CODE INTO
-- THE SPACES PROVIDED. Answer as many questions if you can.
--
-- Hints are provided to help you understand what is needed
--
-- Solution Tests indicate how the output should appear if correct and contains
-- formatting guidance.
--
-- Submission instructions are given at the end of this file.
--
--
-- QUESTION 1
-- ==========
--
-- Produce a list of film names which have a date of release this century.  
-- 
-- Solution Test: 6 Films meet this criteria
--
-- FILM_NAME                                                                       
-- ---------------------------
-- Black Panther
-- Parasite
-- Avengers: Endgame
-- Knives Out
-- Us
-- Get Out
--
-- Type your query below:

Select Film_Name From A2_FILM WHERE Year_Released >= '01-JAN-00'


-- QUESTION 2
-- ==========
--
-- Use a nested select statement to provide the full name and adress details of the cinemas
-- managed by the staff called Claire Wilson and Coren O'Halloran (DO NOT manually lookup
-- their Employee Numbers.)
-- 
-- Solution Test: 
-- CINEMA_NAME                                        LOCATION                                                                                            
-- -------------------------------------------------- -----------------------------------
-- The Glory Showhouse                                16, Leevale Drive, Linton                                                                           
-- Masterton Multiplex                                11, High Street, Masterton
--
-- Type your query below:

SELECT Cinema_Name, Location FROM A2_Cinema WHERE Cinema_Name IN (Select Cinema FROM A2_STAFF WHERE NAME = 'Claire Wilson' OR NAME = 'Coren O''Halloran');


-- QUESTION 3
-- ==========
--
-- Lec Dombrovski has phoned in sick, Create a query to report the name and phone
-- number of his supervisor.
--
-- Solution Test: 
-- NAME                                      PHONE_NO   
-- ----------------------------------------- -----------
-- Petr Cillich                              04992730026
--
-- Type your query below:

SELECT Name, Phone_No FROM A2_Staff WHERE Employee_No IN (Select Supervisor FROM A2_STAFF WHERE NAME = 'Lec Dombrovski')


-- QUESTION 4
-- ==========
--
-- Write a report of all films shown in August 2021 more than 16 times, give the films name,
-- how many performances of these films there were and how much those films took in total
-- over that period. List the films by the film that took the most money first, and provide
-- meaningful headings to the columns in the output as shown in the Solution Test below.
--
-- Hint: 
--
-- Solution Test:

-- FILM_NAME                   Performances Total Takings         
-- --------------------------- ------------ ----------------------
-- It Happened One Night       39               £63,571 
-- Modern Times                38               £58,332 
-- Parasite                    23               £37,195 
-- Knives Out                  22               £34,362 
-- Citizen Kane                25               £32,711 
-- The Wizard of Oz            18               £21,716 
-- Avengers: Endgame           18               £17,081
--
-- Type your query below:

SELECT a2_Film.Film_Name, count(*) as "Performances", TO_CHAR(SUM(A2_Performance.Takings), 'fm99G999') AS "Total Takings"

FROM A2_SHOWING 

JOIN A2_Film ON A2_Showing.Film_No = A2_Film.Film_No
JOIN A2_Performance ON A2_Showing.Showing_No = A2_Performance.Showing_No WHERE a2_performance.performance_date >= '01/AUG/2021' and a2_performance.performance_date <= '31/AUG/2021' group by a2_Film.Film_Name having count(*) > 16 ORDER BY sum(a2_performance.Takings) DESC;


-- QUESTION 5
-- ==========
--
-- Report how much each cinema took on the 12th August, the report should
-- include the name of the cinema and the value of the takings in the report.
-- Order by highest takings first. The output should also be formatted as
-- shown below.
--
-- Cinema                         Takings on August 12  
-- ------------------------------ ----------------------
-- Masterton Multiplex            £5,731 
-- The Glory Showhouse            £2,424 
-- Grange Cinema                  £1,974 
-- Treban Picturehouse            £1,719 
-- Marvale Rex                    £1,005
--
-- Hint: Use the format operator (L) to create the use of the £
-- symbol.
--
-- Solution Test: 
--
-- Type your query below:

SELECT A2_Showing.Cinema AS "Cinema", TO_CHAR(SUM(A2_Performance.Takings), 'fmL99G999') AS "Takings on August 12" FROM A2_SHOWING 
LEFT JOIN A2_Performance ON A2_Showing.Showing_No = A2_Performance.Showing_No WHERE A2_Performance.Performance_Date = '12-AUG-21' GROUP BY A2_Showing.Cinema order by SUM(A2_Performance.Takings) DESC;


-- QUESTION 6
-- ==========
--
-- List the age in years of the oldest employee at each cinema. Order the report by the
-- cinema with the most employees first. Output should be formatted as below.
--
-- Hint: Use the examples in the SQL Sessions to determine the age in years of staff.
--
-- Solution Test:   
--
-- Cinema                                              Oldest Employee
-- -------------------------------------------------- ----------------
-- Masterton Multiplex                                              56
-- Grange Cinema                                                    48
-- The Glory Showhouse                                              52
-- Marvale Rex                                                      62
-- Odeon on the Hill                                                61
-- Flix                                                             57
-- Treban Picturehouse                                              34
--
-- Type your query below:

Select Cinema AS "Cinema", trunc(months_between(sysdate, min(dob))/12) AS "Oldest Employee" From A2_Staff Group BY Cinema ORDER BY count(Employee_No) DESC;


-- QUESTION 7
-- ==========
--  
-- Which were the showings with the most performances? In which cinema were,
-- they shown, on which screen and how many performances were there starting
-- on which date. Format the output as given below:
--
-- Hint: Reserach the formatting operators fm and th
--
-- Solution Test: 
--
-- Cinema                                                 Screen Performances Started on                                                                     
-- -------------------------------------------------- ---------- ------------ -------------------------------------------------------------------------------
-- Marvale Rex                                                 1            9 Friday, September 3rd                                                          
-- Treban Picturehouse                                         2            9 Monday, August 9th                                                             
-- Treban Picturehouse                                         1            9 Monday, September 20th                                                         
-- Odeon on the Hill                                           2            9 Sunday, August 15th
--
-- Type your query below:

select a2_showing.cinema as "Cinema", a2_showing.screen as "Screen", count(*) as "Performances", TO_CHAR(min(a2_Performance.Performance_date),'DAY, MONTH DTH') as "Started on" FROM A2_SHOWING JOIN A2_Performance ON A2_Showing.Showing_No = A2_Performance.Showing_No group by A2_Showing.Showing_No, a2_showing.cinema, a2_showing.screen HAVING COUNT(*) = (

SELECT max(count(*)) 

FROM A2_SHOWING JOIN A2_Performance ON A2_Showing.Showing_No = A2_Performance.Showing_No group by A2_Showing.Showing_No);


-- QUESTION 8
-- ==========
--  
-- Produce a report for all showings of "Casablanca", providing the film name,
-- in which cinema each showing took place and the takings per seat available
-- and takings per person attending.
--
-- Hint: Use the total takings and the total capacity to determine the average
--       not the AVG function. Use formatting to limit the decimal places to 2.
--
-- Solution Test: 
-- FILM_NAME  CINEMA                                             Takings per seat Takings per person   
-- ---------- -------------------------------------------------- ---------------- ------------------
-- Casablanca Marvale Rex                                                   £9.62             £12.81 
-- Casablanca The Glory Showhouse                                          £12.14             £12.67 
-- Casablanca Treban Picturehouse                                          £10.87             £13.31 
-- Casablanca Grange Cinema                                                £15.02             £19.25 
--
-- Type your query below:

SELECT 'Casablanca' as "FILM_NAME", a2_showing.cinema, sum(a2_screen.Capacity), '£' || ROUND(sum(a2_performance.takings) / sum(a2_screen.Capacity), 2) as "Takings per seat", '£' || ROUND(sum(a2_performance.takings) / sum(a2_performance.Attendees), 2) as "Takings per person"

FROM A2_SHOWING 

JOIN A2_Film ON A2_Showing.Film_No = A2_Film.Film_No
JOIN A2_Performance ON A2_Showing.Showing_No = A2_Performance.Showing_No
JOIN A2_Screen ON A2_Showing.Cinema = A2_Screen.Cinema and a2_showing.Screen = a2_Screen.Screen WHERE  a2_film.film_name = 'Casablanca' group by a2_showing.showing_no, a2_showing.cinema;



-- QUESTION 9
-- ==========
--
-- Write a query to list the cinema names of all cinemas which employ more than 12 employees.
-- 
-- Solution Test: 
--
-- CINEMA_NAME                                   Number of Staff
-- --------------------------------------------- ---------------
-- Grange Cinema                                              20
-- Masterton Multiplex                                        27
-- The Glory Showhouse                                        15
--
-- Type your query below:

SELECT a2_Cinema.Cinema_Name, count(a2_Cinema.Cinema_Name) as "Number of Staff"
FROM a2_Cinema
LEFT JOIN A2_staff
ON A2_Cinema.Cinema_name = A2_staff.cinema group by a2_Cinema.Cinema_Name HAVING count(a2_Cinema.Cinema_Name) > 12;       


-- QUESTION 10, 11, 12
-- ===================
-- Write three queries to provide information about YOU and YOUR orders from
-- Task 1
-- 
-- 10
-- ==
--
-- Create a single line report containing YOUR details as entered on the database
-- in the following format:
--
-- Fullname                        Address                                                   Employed for                                                                       
-- ------------------------------- --------------------------------------------------------- ---------------------------
-- Leon Marvin                     The Marches, Teal Avenue, Lindon                          9y 10m                                                                             
--	Fullname         Address                              Employed for                                                                    
--
-- Where 9y 10m indicates you has been employed for 9 complete years
-- plus 10 complete months at the time the query is run
--
-- Hint: 
--
-- https://docs.oracle.com/cd/E11882_01/server.112/e41084/functions002.htm#SQLRF51178
--
-- Type your query below:

select Name as "Fullname", Address, CAST(trunc(months_between(sysdate, Date_Joined)/12) as varchar(10)) || 'y ' ||  CAST(trunc(mod(months_between(sysdate, Date_Joined), 12)) as varchar(10)) || 'm' as "Employed" from a2_Staff Where Name = 'Terrence Corner';


--
-- 11
-- ==
--
-- Write a query to output the details of single film performance onput in
-- Task 1 part 2.
-- The details needed are the film name, and the cinema, screen, and date and
-- time it is being shown.
--
-- The headings and details should be meaningful to any reader of the report.
-- I.e.
--
-- Film Title                            Cinema                                Screen Date              Time 
-- ------------------------------------- ------------------------------------- ------ ----------------- -----
-- Modern Times                          Grange Cinema                         2      Wed 01-Sep-2021   08:15
--
-- Hint: 
--
-- Type your query below:

SELECT A2_Film.Film_Name as "Film Title", a2_Showing.Cinema as "Cinema", a2_Showing.Screen as "Screen", TO_CHAR (a2_Performance.Performance_Date , 'Dy D-MON-yyyy') as "Date", TO_CHAR (a2_Performance.Performance_Time, 'HH24:MI') as "Time"
FROM a2_Performance JOIN A2_Showing
ON A2_Showing.Showing_No = A2_Performance.showing_no
JOIN A2_Film ON A2_Film.Film_No = A2_Showing.Film_No WHERE A2_Film.Film_Name = 'Cars 2' and a2_Performance.Performance_Date = '26/NOV/2021';   




--
-- 12
-- ==
--
-- Write a query to output the details of the three night showing you entered as shown
-- below.
--
-- Showin Film Title            Cinema          Screen First Night    Last Night                                          
-- ------ --------------------- --------------- ------ -------------- ---------------
-- 183557 Knives Out            Grange Cinema        3 Fri August 6  Sun August 8                                    
--
-- Hint: 
--
-- Type your query below:

SELECT a2_Showing.Showing_No as "Showing", A2_Film.Film_Name as "Film Title", a2_Showing.Cinema as "Cinema", a2_showing.Screen as "Screen", TO_CHAR (min(a2_Performance.Performance_Date) , 'Dy Month D') as "First Night", TO_CHAR (max(a2_Performance.Performance_Date) , 'Dy Month D') as "Last Night" 
FROM a2_Performance JOIN A2_Showing
ON A2_Showing.Showing_No = A2_Performance.showing_no
JOIN A2_Film ON A2_Film.Film_No = A2_Showing.Film_No group by a2_Showing.Showing_No, A2_Film.Film_Name, a2_Showing.Cinema, a2_showing.Screen;    



-- END OF ASSIGNMENT TASK TWO ---------------------------------------------------

-- SUBMISSION REQUIREMENTS
-- =======================
--
-- Once your queries are tested and the final code placed in the file above in
-- the appropriate places, the following should be done in order to meet the
-- submission requirements.
--
-- MARKS WILL BE DEDUCTED FOR FAILURE TO FOLLOW THESE INSTRUCTIONS.
--
--  1  Rename this file in the following format:
--
--			aa99aaa-Ass2.sql
--
--     where the aa99aaa is replaced by YOUR Oracle username
--
--  2  Open this file in an SQL Worksheet in SQL Developer, clear the Script
--     Output window using the eraser icon, and ensure your 6 table schema is
--     correct and includes your entered data.
--
--  3  Use the "Run Script (F5)" icon (sheet of paper with small green triangle)
--     to run your script completely. Ensure all commands are run.
--
--  4  Save the Script Output text by clicking on the floppy disk icon, use the
--     popup window to save the file as aa99aaa-Ass2.txt, again relacing aa99aaa
--     with your username.
--
--  5  Double check both the aa99aaa-Ass2.sql and aa99aaa-Ass2.txt files, then
--     upload them onto CANVAS in the Assignment 2 point.
--
--  6  Congratualations, you are done!
--
-- END OF FILE ==================================================================



