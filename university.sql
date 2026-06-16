DROP DATABASE IF EXISTS studentassist_db;
CREATE DATABASE studentassist_db;
USE studentassist_db;

CREATE TABLE course (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(120) NOT NULL UNIQUE,
    duration VARCHAR(60) NOT NULL,
    fee DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_course_fee CHECK (fee > 0)
);

CREATE TABLE faculty (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    specialization VARCHAR(150) NOT NULL,
    salary DECIMAL(12, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_faculty_salary CHECK (salary > 0)
);

CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    course_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_student_course
        FOREIGN KEY (course_id) REFERENCES course(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_student_phone_length CHECK (CHAR_LENGTH(phone) >= 10)
);

CREATE TABLE contact (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE student_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    action_type VARCHAR(50) NOT NULL,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details VARCHAR(255) NOT NULL
);

CREATE TABLE contact_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    contact_id INT NOT NULL,
    action_type VARCHAR(50) NOT NULL,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details VARCHAR(255) NOT NULL
);

INSERT INTO course (course_name, duration, fee) VALUES
('Web Development', '12 Weeks', 25000.00),
('Data Structures', '10 Weeks', 22000.00),
('Machine Learning', '16 Weeks', 35000.00),
('Database Management', '8 Weeks', 20000.00),
('Cybersecurity', '14 Weeks', 30000.00),
('Mobile App Development', '12 Weeks', 28000.00);

INSERT INTO faculty (name, specialization, salary) VALUES
('Dr. Alice Johnson', 'Web Development', 120000.00),
('Dr. Emily Carter', 'Data Structures', 115000.00),
('Dr. Sophia Brown', 'Machine Learning', 150000.00),
('Dr. Olivia Smith', 'Database Systems', 130000.00),
('Dr. Ava Martinez', 'Cybersecurity', 140000.00),
('Dr. Mia Turner', 'Mobile Computing', 125000.00);

INSERT INTO student (name, email, phone, course_id) VALUES
('Ali Khan', 'ali.khan@studentassist.com', '03112223334', 1),
('Sara Ahmed', 'sara.ahmed@studentassist.com', '03223334445', 3),
('Usman Tariq', 'usman.tariq@studentassist.com', '03334445556', 4);

INSERT INTO contact (name, email, message) VALUES
('Hina Noor', 'hina.noor@example.com', 'Please share details about your web development course.'),
('Bilal Hassan', 'bilal.hassan@example.com', 'I want to know the fee structure for machine learning.');

DELIMITER //

CREATE PROCEDURE GetStudentsWithCourses()
BEGIN
    SELECT
        student.id,
        student.name,
        student.email,
        student.phone,
        course.course_name,
        course.duration,
        course.fee
    FROM student
    INNER JOIN course ON course.id = student.course_id
    ORDER BY student.id;
END //

CREATE PROCEDURE AddStudentRecord(
    IN p_name VARCHAR(120),
    IN p_email VARCHAR(150),
    IN p_phone VARCHAR(20),
    IN p_course_id INT
)
BEGIN
    INSERT INTO student (name, email, phone, course_id)
    VALUES (p_name, LOWER(p_email), p_phone, p_course_id);
END //

CREATE PROCEDURE AddContactMessage(
    IN p_name VARCHAR(120),
    IN p_email VARCHAR(150),
    IN p_message TEXT
)
BEGIN
    INSERT INTO contact (name, email, message)
    VALUES (p_name, LOWER(p_email), p_message);
END //

CREATE PROCEDURE GetCourseEnrollmentSummary()
BEGIN
    SELECT
        course.id,
        course.course_name,
        COUNT(student.id) AS enrolled_students
    FROM course
    LEFT JOIN student ON student.course_id = course.id
    GROUP BY course.id, course.course_name
    ORDER BY course.id;
END //

CREATE TRIGGER trg_before_student_insert
BEFORE INSERT ON student
FOR EACH ROW
BEGIN
    SET NEW.email = LOWER(TRIM(NEW.email));
    SET NEW.phone = TRIM(NEW.phone);
END //

CREATE TRIGGER trg_after_student_insert
AFTER INSERT ON student
FOR EACH ROW
BEGIN
    INSERT INTO student_audit (student_id, action_type, details)
    VALUES (NEW.id, 'INSERT', CONCAT('Student ', NEW.name, ' enrolled in course ID ', NEW.course_id));
END //

CREATE TRIGGER trg_after_contact_insert
AFTER INSERT ON contact
FOR EACH ROW
BEGIN
    INSERT INTO contact_audit (contact_id, action_type, details)
    VALUES (NEW.id, 'INSERT', CONCAT('Contact message received from ', NEW.name));
END //

DELIMITER ;

CREATE VIEW vw_student_course_details AS
SELECT
    student.id,
    student.name,
    student.email,
    student.phone,
    course.course_name,
    course.duration,
    course.fee
FROM student
INNER JOIN course ON course.id = student.course_id;

CREATE VIEW vw_faculty_salary_summary AS
SELECT
    specialization,
    COUNT(*) AS total_faculty,
    AVG(salary) AS average_salary,
    MAX(salary) AS highest_salary
FROM faculty
GROUP BY specialization;

SELECT * FROM course;
SELECT * FROM faculty;
SELECT * FROM student;
SELECT * FROM contact;

SELECT student.name, course.course_name
FROM student
INNER JOIN course ON course.id = student.course_id;

SELECT course.course_name, COUNT(student.id) AS total_students
FROM course
LEFT JOIN student ON student.course_id = course.id
GROUP BY course.course_name
ORDER BY total_students DESC;

SELECT name, specialization, salary
FROM faculty
WHERE salary > 120000
ORDER BY salary DESC;

SELECT * FROM vw_student_course_details;
SELECT * FROM vw_faculty_salary_summary;

CALL GetStudentsWithCourses();
CALL GetCourseEnrollmentSummary();
