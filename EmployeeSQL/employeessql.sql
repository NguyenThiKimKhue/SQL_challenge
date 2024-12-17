-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

DROP TABLE IF EXISTS department CASCADE;
CREATE TABLE "department" (
    "dept_no" varchar(50)   NOT NULL,
    "dept_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_department" PRIMARY KEY (
        "dept_no"
     )
);

DROP TABLE IF EXISTS dept_emp CASCADE;
CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(50)   NOT NULL
);

DROP TABLE IF EXISTS dept_manager CASCADE;
CREATE TABLE "dept_manager" (
    "dept_no" varchar(50)   NOT NULL,
    "emp_no" int   NOT NULL
);

DROP TABLE IF EXISTS employees CASCADE;
CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "title_id" varchar(50)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(100)   NOT NULL,
    "last_name" varchar(100)   NOT NULL,
    "sex" varchar(10)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

DROP TABLE IF EXISTS salaries CASCADE;
CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

DROP TABLE IF EXISTS titles CASCADE;
CREATE TABLE "titles" (
    "title_id" varchar(50)   NOT NULL,
    "title" varchar(50)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "department" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "department" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_title_id" FOREIGN KEY("title_id")
REFERENCES "employees" ("title_id");

select * from department;
select * from dept_emp;
select * from dept_manager;
select * from employees where title_id = 'm0001';
select * from salaries;
select * from titles;

-- List the employee number, last name, first name, sex, and salary of each employee 
SELECT
e.emp_no, e.last_name, e. first_name, e.sex, s.salary
FROM
	employees e
	JOIN salaries s on e.emp_no=s.emp_no

	
-- List the first name, last name, and hire date for the employees who were hired in 1986 
SELECT
last_name, first_name, hire_date
FROM
	employees
WHERE
	to_char(hire_date, 'YYYY-MM-DD')like '1986%';
	

-- List the manager of each department along with their department number, department name, employee number, last name, and first name 

SELECT
    de.dept_no,
    t.title,
    e.emp_no,
    e.last_name,
    e.first_name
FROM
    employees e
    JOIN titles t ON e.title_id = t.title_id
	JOIN dept_emp de ON e.emp_no = de.emp_no
WHERE
    t.title = 'Manager'	
ORDER BY
	de.dept_no ASC;
	
-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name 
SELECT
    d.dept_no,
    d.dept_name,
    e.emp_no,
    e.last_name,
    e.first_name
FROM
    employees e
	JOIN dept_emp de ON e.emp_no = de.emp_no
	JOIN department d ON d.dept_no = de.dept_no
ORDER BY
	d.dept_name ASC;

	
-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B 
SELECT
 	first_name, last_name, sex
FROM
    employees e
WHERE
    last_name LIKE 'B%'	


-- List each employee in the Sales department, including their employee number, last name, and first name 
SELECT
    d.dept_name,
    e.emp_no,
    e.last_name,
    e.first_name
FROM
    employees e
	JOIN dept_emp de ON e.emp_no = de.emp_no
	JOIN department d ON d.dept_no = de.dept_no
WHERE
    d.dept_name = 'Sales'	


-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name 
SELECT
    d.dept_name,
    e.emp_no,
    e.last_name,
    e.first_name
FROM
    employees e
	JOIN dept_emp de ON e.emp_no = de.emp_no
	JOIN department d ON d.dept_no = de.dept_no
WHERE
    d.dept_name = 'Sales' OR d.dept_name = 'Development';	

	
-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) 
SELECT
    last_name,
	COUNT(last_name)as cl
FROM
    employees 
GROUP BY
    LAST_NAME	
ORDER BY
	cl ASC;


