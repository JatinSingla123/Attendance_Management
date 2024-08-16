-- Create the Database
CREATE DATABASE StudentAttendance;
USE StudentAttendance;

-- Create Tables
-- Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Class VARCHAR(10)
);

-- Classes Table
CREATE TABLE Classes (
    ClassID INT PRIMARY KEY,
    ClassName VARCHAR(50)
);

-- Attendance Table
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    ClassID INT,
    Date DATE,
    Status ENUM('Present', 'Absent', 'Late'),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

-- Insert Data into Students Table
INSERT INTO Students (StudentID, FirstName, LastName, Class)
VALUES 
(1, 'John', 'Doe', '10A'),
(2, 'Jane', 'Smith', '10B'),
(3, 'Sam', 'Brown', '10A'),
(4, 'Emily', 'Davis', '10B');

-- Insert Data into Classes Table
INSERT INTO Classes (ClassID, ClassName)
VALUES 
(1, 'Mathematics'),
(2, 'Science');

-- Insert Data into Attendance Table
INSERT INTO Attendance (StudentID, ClassID, Date, Status)
VALUES 
(1, 1, '2024-08-17', 'Present'),
(2, 1, '2024-08-17', 'Absent'),
(3, 2, '2024-08-17', 'Late'),
(4, 2, '2024-08-17', 'Present');

-- Retrieve All Students
SELECT * FROM Students;

-- Retrieve Attendance Records
SELECT * FROM Attendance;

-- Check Attendance for a Specific Student
SELECT a.Date, c.ClassName, a.Status
FROM Attendance a
JOIN Classes c ON a.ClassID = c.ClassID
WHERE a.StudentID = 1;

-- Count Attendance Status for Each Student
SELECT s.FirstName, s.LastName, 
       SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) AS PresentDays,
       SUM(CASE WHEN a.Status = 'Absent' THEN 1 ELSE 0 END) AS AbsentDays,
       SUM(CASE WHEN a.Status = 'Late' THEN 1 ELSE 0 END) AS LateDays
FROM Attendance a
JOIN Students s ON a.StudentID = s.StudentID
GROUP BY a.StudentID;

-- Check Attendance for a Specific Class on a Specific Date
SELECT s.FirstName, s.LastName, a.Status
FROM Attendance a
JOIN Students s ON a.StudentID = s.StudentID
WHERE a.ClassID = 1 AND a.Date = '2024-08-17';

-- Update Attendance Status
UPDATE Attendance
SET Status = 'Present'
WHERE AttendanceID = 2;

-- Delete a Student Record
DELETE FROM Students
WHERE StudentID = 4;
