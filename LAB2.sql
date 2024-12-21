-- Create Department Table

CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);



-- Create Designation Table

CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);


-- Create Person Table

CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);


---------------------------PART-A--------------------------------

--1. Department, Designation & Person Table�s INSERT, UPDATE & DELETE Procedures.

----iNSERT IN TABLE DEPARTMENT

CREATE OR ALTER PROCEDURE PR_DEPARTMENT_INSERT
@DEPTID INT,
@DEPTNAME VARCHAR(50)
AS
BEGIN
	INSERT INTO DEPARTMENT VALUES(@DEPTID , @DEPTNAME)
END


EXEC PR_DEPARTMENT_INSERT 1 , 'ADMIN'
EXEC PR_DEPARTMENT_INSERT 2 , 'IT'
EXEC PR_DEPARTMENT_INSERT 3 , 'HR'
EXEC PR_DEPARTMENT_INSERT 4 , 'ACCOUNT'



----INSERT INTO DESIGNATION

CREATE OR ALTER PROCEDURE PR_DESIGNATION_INSERT
@DESID INT,
@DESNAME VARCHAR(50)
AS
BEGIN
	INSERT INTO DESIGNATION VALUES(@DESID , @DESNAME)
END


EXEC PR_DESIGNATION_INSERT 11 , 'JOBBER'
EXEC PR_DESIGNATION_INSERT 12 , 'WELDER'
EXEC PR_DESIGNATION_INSERT 13 , 'CLERK'
EXEC PR_DESIGNATION_INSERT 14 , 'MANAGER'
EXEC PR_DESIGNATION_INSERT 15 , 'CEO'



----INSERT INTO PERSON TABLE

CREATE OR ALTER PROCEDURE PR_PERSON_INSERT
@FNAME VARCHAR(50),
@LNAME VARCHAR(50),
@SALARY INT,
@DATE DATETIME,
@DEPTID INT,
@DESID INT
AS 
BEGIN
	INSERT INTO PERSON VALUES(@FNAME , @LNAME , @SALARY , @DATE , @DEPTID , @DESID)
END


Exec pr_Person_insert 'Rahul','Anshu',56000,'19900101',1,12
Exec pr_Person_insert 'Hardik','Hinsu',18000,'19900925',2,11
Exec pr_Person_insert 'Bhavin','Kamani',25000,'19910514',null,11
Exec pr_Person_insert 'Bhoomi','Patel',39000,'20140220',1,13
Exec pr_Person_insert 'Rohit','Rajgor',17000,'19900723',2,15
Exec pr_Person_insert 'Priya','Mehta',25000,'19901018',2,null
Exec pr_Person_insert 'Neha','Trivedi',18000,'20140220',3,15



----UPDATE FOR DEPARTMENT

CREATE OR ALTER PROCEDURE PR_DEPARTMENT_UPDATE
@DEPTID INT,
@DEPTNAME VARCHAR(50)
AS
BEGIN 
	UPDATE DEPARTMENT
	SET DEPARTMENTNAME = @DEPTNAME
	WHERE DEPARTMENTID = @DEPTID
END



----UPDATE FOR DESIGNATION

CREATE OR ALTER PROCEDURE PR_DESIGNATION_UPDATE
@DESID INT,
@DESNAME VARCHAR(50)
AS 
BEGIN 
	UPDATE DESIGNATION
	SET DESIGNATIONNAME = @DESNAME
	WHERE DESIGNATIONID = @DESID
END



----UPDATE FOR PERSON

CREATE OR ALTER PROCEDURE PR_PERSON_UPDATE	
@pid int,
@Fname Varchar(50),
@Lname Varchar(50),
@Salary int,
@date datetime,
@deptid int,
@desid int
AS 
BEGIN
	UPDATE PERSON
	set 
		FirstName = @Fname,
		LastName = @Lname,
		Salary = @Salary,
		JoiningDate = @date,
		DepartmentID = @deptid,
		DesignationID = @desid
	WHERE PersonID = @pid;
END




----DELETE FROM DEPARTMENT

CREATE OR ALTER PROCEDURE PR_DEPARTMENT_DELETE
@DEPTID INT
AS
BEGIN
	DELETE FROM DEPARTMENT 
	WHERE DepartmentID = @DEPTID
END



----DELETE FROM DESIGNATION

