-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`student` ;

CREATE TABLE IF NOT EXISTS `university`.`student` (
  `student_id` INT NOT NULL,
  `fname` VARCHAR(20) NOT NULL,
  `lname` VARCHAR(20) NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `city` VARCHAR(20) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `dob` DATE NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`college` ;

CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT NOT NULL,
  `college_name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`department` ;

CREATE TABLE IF NOT EXISTS `university`.`department` (
  `dept_id` INT NOT NULL,
  `dept_name` VARCHAR(60) NOT NULL,
  `dept_code` VARCHAR(10) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`dept_id`),
  INDEX `fk_department_college_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`course` ;

CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_id` INT NOT NULL,
  `course_num` INT NOT NULL,
  `course_name` VARCHAR(50) NOT NULL,
  `credits` INT NOT NULL,
  `dept_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_department1_idx` (`dept_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`dept_id`)
    REFERENCES `university`.`department` (`dept_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`faculty` ;

CREATE TABLE IF NOT EXISTS `university`.`faculty` (
  `faculty_id` INT NOT NULL,
  `faculty_fname` VARCHAR(20) NOT NULL,
  `faculty_lname` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`term` ;

CREATE TABLE IF NOT EXISTS `university`.`term` (
  `term_id` INT NOT NULL,
  `term` VARCHAR(10) NOT NULL,
  `year` YEAR(4) NOT NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section` ;

CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT NOT NULL,
  `section` INT NOT NULL,
  `capacity` INT NOT NULL,
  `term_id` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_term1_idx` (`term_id` ASC) VISIBLE,
  INDEX `fk_section_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `university`.`term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `university`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `section_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`section_id`, `student_id`),
  INDEX `fk_section_has_student_student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_section_has_student_section1_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_has_student_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_has_student_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



INSERT INTO college VALUES
	(1, 'College of Physical Science and Engineering'),
    (2, 'College of Business and Communication'),
    (3, 'College of Language and Letters');
    
INSERT INTO department VALUES
	(1, 'Computer Information Technology', 'CIT', 1),
    (2, 'Economics', 'ECON', 2),
    (3, 'Humanities and Philosophy', 'HUM', 3);
    
INSERT INTO course VALUES
	(1, 111, 'Intro to Databases', 3, 1),
    (2, 388, 'Econometrics', 4, 2),
    (3, 150, 'Micro Economics', 3, 2),
    (4, 376, 'Classical Heritage', 2, 3);
    
INSERT INTO term VALUES
	(1, 'Fall', '2019'),
    (2, 'Winter', '2018');
    
INSERT INTO faculty VALUES
	(1, 'Marty', 'Morring'),
    (2, 'Nate', 'Nathan'),
    (3, 'Ben', 'Barrus'),
    (4, 'John', 'Jensen'),
    (5, 'Bill', 'Barney');
    
INSERT INTO student VALUES
	(1, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
    (2, 'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
    (3, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
    (4, 'Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
    (5, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
    (6, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
    (7, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
    (8, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
    (9, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
    (10, 'Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');
    
INSERT INTO section VALUES
	(1, 1, 30, 1, 1, 1), 
    (2, 1, 50, 1, 2, 3), 
    (3, 2, 50, 1, 2, 3),
    (4, 1, 35, 1, 3, 2), 
    (5, 1, 30, 1, 4, 4),
    (6, 2, 30, 2, 1, 1), 
    (7, 3, 35, 2, 5, 1),
    (8, 1, 50, 2, 2, 3), 
    (9, 2, 50, 2, 2, 3), 
    (10, 1, 30, 2, 4, 4);
    
INSERT INTO enrollment VALUES
	(7, 6), 
    (6, 7), 
    (8, 7),
    (10, 7),
    (5, 4),
    (9, 9),
    (4, 2),
    (4, 3), 
    (4, 5),
    (5, 5), 
    (1, 1), 
    (3, 1), 
    (9, 8), 
    (6, 10);
    

-- W12 Assignment Project: Part 2 

USE university;

-- Query #1

SELECT fname, lname, DATE_FORMAT(dob, '%M %e, %Y') AS ' Sept Birthdays'
FROM student
WHERE dob LIKE '%-09-%';

-- * Query #2

SELECT lname, fname, DATEDIFF('2017-01-05', dob)/365 AS 'Years', DATEDIFF('2017-01-05', dob) AS 'Days', dob AS 'Years and Days'
FROM student
ORDER BY 'Years';

-- Query #3

SELECT fname, lname
FROM student
	JOIN enrollment 
		ON student.student_id = enrollment.student_id
	JOIN section 
		ON enrollment.section_id = section.section_id
	JOIN faculty
		ON section.faculty_id = faculty.faculty_id
WHERE faculty_fname = 'John' AND faculty_lname = 'Jensen'
ORDER BY lname;

-- Query #4 

SELECT faculty_fname AS fname, faculty_lname AS lname
FROM faculty 
	JOIN section 
		ON faculty.faculty_id = section.faculty_id
	JOIN enrollment 
		ON section.section_id = enrollment.section_id
	JOIN student 
		ON enrollment.student_id = student.student_id
WHERE fname = 'Bryce'
ORDER BY faculty_lname;

-- Query #5

SELECT fname, lname 
FROM student
	JOIN enrollment 
		ON student.student_id = enrollment.student_id
	JOIN section 
		ON enrollment.section_id = section.section_id
	JOIN course
		ON section.course_id = course.course_id
WHERE course_name = 'Econometrics'
ORDER BY lname; 

-- Query #6

SELECT dept_code AS 'department_code', course_num, course_name AS 'name'
FROM department 
	JOIN course
		ON department.dept_id = course.dept_id
	JOIN section 
		ON course.course_id = section.course_id
	JOIN enrollment
		ON section.section_id = enrollment.section_id
	JOIN student
		ON enrollment.student_id = student.student_id
WHERE fname = 'Bryce' AND lname = 'Carlson'
ORDER BY course_name;

-- * Query #7 

SELECT term, COUNT(term) AS 'Enrollment'
FROM student st
	JOIN enrollment e
		ON st.student_id = e.student_id
	JOIN section se
		ON e.section_id = se.section_id
	JOIN term t
		ON se.term_id = t.term_id
WHERE term = 'Fall'
GROUP BY term;

-- Query #8

SELECT college_name AS 'Colleges', COUNT(course_name) AS 'Courses'
FROM college
	JOIN department 
		ON college.college_id = department.college_id 
	JOIN course 
		ON department.dept_id = course.dept_id
GROUP BY college_name
ORDER BY college_name;

-- * Query #9 

SELECT faculty_fname, faculty_lname, COUNT(lname) AS TeachingCapacity
FROM faculty 
	JOIN section 
		ON faculty.faculty_id = section.faculty_id
	JOIN enrollment 
		ON section.section_id = enrollment.section_id
	JOIN student 
		ON enrollment.student_id = student.student_id
GROUP BY faculty_fname, faculty_lname
ORDER BY TeachingCapacity;
        
-- Query #10

SELECT lname, fname, SUM(credits) AS Credits
FROM student 
	JOIN enrollment 
		ON student.student_id = enrollment.student_id 
	JOIN section 
		ON enrollment.section_id = section.section_id
	JOIN course
		ON section.course_id = course.course_id
GROUP BY lname
HAVING Credits > 3
ORDER BY Credits DESC;
		
        




    


