--Note: for Table valued function use tables of Lab-2
--Part – A
--1. Write a function to print "hello world".
	Create Or Alter Function Fn_HelloWorld()
	Returns varchar(30)
	As
	Begin
		return ('Hello World')
	End
	Select dbo.Fn_HelloWorld()

--2. Write a function which returns addition of two numbers.
	Create Or Alter Function Fn_Addition(@Num1 int,@Num2 int)
	Returns Int
	As
	Begin
		Declare @Ans int
		Set @Ans=@Num1+@Num2
		Return @Ans
	End
	Select dbo.Fn_Addition(54,46)

--3. Write a function to check whether the given number is ODD or EVEN.
	Create Or Alter Function Fn_Odd_Even(@Num int)
	Returns varchar(30)
	As
	Begin
		Declare @Ans varchar(30)
		If @Num%2=0
			Set @Ans= 'Number is Even'
		Else
			Set @Ans= 'Number is Odd'
		Return @Ans
	End
	Select dbo.Fn_Odd_Even(4)
	
--4. Write a function which returns a table with details of a person whose first name starts with B.
	Create Or Alter Function Fn_Person()
	Returns Table
	As
		Return (Select * From Person Where FirstName Like 'B%')

	Select * From dbo.Fn_Person()

--5. Write a function which returns a table with unique first names from the person table.
	Create Or Alter Function Fn_Person_Unique()
	Returns Table
	As
		Return (Select Distinct FirstName From Person)

	Select * From dbo.Fn_Person_Unique()
--6. Write a function to print number from 1 to N. (Using while loop)
	Create Or Alter Function Fn_Print1ToN(@Num int)
	Returns Varchar(100)
	As
	Begin
		Declare @Ans Varchar(100) = '',@i int = 1
		While @i<=@Num
		Begin
			Set @Ans = @Ans +' ' +Cast(@i As varchar(1))+' '
			Set @i =@i+1
		End
		Return @Ans
	End
	Select dbo.Fn_Print1ToN(5)

--7. Write a function to find the factorial of a given integer.
	CREATE OR ALTER Function Fn_Factorial(@NUM Int)
	Returns Int
	AS
	BEGIN
		DECLARE @ANS INT=1,@i INT=1
		WHILE @i<=@NUM
		BEGIN
			SET @ANS = @ANS*@i
			SET @i=@i+1
		END
		RETURN @ANS
	END
	SELECT dbo.Fn_Factorial(5)

--Part – B
--8. Write a function to compare two integers and return the comparison result. (Using Case statement)
	CREATE OR ALTER FUNCTION FN_COMPARE_TWO(@a INT,@b INT)
	RETURNS VARCHAR(50)
	AS
	BEGIN
		RETURN (
			CASE
				WHEN @a>@b THEN 'First is greater than second'
				WHEN @a<@b THEN 'First is less than second'
				ELSE 'Both are equal'
			END
		)
	END
	SELECT dbo.FN_COMPARE_TWO(5,2)



--9. Write a function to print the sum of even numbers between 1 to 20.
	Create Or Alter Function Fn_Sum1To20()
	Returns Int
	As
	Begin
		Declare @i int = 2,@Ans int=0
		While @i<20
		Begin
			Set @Ans+=@i
			Set @i+=2
		End
		Return @Ans
	End
	Select dbo.Fn_Sum1To20()

--10. Write a function that checks if a given string is a palindrome
	Create Or Alter Function Fn_Palindrome(@Str varchar(30))
	Returns Varchar(30)
	As
	Begin
		Declare @Msg varchar(30)=''
		If @Str=REVERSE(@Str)
			Set @Msg='Palindrome'
		Else
			Set @Msg='Not Palindrome'
		Return @Msg
	End
Select dbo.Fn_Palindrome('abccba')

--Part – C
--11. Write a function to check whether a given number is prime or not.
	CREATE OR ALTER FUNCTION FN_PRIME(@num INT)
	RETURNS VARCHAR(50)
	AS
	BEGIN
		DECLARE @i int=2,@fact int=0,@msg varchar(50)=''
		while @i<=@num/2
		begin
			IF @num%@i=0
				SET @fact=1
				SET @i=@i+1
		end
		IF @fact=0
			set @msg = 'Is Prime'
		ELSE
			set @msg='Not Prime'
		RETURN @msg
	END
	select dbo.FN_PRIME(13)


--12. Write a function which accepts two parameters start date & end date, and returns a difference in days.
	CREATE OR ALTER FUNCTION FN_DATEDIFF(@START DATE,@END DATE)
	RETURNS INT
	AS
	BEGIN
		RETURN DATEDIFF(DAY,@START,@END)
	END
	SELECT dbo.FN_DATEDIFF('2024-11-01','2024-12-24')


--13. Write a function which accepts two parameters year & month in integer and returns total days each year.
	CREATE OR ALTER FUNCTION FN_TOTAL_DAYS(@year INT,@month INT)
		RETURNS INT
		AS
		BEGIN
			DECLARE @ANS INT
			IF @year%4=0 and @month=2
				SET @ANS=29
			ELSE IF @month=2
				SET @ANS=28
			ELSE IF @month%2=0
				SET @ANS=30
			ELSE
				SET @ANS=31
			RETURN @ANS
		END
		SELECT dbo.FN_TOTAL_DAYS(2023,2)

--14. Write a function which accepts departmentID as a parameter & returns a detail of the persons.
	Create Or Alter Function Fn_Person_Details(@Did int)
	Returns Table
	As
		Return(Select * From Person Where DepartmentID=@Did)

		Select * From dbo.Fn_Person_Details(1)

--15. Write a function that returns a table with details of all persons who joined after 1-1-1991.
	Create Or Alter Function Fn_AfterDate()
	Returns Table	
	As
		Return(Select * From Person Where JoiningDate>'1991-01-01')

		Select * From dbo.Fn_AfterDate()