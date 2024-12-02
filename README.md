# Introduction


Data cleaning is a crucial and very importand step in any data analysis project. It involves identifying and correcting errors, inconsistencies, and inaccuracies within a dataset to ensure that the data is complete, accurate, and usable. In this project, i focused on cleaning a dataset using  applying various , but simple, techniques.

Using SQL, through a combination of querying, i transform data types, rounding values, and applying best practices for data integrity. The result is a clean, reliable dataset that is ready for further analysis and reporting, ensuring accurate insights can be derived in subsequent stages of the project.

Feel free to check out the queries for this project here : [project_queries](https://github.com/theodorosmalezidis/students_perfomance/blob/main/project_queries.sql)

# Dataset

The dataset contains comprehensive information on 2,392 high school students, detailing their demographics, study habits, parental involvement, extracurricular activities, and academic performance from [kaggle](https://www.kaggle.com/datasets/rabieelkharoua/students-performance-dataset).



# My Tools for the Project

- **SQL Server (SQLS) :** A robust database management system that delivers high-performance data storage and advanced functionality for efficient querying and analytics.
- **SQL :** The language that brings your data to life with precision and power.
- **Git :** The version control wizard that keeps your code history tidy and collaborative.
- **GitHub :** Essential for sharing my SQL scripts and analysis, ensuring collaboration and project tracking.



# Data Cleaning Process

## 1. Duplicates, Missing Values

Basic start, try to find duplicates and indentify if there are any missing values through our dataset with the following queries

```sql
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
```

result : no duplicates

```sql
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
```

result : no missing values

## 2. Transforming 0 and 1 into String and Boolean Values

Using the following queries, I transformed the data types by converting 0 and 1 into Male/Female for gender representation and True/False for boolean fields in specific columns, enhancing the dataset's clarity and usability for analysis.

**Gender**

```sql
UPDATE students_performance
SET Gender = 'Male'
WHERE Gender = '0'	

UPDATE students_performance
SET Gender = 'Female'
WHERE Gender = '1'	
```

**Tutoring**
```sql
UPDATE students_performance
SET Tutoring = 'False'
WHERE Tutoring = '0'	

UPDATE students_performance
SET Tutoring = 'True'
WHERE Tutoring = '1'	
```

**Extracurricular**
```sql
UPDATE students_performance
SET Extracurricular = 'False'
WHERE Extracurricular = '0'	

UPDATE students_performance
SET Extracurricular = 'True'
WHERE Extracurricular = '1'	
```

**Sports**
```sql
UPDATE students_performance
SET Sports = 'False'
WHERE Sports = '0'	

UPDATE students_performance
SET Sports = 'True'
WHERE Sports = '1'	
```

**Music**
```sql
UPDATE students_performance
SET Music = 'False'
WHERE Music = '0'	

UPDATE students_performance
SET Music = 'True'
WHERE Music = '1'	
```

**Volunteering**
```sql
UPDATE students_performance
SET Volunteering = 'False'
WHERE Volunteering = '0'	

UPDATE students_performance
SET Volunteering = 'True'
WHERE Volunteering = '1'
```

## 3. Using the CASE Function for Conditional Data Transformation

Within these queries, i applied the CASE function to conditionally transform values within the dataset. This allowed me to convert numerical indicators into more meaningful string values. By using CASE, I was able to efficiently clean and standardize the data, ensuring greater readability and consistency, which improves its overall usability for analysis.

**Ethnicity**
```sql

UPDATE students_performance
SET Ethnicity = 
	CASE 
		WHEN Ethnicity = 0 THEN 'caucasian'
		WHEN Ethnicity = 1 THEN 'african_american'
		WHEN Ethnicity = 2 THEN 'asian'
		WHEN Ethnicity = 3 THEN 'other'
		END
```

**ParentalEducation**
```sql
UPDATE students_performance
SET ParentalEducation = 
	CASE 
		WHEN ParentalEducation = 0 THEN 'none'
		WHEN ParentalEducation = 1 THEN 'high_school'
		WHEN ParentalEducation = 2 THEN 'some_college'
		WHEN ParentalEducation = 3 THEN 'bachelor s'
		WHEN ParentalEducation = 4 THEN 'higher'
		END
```

**ParentalSupport**
```sql
UPDATE students_performance
SET ParentalSupport = 
	CASE 
		WHEN ParentalSupport = 0 THEN 'none'
		WHEN ParentalSupport = 1 THEN 'low'
		WHEN ParentalSupport = 2 THEN 'moderate'
		WHEN ParentalSupport = 3 THEN 'high'
		WHEN ParentalSupport = 4 THEN 'Very High'
		END
```

**GradeClass**
```sql
UPDATE students_performance
SET GradeClass = 
	CASE 
		WHEN GradeClass = '0.0' THEN 'A'
		WHEN GradeClass = '1.0' THEN 'B'
		WHEN GradeClass = '2.0' THEN 'C'
		WHEN GradeClass = '3.0' THEN 'D'
		WHEN GradeClass = '4.0' THEN 'F'
		END
```

## 4. Standardizing Numeric Values with Decimal Precision


Lastly, I ensured consistent numeric formatting in both the StudyTimeWeekly and GPA columns. I started by using the TRY_CAST() function to identify and flag invalid or non-numeric values in these columns. This query helped highlight rows where data could not be converted to a decimal, ensuring any problematic entries were addressed before making further changes.

After addressing invalid data, I standardized the columns by altering their data types to DECIMAL(3, 1)  and DECIMAL(2, 1), respectively, using an ALTER TABLE command. Additionally, I applied the ROUND() function to round existing numeric values to one decimal place. These steps ensured both columns maintained consistent, clean, and reliable data for accurate analysis.

**StudyTimeWeekly**

```sql
SELECT StudyTimeWeekly
FROM students_performance
WHERE TRY_CAST(StudyTimeWeekly AS DECIMAL(18, 15)) IS NULL
AND StudyTimeWeekly IS NOT NULL

ALTER TABLE students_performance
ALTER COLUMN StudyTimeWeekly DECIMAL(3, 1)

UPDATE students_performance
SET StudyTimeWeekly = ROUND(StudyTimeWeekly, 1);
```

**GPA**

```sql
SELECT GPA
FROM students_performance
WHERE TRY_CAST(GPA AS DECIMAL(18, 15)) IS NULL
AND GPA IS NOT NULL

ALTER TABLE students_performance
ALTER COLUMN GPA DECIMAL(2, 1)

UPDATE students_performance
SET GPA = ROUND(GPA, 1);
```

Here is a display of two images showing the data before and after the data cleaning process.


![before cleaning](https://github.com/theodorosmalezidis/students_perfomance/blob/main/images/student_data_table_image.old.png?raw=true)

*Before data cleaning (This table visualization was created with Python after importing my SQL query results)*

![after cleaning](https://github.com/theodorosmalezidis/students_perfomance/blob/main/images/student_data_table(3).png?raw=true)

*After data cleaning (This table visualization was created with Python after importing my SQL query results)*


# Conclusion

This project highlights the importance of careful data validation, type conversion, and precision management in SQL, ultimately leading to cleaner, more interpretable data ready for meaningful insights and analysis.
