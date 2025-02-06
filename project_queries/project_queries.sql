--try to find duplicates

SELECT
	StudentID,
	Age,
	Gender,
	Ethnicity,
	COUNT(*) AS DuplicateCount
FROM students_performance
GROUP BY
	StudentID,
	Age,
	Gender,
	Ethnicity
HAVING COUNT(*) > 1;

--result: no duplicates

-----------------------------------------------------------------------------------------------
--try to find missing values

SELECT StudentID, Age, Gender, Ethnicity, ParentalEducation, StudyTimeWeekly, 
       Absences, Tutoring, ParentalSupport, Extracurricular, Sports, Music, 
       Volunteering, GPA, GradeClass
FROM students_performance
WHERE 
    StudentID IS NULL OR 
    Age IS NULL OR 
    Gender IS NULL OR 
    Ethnicity IS NULL OR 
    ParentalEducation IS NULL OR 
    StudyTimeWeekly IS NULL OR 
    Absences IS NULL OR 
    Tutoring IS NULL OR 
    ParentalSupport IS NULL OR 
    Extracurricular IS NULL OR 
    Sports IS NULL OR 
    Music IS NULL OR 
    Volunteering IS NULL OR 
    GPA IS NULL OR 
    GradeClass IS NULL;

--result: no missing values

-----------------------------------------------------------------------------------------------

--Gender
-- Change 0 and 1 to Male and Female 

UPDATE students_performance
SET Gender = 'Male'
WHERE Gender = '0'	

UPDATE students_performance
SET Gender = 'Female'
WHERE Gender = '1'	
			
	

------------------------------------------------------------------------------------------------------

--Ethnicity


UPDATE students_performance
SET Ethnicity = 
	CASE 
		WHEN Ethnicity = 0 THEN 'caucasian'
		WHEN Ethnicity = 1 THEN 'african_american'
		WHEN Ethnicity = 2 THEN 'asian'
		WHEN Ethnicity = 3 THEN 'other'
		END



------------------------------------------------------------------------------------------------------------
--ParentalEducation

UPDATE students_performance
SET ParentalEducation = 
	CASE 
		WHEN ParentalEducation = 0 THEN 'none'
		WHEN ParentalEducation = 1 THEN 'high_school'
		WHEN ParentalEducation = 2 THEN 'some_college'
		WHEN ParentalEducation = 3 THEN 'bachelor s'
		WHEN ParentalEducation = 4 THEN 'higher'
		END



------------------------------------------------------------------------------------------------------------------

--StudyTimeWeekly

SELECT StudyTimeWeekly
FROM students_performance
WHERE TRY_CAST(StudyTimeWeekly AS DECIMAL(18, 15)) IS NULL
  AND StudyTimeWeekly IS NOT NULL


/*This query helps me identify rows in the students_performance table where the StudyTimeWeekly column contains invalid data that cannot be properly interpreted as a decimal.*/

ALTER TABLE students_performance
ALTER COLUMN StudyTimeWeekly DECIMAL(3, 1);

/*The purpose of this query is to limit the numeric values on the StudyTimeWeekly column  to a numeric format with one decimal place.
By using DECIMAL(3, 1), the column will allow values like 0.0 to 99.9, but nothing larger.*/

UPDATE students_performance
SET StudyTimeWeekly = ROUND(StudyTimeWeekly, 1);

/*This query ensures that all values in the StudyTimeWeekly column are properly rounded and they fit within the column's new format
(with the 1 decimal place required by the DECIMAL(3, 1) data type).*/

------------------------------------------------------------------------------------------------------------------
--Tutoring
-- Change 0 and 1 to False and True 

UPDATE students_performance
SET Tutoring = 'False'
WHERE Tutoring = '0'	

UPDATE students_performance
SET Tutoring = 'True'
WHERE Tutoring = '1'	



------------------------------------------------------------------------------------------------------------------
--ParentalSupport

UPDATE students_performance
SET ParentalSupport = 
	CASE 
		WHEN ParentalSupport = 0 THEN 'none'
		WHEN ParentalSupport = 1 THEN 'low'
		WHEN ParentalSupport = 2 THEN 'moderate'
		WHEN ParentalSupport = 3 THEN 'high'
		WHEN ParentalSupport = 4 THEN 'Very High'
		END



------------------------------------------------------------------------------------------------------------------

--Extracurricular
-- Change 0 and 1 to False and True 

UPDATE students_performance
SET Extracurricular = 'False'
WHERE Extracurricular = '0'	

UPDATE students_performance
SET Extracurricular = 'True'
WHERE Extracurricular = '1'	



------------------------------------------------------------------------------------------------------------------

--Sports
-- Change 0 and 1 to False and True 

UPDATE students_performance
SET Sports = 'False'
WHERE Sports = '0'	

UPDATE students_performance
SET Sports = 'True'
WHERE Sports = '1'	


------------------------------------------------------------------------------------------------------------------

--Music
-- Change 0 and 1 to False and True 

UPDATE students_performance
SET Music = 'False'
WHERE Music = '0'	

UPDATE students_performance
SET Music = 'True'
WHERE Music = '1'	



--------------------------------------------------------------------------------------------------------------------------

--Volunteering
-- Change 0 and 1 to False and True 


UPDATE students_performance
SET Volunteering = 'False'
WHERE Volunteering = '0'	

UPDATE students_performance
SET Volunteering = 'True'
WHERE Volunteering = '1'	




---------------------------------------------------------------------------------------------------------------------

--GPA

SELECT GPA
FROM students_performance
WHERE TRY_CAST(GPA AS DECIMAL(18, 15)) IS NULL
  AND GPA IS NOT NULL

/*This query helps me identify rows in the students_performance table where GPA contains non-numeric or invalid data that cannot be cast into a valid decimal format.*/


ALTER TABLE students_performance
ALTER COLUMN GPA DECIMAL(2, 1);

/*The purpose of this query is to limit the numeric values on the GPA column  to a numeric format with one decimal place.
This ensures that GPA values are valid numbers and are represented uniformly with only one decimal place.*/

UPDATE students_performance
SET GPA = ROUND(GPA, 1);

/*This query ensures that all GPA values are rounded to one decimal place, which aligns with the new data type definition (DECIMAL(2, 1)).
This step ensures that all GPA values conform to the required format after the ALTER COLUMN operation.*/


----------------------------------------------------------------------------------------------------------------------------
--GradeClass

UPDATE students_performance
SET GradeClass = 
	CASE 
		WHEN GradeClass = '0.0' THEN 'A'
		WHEN GradeClass = '1.0' THEN 'B'
		WHEN GradeClass = '2.0' THEN 'C'
		WHEN GradeClass = '3.0' THEN 'D'
		WHEN GradeClass = '4.0' THEN 'F'
		END


		select*
		from students_performance