CREATE OR ALTER PROCEDURE PR_DESIGNATION_DELETE
@DESID INT
AS 
BEGIN
	DELETE FROM DESIGNATION
	WHERE DesignationID = @DESID
END



----DELETE FROM PERSON

CREATE OR ALTER PROCEDURE PR_PERSON_DELETE
@PID INT
AS
BEGIN
	DELETE FROM PERSON
	WHERE PersonID = @PID
END


--2. Department, Designation & Person Table�s SELECTBYPRIMARYKEY


----SELECT FROM DEPARTMENT
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_SELECT
@DEPTID INT
AS 
BEGIN
	SELECT * FROM DEPARTMENT
	WHERE DEPARTMENTID = @DEPTID
END



----SELECT FROM DESIGNATION
CREATE OR ALTER PROCEDURE PR_DESIGNATION_SELECT
@DESID INT
AS
BEGIN
	SELECT * FROM DESIGNATION
	WHERE DESIGNATIONID = @DESID
END



----SELECT FROM PERSON
CREATE OR ALTER PROCEDURE PR_PERSON_SELECT
@PID INT
AS
BEGIN
	SELECT * FROM PERSON
	WHERE PERSONID = @PID
END	



--3. Department, Designation & Person Table�s (If foreign key is available then do write join and take columns on select list)

---- SELECT LIST OF DEPARTMENT
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_LIST
AS
BEGIN
	SELECT * FROM DEPARTMENT
END



----SELECT LIST OF DESIGNATION
CREATE OR ALTER PROCEDURE PR_DESIGNATION_LIST
AS
BEGIN
	SELECT * FROM DESIGNATION
END



----SELECT LIST OF PERSON
CREATE OR ALTER PROCEDURE PR_PERSON_LIST
AS
BEGIN
	SELECT * FROM PERSON
	JOIN DEPARTMENT
	ON PERSON.DEPARTMENTID = DEPARTMENT.DEPARTMENTID
	JOIN DESIGNATION 
	ON PERSON.DESIGNATIONID = DESIGNATION.DESIGNATIONID
END

EXEC PR_PERSON_LIST



--4. Create a Procedure that shows details of the first 3 persons.

CREATE OR ALTER PROCEDURE PR_PERSON_DETAILS
AS
BEGIN
	SELECT TOP 3 * FROM PERSON
	JOIN DEPARTMENT
	ON PERSON.DEPARTMENTID = DEPARTMENT.DEPARTMENTID
	JOIN DESIGNATION
	ON PERSON.DESIGNATIONID = DESIGNATION.DESIGNATIONID
END

EXEC PR_PERSON_DETAILS




------------------------PART-B---------------------------

--5. Create a Procedure that takes the department name as input and returns a table with all workers working in that department.
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_WORKERS
@DEPTNAME VARCHAR(50)
AS
BEGIN
	SELECT FIRSTNAME , LASTNAME FROM PERSON
	JOIN DEPARTMENT
	ON PERSON.DEPARTMENTID = DEPARTMENT.DEPARTMENTID
	WHERE DEPARTMENTNAME = @DEPTNAME
END

EXEC PR_DEPARTMENT_WORKERS 'IT'


--6. Create Procedure that takes department name & designation name as input and returns a table with worker�s first name, salary, joining date & department name.

CREATE OR ALTER PROCEDURE PR_PERSON_ALLDETAILS
@DEPTNAME VARCHAR(50),
@DESNAME VARCHAR(50)
AS 
BEGIN 
	SELECT PERSON.FIRSTNAME , PERSON.SALARY , PERSON.JOININGDATE , DEPARTMENT.DEPARTMENTNAME
	FROM PERSON JOIN DEPARTMENT 
	ON PERSON.DEPARTMENTID = DEPARTMENT.DEPARTMENTID
	JOIN DESIGNATION 
	ON PERSON.DESIGNATIONID = DESIGNATION.DESIGNATIONID
	WHERE DEPARTMENT.DEPARTMENTNAME = @DEPTNAME AND DESIGNATION.DESIGNATIONNAME = @DESNAME
END

EXEC PR_PERSON_ALLDETAILS 'IT' , 'JOBBER'

--7. Create a Procedure that takes the first name as an input parameter and display all the details of the worker with their department & designation name.

