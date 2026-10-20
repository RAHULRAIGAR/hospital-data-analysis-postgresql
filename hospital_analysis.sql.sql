DROP TABLE IF EXISTS Hospital;

CREATE TABLE Hospital(
		Hospital_Name VARCHAR(50) NOT NULL,
		Location_name VARCHAR(100),
        Department VARCHAR(50),
		Doctors_Count NUMERIC(10),
		Patients_Count NUMERIC(10),
		Admission_Date DATE,
		Discharge_Date DATE,
		Medical_Expenses NUMERIC(10,2)
)

SELECT * FROM Hospital;

COPY Hospital(Hospital_Name, Location_Name, Department, Doctors_Count,
     Patients_Count, Admission_Date, Discharge_Date, Medical_Expenses)
FROM 'C:\project\Hospital_Data.csv'
CSV HEADER;

-- 1. Total Number of Patients
--    • Write an SQL query to find the total number of patients across all hospitals.
		SELECT SUM(patients_count) AS total_patients 
		FROM Hospital;
		
-- 2. Average Number of Doctors per Hospital
--    • Retrieve the average count of doctors available in each hospital.
		SELECT Hospital_Name, AVG(Doctors_Count) AS Avg_Doctors 
		FROM Hospital 
		GROUP BY Hospital_Name;
		
-- 3. Top 3 Departments with the Highest Number of Patients
--    • Find the top 3 hospital departments that have the highest number of patients.
		SELECT department, SUM(patients_count) AS Total_Patients 
		FROM Hospital
		GROUP BY department 
		ORDER BY Total_Patients DESC 
		LIMIT 3;
				
-- 4. Hospital with the Maximum Medical Expenses
--    • Identify the hospital that recorded the highest medical expenses.
		SELECT Hospital_Name, SUM(medical_expenses) AS Total_Expenses 
		FROM Hospital
		GROUP BY Hospital_Name 
		ORDER BY Total_Expenses DESC 
		LIMIT 1;
				
-- 5. Daily Average Medical Expenses
--    • Calculate the average medical expenses per day for each hospital.
		SELECT Hospital_Name, 
       AVG(medical_expenses/ NULLIF((Discharge_Date - Admission_Date), 0)) AS Daily_Avg_Expense 
		FROM Hospital
		GROUP BY Hospital_Name;
		
-- 6. Longest Hospital Stay
--    • Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.
		SELECT hospital_Name, department, Admission_Date, Discharge_Date, 
       (Discharge_Date - Admission_Date) AS Stay_Days 
		FROM Hospital
		ORDER BY Stay_Days DESC 
		LIMIT 1;
		
-- 7. Total Patients Treated Per City
--    • Count the total number of patients treated in each city.
		SELECT location_name, SUM(patients_count) AS Total_Patients 
		FROM Hospital
		GROUP BY Location_name;
		
-- 8. Aerage Length of Stay Per Department;
--    • Calculate the average number of days patients spend in each department.
 		SELECT department, AVG(Discharge_Date - Admission_Date) AS Avg_Stay_Days 
		FROM Hospital
		GROUP BY department;
		
-- 9. Identify the Department with the Lowest Number of Patients
--    • Find the department with the least number of patients.
		SELECT department, SUM(patients_count) AS Total_Patients 
		FROM Hospital
		GROUP BY department 
		ORDER BY Total_Patients ASC 
		LIMIT 1;
		
-- 10. Monthly Medical Expenses Report
--    • Group the data by month and calculate the total medical expenses for each month.
		SELECT TO_CHAR(Admission_Date, 'YYYY-MM') AS Month, 
       SUM(medical_expenses) AS Total_Monthly_Expenses 
		FROM Hospital
		GROUP BY Month 
		ORDER BY Month;