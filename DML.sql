USE CourseDB
GO

EXEC spInserttechsubjects 101, 'Computer'
GO

EXEC spInserttechsubjects 102, 'EEE'
GO

EXEC spInserttechsubjects 103, 'Arcitecture'
GO

EXEC spInserttechsubjects 104, 'Arcitecture'
GO

EXEC spInserttechsubjects 105, 'Construction'
GO


SELECT * FROM techsubjects
GO

EXEC spInsertinstructors 201, 'Atick', 'shuvo@gmail.com', '01816547896'
GO

EXEC spInsertinstructors 202, 'Alom', 'alom@gmail.com', '01756487965'
GO

EXEC spInsertinstructors 203, 'Ahmed', 'ahmed@gmail.com', '01956897856'
GO

EXEC spInsertinstructors 204, 'Hasan', 'hasan@gmail.com', '01556987456'
GO

EXEC spInsertinstructors 205, 'Moinul', 'moinul@gmail.com', '01865487954'
GO

SELECT * FROM instructors
GO

EXEC spInsertcourses 301, 'SQL', 77, 5, 10, 22000.00, 201
GO

EXEC spInsertcourses 302, 'PHP', 60, 6, 100, 26000.00, 202
GO

EXEC spInsertcourses 303, 'C#', 50, 7, 200, 21000.00, 203
GO

EXEC spInsertcourses 304, 'Q#', 40, 6, 70, 19000.00, 204
GO

EXEC spInsertcourses 305, 'F#', 30, 4, 30, 15000.00, 204
GO

SELECT * FROM courses
GO

EXEC spInsertinstructorsubjects 201, 101
GO
EXEC spInsertinstructorsubjects 202, 102
GO
EXEC spInsertinstructorsubjects 203, 103
GO
EXEC spInsertinstructorsubjects 204, 104
GO


SELECT * FROM instructorsubjects
GO
EXEC spInsertbatches 405, '2022-01-15', 301
GO
EXEC spInsertbatches 406, '2022-02-22', 302
GO
EXEC spInsertbatches 407, '2022-03-18', 303
GO


SELECT * FROM [batches]

EXEC spInsertstudents 501, 'Hasan', '017XXXXXXX', 405
GO
EXEC spInsertstudents 502, 'Rakibul', '017XXXXXXX', 406
GO
EXEC spInsertstudents 503, 'Ahmed', '017XXXXXXX', 407
GO

GO

SELECT * FROM students
GO
--Query
SELECT c.courseid,i.istructorname,tj.technology, b.startdate, s.studentname
FROM courses c
INNER JOIN instructors i ON c.courseid=i.instructorid
INNER JOIN instructorsubjects isj ON i.instructorid=isj.instructorid
INNER JOIN techsubjects tj ON isj.subjectid=tj.subjectid
INNER JOIN [batches] b ON c.courseid=b.courseid
INNER JOIN students s ON b.batchid=s.batchid
GO
SELECT        batches.batchid, COUNT(students.studentid) 
FROM            batches INNER JOIN
                         students ON batches.batchid = students.batchid
GROUP BY   batches.batchid
GO
SELECT        courses.title, COUNT(batches.batchid) 
FROM            courses INNER JOIN
                         batches ON courses.courseid = batches.courseid
GROUP BY courses.title
GO
----update----
EXEC spUdatetechsubjects 101, 'Hasan', '017XXXXXXX', 409
GO


EXEC spUdateinstructors 203, 'Jmal Vuiya', '@ahmed', '0171XXXXXXXX'
GO

EXEC spUdatecourses 305, 'F#', 60, 5, 30, 26000.00, 205
GO

EXEC spUdateinstructorsubjects 203, 103
GO

EXEC spUdatebatches 408, '2020-04-02', 304
GO

EXEC spUdatestudents 504, 'Anamul haq sohel', '017XXXXXXX', 408
GO

----Delete Proc---
EXEC spDeletetechsubjects 101
GO

EXEC spDeleteinstructors 203
GO

EXEC spDeletecourses 302
GO


EXEC spDeleteinstructorsubjects 408
GO

EXEC spDeletebatches 501
GO

EXEC spDeletestudents 603
GO
--
SELECT * FROM vcourses
GO
SELECT dbo.Functioncourses ('Ektekher alom')
GO
SELECT * FROM fncourses()
go
/*
 * Queries added
 * *********************************************
 * */