CREATE OR ALTER PROCEDURE PR_PERSON_WITHDEPARTMENTANDDESIGNATION
@FIRSTNAME VARCHAR(50)
AS 
BEGIN
	SELECT PERSON.PERSONID , PERSON.FIRSTNAME , PERSON.LASTNAME , PERSON.SALARY , PERSON.JOININGDATE , DEPARTMENT.DEPARTMENTNAME , DESIGNATION.DESIGNATIONNAME 
	FROM PERSON JOIN DEPARTMENT 
	ON PERSON.DEPARTMENTID = DEPARTMENT.DEPARTMENTID
	JOIN DESIGNATION 
	ON PERSON.DESIGNATIONID = DESIGNATION.DESIGNATIONID
	WHERE PERSON.FIRSTNAME = @FIRSTNAME
END

EXEC PR_PERSON_WITHDEPARTMENTANDDESIGNATION 'RAHUL'

--8. Create Procedure which displays department wise maximum, minimum & total salaries.

CREATE OR ALTER PROCEDURE PR_DEPARTMENT_MAXMINSALARY
AS
BEGIN
	SELECT DEPARTMENT.DEPARTMENTNAME , MAX(PERSON.SALARY) AS MAXSALARY , MIN(PERSON.SALARY) AS MINSALARY , SUM(PERSON.SALARY) AS TOTALSALARY
	FROM PERSON JOIN DEPARTMENT
	ON PERSON.DEPARTMENTID = DEPARTMENT.DEPARTMENTID
	GROUP BY DEPARTMENT.DEPARTMENTNAME
END

EXEC PR_DEPARTMENT_MAXMINSALARY

--9. Create Procedure which displays designation wise average & total salaries.

CREATE OR ALTER PROCEDURE PR_DESIGNATION_MAXMINSALARY
AS
BEGIN
	SELECT DESIGNATION.DESIGNATIONNAME , MAX(PERSON.SALARY) AS MAXSALARY , MIN(PERSON.SALARY) AS MINSALARY , SUM(PERSON.SALARY) AS TOTALSALARY
	FROM PERSON JOIN DESIGNATION
	ON PERSON.DESIGNATIONID = DESIGNATION.DESIGNATIONID
	GROUP BY DESIGNATION.DESIGNATIONNAME
END

EXEC PR_DESIGNATION_MAXMINSALARY



---------------------------PART-C-------------------------------
--10. Create Procedure that Accepts Department Name and Returns Person Count.

CREATE OR ALTER PROCEDURE PR_PERSON_COUNT
@DEPTNAME VARCHAR(50)
AS
BEGIN
	SELECT DEPARTMENT.DEPARTMENTNAME , COUNT(PERSON.PERSONID) AS PERSONCOUNT
	FROM DEPARTMENT LEFT JOIN PERSON
	ON DEPARTMENT.DEPARTMENTID = PERSON.DEPARTMENTID
	WHERE DEPARTMENT.DEPARTMENTNAME = @DEPTNAME
	GROUP BY DEPARTMENT.DEPARTMENTNAME
END

EXEC PR_PERSON_COUNT 'IT'

--11. Create a procedure that takes a salary value as input and returns all workers with a salary greater than input salary value along with their department and designation details.

CREATE OR ALTER PROCEDURE PR_WORKERS_WITHDETAILS
@SALARY INT
AS
BEGIN
	SELECT PERSON.PERSONID , PERSON.FIRSTNAME , PERSON.LASTNAME , PERSON.SALARY , PERSON.JOININGDATE , DEPARTMENT.DEPARTMENTNAME , DESIGNATION.DESIGNATIONNAME
	FROM PERSON LEFT JOIN DEPARTMENT
	ON PERSON.DEPARTMENTID = DEPARTMENT.DEPARTMENTID
	LEFT JOIN DESIGNATION
	ON PERSON.DESIGNATIONID = DESIGNATION.DESIGNATIONID
	WHERE PERSON.SALARY > @SALARY
END

EXEC PR_WORKERS_WITHDETAILS 25000

--12. Create a procedure to find the department(s) with the highest total salary among all departments.


--13. Create a procedure that takes a designation name as input and returns a list of all workers under that
--designation who joined within the last 10 years, along with their department.
--14. Create a procedure to list the number of workers in each department who do not have a designation
--assigned.
--15. Create a procedure to retrieve the details of workers in departments where the average salary is above
--12000.