-----------------------------------
--- 1 Join Inner
-----------------------------------
SELECT  c.title, c.totalclass, c.weeklyclass, c.fee, b.startdate, b.courseid, i.istructorname, st.studentname, st.phone, ts.technology
FROM  batches b 
INNER JOIN  courses c ON b.courseid = c.courseid 
INNER JOIN instructors i ON c.instructorid = i.instructorid 
INNER JOIN instructorsubjects isb ON i.instructorid = isb.instructorid 
INNER JOIN students st ON b.batchid = st.batchid 
INNER JOIN techsubjects ts ON isb.subjectid = ts.subjectid
GO
-----------------------------------
--- 2 Course filter
-----------------------------------
SELECT  c.title, c.totalclass, c.weeklyclass, c.fee, b.startdate, b.courseid, i.istructorname, st.studentname, st.phone, ts.technology
FROM  batches b 
INNER JOIN  courses c ON b.courseid = c.courseid 
INNER JOIN instructors i ON c.instructorid = i.instructorid 
INNER JOIN instructorsubjects isb ON i.instructorid = isb.instructorid 
INNER JOIN students st ON b.batchid = st.batchid 
INNER JOIN techsubjects ts ON isb.subjectid = ts.subjectid
WHERE c.title = 'SQL'
GO
-----------------------------------
--- 3 Course technology filter
-----------------------------------
SELECT  c.title, c.totalclass, c.weeklyclass, c.fee, b.startdate, b.courseid, i.istructorname, st.studentname, st.phone, ts.technology
FROM  batches b 
INNER JOIN  courses c ON b.courseid = c.courseid 
INNER JOIN instructors i ON c.instructorid = i.instructorid 
INNER JOIN instructorsubjects isb ON i.instructorid = isb.instructorid 
INNER JOIN students st ON b.batchid = st.batchid 
INNER JOIN techsubjects ts ON isb.subjectid = ts.subjectid
WHERE ts.technology ='Computer'
GO
-----------------------------------
--- 4 Outer join (right)
-----------------------------------
SELECT  c.title, c.totalclass, c.weeklyclass, c.fee, b.batchid, b.startdate, b.courseid, s.studentname, s.phone
FROM students s 
INNER JOIN  batches b ON s.batchid = b.batchid 
RIGHT OUTER JOIN  courses c ON b.courseid = c.courseid
GO
-----------------------------------
--- 5 Change 4 to cte
-----------------------------------
WITH batchstudent AS
(
SELECT  b.courseid, b.batchid, b.startdate, s.studentname, s.phone
FROM students s 
INNER JOIN  batches b ON s.batchid = b.batchid 
)
SELECT c.title, c.totalclass, c.weeklyclass, c.fee, bs.batchid, bs.startdate, bs.studentname, bs.phone
FROM batchstudent bs
RIGHT OUTER JOIN  courses c ON bs.courseid = c.courseid
GO
-----------------------------------
--- 6 Outer join only not batched
-----------------------------------
SELECT  c.title, c.totalclass, c.weeklyclass, c.fee, b.batchid, b.startdate, b.courseid, s.studentname, s.phone
FROM students s 
INNER JOIN  batches b ON s.batchid = b.batchid 
RIGHT OUTER JOIN  courses c ON b.courseid = c.courseid
WHERE b.batchid IS NULL
GO
-----------------------------------
--- 7 change 6 to subquery
-----------------------------------
SELECT  c.title, c.totalclass, c.weeklyclass, c.fee, b.batchid, b.startdate, b.courseid, s.studentname, s.phone
FROM students s 
INNER JOIN  batches b ON s.batchid = b.batchid 
RIGHT OUTER JOIN  courses c ON b.courseid = c.courseid
WHERE c.courseid NOT IN (select courseid FROM batches)
GO
-----------------------------------
--- 8 aggregate
-----------------------------------
SELECT  c.title, COUNT(b.batchid) 'totalbatches'
FROM  batches b 
INNER JOIN  courses c ON b.courseid = c.courseid 
INNER JOIN instructors i ON c.instructorid = i.instructorid 
INNER JOIN instructorsubjects isb ON i.instructorid = isb.instructorid 
INNER JOIN students st ON b.batchid = st.batchid 
INNER JOIN techsubjects ts ON isb.subjectid = ts.subjectid
GROUP by c.title
GO
SELECT  i.istructorname, COUNT(b.batchid) 'totalbatches'
FROM  batches b 
INNER JOIN  courses c ON b.courseid = c.courseid 
INNER JOIN instructors i ON c.instructorid = i.instructorid 
INNER JOIN instructorsubjects isb ON i.instructorid = isb.instructorid 
INNER JOIN students st ON b.batchid = st.batchid 
INNER JOIN techsubjects ts ON isb.subjectid = ts.subjectid
GROUP by i.istructorname
GO
-----------------------------------
--- 9 aggregate with having
-----------------------------------
SELECT  c.title, COUNT(b.batchid) 'totalbatches'
FROM  batches b 
INNER JOIN  courses c ON b.courseid = c.courseid 
INNER JOIN instructors i ON c.instructorid = i.instructorid 
INNER JOIN instructorsubjects isb ON i.instructorid = isb.instructorid 
INNER JOIN students st ON b.batchid = st.batchid 
INNER JOIN techsubjects ts ON isb.subjectid = ts.subjectid
GROUP by c.title
HAVING c.title = 'SQL'
GO
-----------------------------------
--- 10 windowing functions
-----------------------------------
SELECT  c.title, 
COUNT(b.batchid) OVER (ORDER BY c.courseid) 'totalbatches',
ROW_NUMBER() OVER (ORDER BY c.courseid) 'row',
RANK() OVER (ORDER BY c.courseid) 'rank',
DENSE_RANK() OVER (ORDER BY c.courseid) 'rank dense',
NTILE(2) OVER (ORDER BY c.courseid) 'ntile'
FROM  batches b 
INNER JOIN  courses c ON b.courseid = c.courseid 
INNER JOIN instructors i ON c.instructorid = i.instructorid 
INNER JOIN instructorsubjects isb ON i.instructorid = isb.instructorid 
INNER JOIN students st ON b.batchid = st.batchid 
INNER JOIN techsubjects ts ON isb.subjectid = ts.subjectid
GO
-----------------------------------
--- 11 CASE
-----------------------------------
SELECT title, fee,
CASE 
	WHEN title = 'SQL' OR title='C#' OR title= 'F#' THEN 'Microsoft'
	ELSE 'OTHERS'
END AS 'Vendor'
FROM courses
GO