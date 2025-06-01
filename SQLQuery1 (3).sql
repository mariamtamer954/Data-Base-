create database real_state_G2

/****__ Create Table Customers __***/
create table Customers(
cust_ssn int primary key identity(1,1) ,
cust_f_name varchar(30) not null,
cust_l_name varchar(30) not null,
cust_city varchar(30) ,
cust_street varchar(30) ,
cust_state varchar(30) ,
cust_mertail_status varchar(30) ,
email varchar(30) unique
)

/***__ Create Table Cust_phone __***/
create table Cust_phone(
cust_ssn int,
cust_phone varchar(30) unique,
primary key (cust_ssn ,cust_phone ),
constraint cust_phone_fk foreign key (cust_ssn)
references customers(cust_ssn)
)

/****__ Create Table Projects __****/
create table Projects(
project_id int primary key  identity(1,1) ,
project_name varchar(30) not null,
project_area int not null,
project_manager varchar(30) not null,
project_budget int,
project_location varchar(30) not null,
project_start_date varchar(30) not null,
project_expect_end_date varchar(30) not null,
project_level_of_completion varchar(30) 
)

/****__ Create Table Departments __****/
create table Departments(
depart_name varchar(30) primary key,
no_of_employyes int not null,
)


create table Depart_location(
depart_name varchar(30),
depart_location varchar(30),
constraint depat_location foreign key (depart_name)
references Departments(depart_name)
)

/***__ Create Table Employee __***/
create table Employee(
emp_ssn int primary key  identity(1,1) ,
emp_f_name varchar(30) not null,
emp_l_name varchar(30) not null,
emp_city varchar(30) ,
emp_street varchar(30) ,
emp_state varchar(30) ,
emp_salary int ,
emp_gender varchar(30),
emp_position varchar(30),
email varchar(30) unique,
manager_ID int ,
depart_name varchar(30),
foreign key (manager_ID) references Employee(emp_ssn),
constraint emp_depart_fk foreign key (depart_name)
references Departments(depart_name)
)


/****__ Create Table Buildings __***/
create table Buildings (
build_ID int primary key  identity(1,1) ,
no_unit_sold int ,
no_of_unit int,
bulid_start_date varchar(30),
build_end_date varchar(30),
build_status varchar(30),
bulid_no int not null,
build_sold varchar(30),
build_avaliable varchar(30),
build_reserved varchar(30),
No_of_floors int,
project_id int ,
constraint project_build_fk foreign key (project_id)
references Projects (project_id)
)

/***__ Create Table Payments __***/
create table Payments (
pay_id int primary key  identity(1,1) ,
pay_date varchar(30) not null,
pay_check varchar (30) ,
pay_cash varchar (30),
pay_installment varchar (30),
pay_fiat_money varchar (30),
pay_amount int not null,
pay_bank_transfer varchar(30),
cust_ssn int references customers(cust_ssn)
)

/***__ Create Table Unit __***/
create table Unit (
unit_ID int primary key  identity(1,1) ,
unit_price int not null,
unit_no int not null ,
unit_area int null,
unit_sold varchar(30),
unit_reserved varchar (30),
unit_aviliable varchar(30),
unit_level_of_completion varchar(30) ,
cust_ssn int foreign key references customers (cust_ssn),
build_id int foreign key references Buildings(build_ID)
)

/***__ Create Table Contarcts __***/
create table Contarcts (
contarct_id int primary key  identity(1,1) ,
contarct_type varchar (30) not null,
contarct_date varchar(30) not null,
unit_ID int,
emp_ssn int references Employee (emp_ssn),
pay_id int references payments(pay_id),
constraint Unit_contarct_fk foreign key (unit_ID )
references Unit (unit_ID )
)

/****__ Create Table Compaints __****/
create table Compaints(
compaints_ID int primary key  identity(1,1) ,
compaints_date varchar (30) not null,
compaints_describtion varchar (30) ,

)

/****__ Create Table Dependents __***/
create table Dependents(
dependent_name varchar(30) ,
emp_ssn int references Employee (emp_ssn)
)
/***__ Create Table unit_picture __***/
create table unit_picture(
unit_id int foreign key references Unit (unit_ID),
unit_image image 
)

/****__ Create Table cust_deal_with_emp __***/
create table cust_deal_with_emp(
cust_ssn int references customers(cust_ssn),
emp_ssn int references Employee (emp_ssn)
)

/****__ Create Table emp_work_project __****/
create table emp_work_project (
emp_hours int ,
emp_ssn int references Employee (emp_ssn),
project_id int references Projects (project_id)
)

/****__ Create Table department_control_project __***/
create table department_control_project(
no_of_project int ,
project_id int references Projects (project_id),
depart_name varchar(30) references Departments(depart_name),
)

/***__ Create Table customer_make_compaints __***/
create table customer_make_compaints(
cust_ssn int references customers(cust_ssn),
compaints_id int references compaints(compaints_ID)
)
/***__ Create Table employee_record_compaints __***/

create table employee_record_compaints(
emp_ssn int references employee(emp_ssn),
compaints_id int references compaints(compaints_ID)
)



/***__ Alter Table Projects _***/

alter table Projects
alter column project_start_date date;

alter table Projects
add project_status varchar(30) not null ;

alter table Projects
drop column project_status  ;

alter table Projects
add constraint unq_ex unique (project_expect_end_date);

alter table Projects
drop constraint unq_ex ;


/***__ Alter Table Contarcts _***/

alter table Contarcts
alter column contarct_date date not null;


/***__ Alter Table Compaints _***/

 alter table Compaints
 alter column compaints_date date not null;

 
 /****__ Alter Table Payments _***/

 alter table Payments
 alter column pay_date date not null;


 /****__ Alter Table Units  _***/

 alter table Unit
 alter column unit_area varchar(30)

 /***Insert into Customers table***/
insert into Customers (cust_f_name, cust_l_name, cust_city, cust_street, cust_state, cust_mertail_status, email)
values 
('John', 'Doe', 'City1', 'Street1', 'State1', 'Single', 'john.doe@email.com'),
('Jane', 'Smith', 'City2', 'Street2', 'State2', 'Married', 'jane.smith@email.com'),
('Alice', 'Johnson', 'City3', 'Street3', 'State3', 'Married', 'alice.johnson@email.com'),
('Bob', 'Williams', 'City4', 'Street7', 'State4', 'Single', 'bob.williams@email.com'),
('Charlie', 'Brown', 'City5', 'Street5', 'State5', 'Single', 'charlie.brown@email.com'),
('David', 'Clark', 'City6', 'Street6', 'State6', 'Married', 'david.clark@email.com'),
('Emma', 'White', 'City7', 'Street7', 'State7', 'Single', 'emma.white@email.com'),
('Frank', 'Miller', 'City8', 'Street3', 'State8', 'Married', 'frank.miller@email.com'),
('Grace', 'Taylor', 'City9', 'Street2', 'State9', 'Married', 'grace.taylor@email.com'),
('Harry', 'Walker', 'City10', 'Street6', 'State10', 'Single', 'harry.walker@email.com');

 /**Insert into Cust_phone table***/
insert into Cust_phone (cust_ssn, cust_phone)
values 
(1, '123-456-7890'),
(2, '987-654-3210'),
(3, '111-222-3333'),
(4, '444-555-6666'),
(5, '777-888-9999'),
(6, '333-111-4444'),
(7, '555-666-7777'),
(8, '999-888-7777'),
(9, '111-222-5555'),
(10, '666-777-9999');

/***Insert into Projects table**/
insert into Projects (project_name, project_area, project_manager, project_budget, project_location, project_start_date, project_expect_end_date)
values  
('Project1',5000, 'Manager1', 14257275, 'Location1', '2023-01-01', '2023-12-31'),
('Project2', 10000, 'Manager2', 745725, 'Location2', '2023-02-01', '2023-11-30'),
('Project3', 18240, 'Manager3', 7527527, 'Location3', '2023-03-01', '2023-11-30'),
('Project4', 5000, 'Manager1', 7278524, 'Location4', '2023-04-01', '2023-10-31'),
('Project5', 5000, 'Manager2', 752782752, 'Location5', '2023-05-01', '2023-10-30'),
('Project6', 500074, 'Manager6', 72527, 'Location6', '2023-06-01', '2023-10-29'),
('Project7', 50004, 'Manager7', 10004452, 'Location7', '2023-07-01', '2023-10-28'),
('Project8', 5074, 'Manager3', 5000000, 'Location8', '2023-08-01', '2023-10-27'),
('Project9', 5000, 'Manager9', 4785210, 'Location9', '2023-09-01', '2023-10-26'),
('Project10', 5000, 'Manager2', 1000224, 'Location10', '2023-10-01', '2023-10-25');

/***Insert into Departments table***/
insert into Departments (depart_name, no_of_employyes)
values
('HR', 20),
('Finance', 15),
('Marketing', 25),
('IT', 30),
('Sales', 18),
('Operations', 22),
('Research', 12),
('Legal', 10),
('CustomerService', 28),
('Production', 35),
('Money', 50);


 /* Insert into Depart_location table *** */
insert into Depart_location (depart_name, depart_location)
values  
('HR', 'Location1'),
('Finance', 'Location2'),
('Marketing', 'Location3'),
('IT', 'Location4'),
('Sales', 'Location5'),
('Operations', 'Location6'),
('Research', 'Location7'),
('Legal', 'Location8'),
('CustomerService', 'Location9'),
('Production', 'Location10');

 /* Insert into Employee table */
insert into Employee (emp_f_name, emp_l_name, emp_city, emp_street, emp_state, emp_salary, email, manager_ID, depart_name)
values
('John', 'Smith', 'City3', 'Street1', 'State1', 50000, 'john.smith@email.com', NULL, 'HR'),
('Jane', 'Doe', 'City1', 'Street6', 'State2', 60000, 'jane.doe@email.com', 1, 'HR'),
('Alice', 'Johnson', 'City3', 'Street3', 'State3', 55000, 'alice.johnson@email.com', 1, 'Marketing'),
('Bob', 'Williams', 'City3', 'Street4', 'State4', 70000, 'bob.williams@email.com', 3, 'IT'),
('Charlie', 'Brown', 'City5', 'Street5', 'State5', 65000, 'charlie.brown@email.com', 4, 'Sales'),
('David', 'Miller', 'City4', 'Street2', 'State6', 80000, 'david.miller@email.com', 2, 'Operations'),
('Eva', 'Clark', 'City5', 'Street3', 'State7', 75000, 'eva.clark@email.com', 5, 'Marketing'),
('Frank', 'Moore', 'City8', 'Street8', 'State8', 90000, 'frank.moore@email.com', 2, 'Legal'),
('Grace', 'Anderson', 'City2', 'Street1', 'State9', 85000, 'grace.anderson@email.com', 4, 'Sales'),
('Henry', 'Taylor', 'City1', 'Street10', 'State10', 95000, 'henry.taylor@email.com', 3, 'IT'),
('John', 'Smith', 'City1', 'Street1', 'State1', '50000', 'johhn.smith@email.com', NULL, null);

 /* Insert into payment table */

insert into Payments  (pay_date, pay_check, pay_cash, pay_installment, pay_fiat_money, pay_amount, pay_bank_transfer, cust_ssn)
values
('2023-01-15', 'Check1', NULL, NULL, NULL, 5000, NULL, 1),
('2023-02-15', NULL, 'Cash1', NULL, NULL, 6000, NULL, 2),
('2023-03-15', NULL, NULL, 'Installment1', NULL, 7000, NULL, 3),
('2023-04-15', 'Check2', NULL, NULL, NULL, 5500, NULL, 4),
('2023-05-15', NULL, 'Cash2', NULL, NULL, 6500, NULL, 5),
('2023-06-15', NULL, NULL, 'Installment2', NULL, 7500, NULL, 6),
('2023-07-15', 'Check3', NULL, NULL, NULL, 8000, NULL, 7),
('2023-08-15', NULL, 'Cash3', NULL, NULL, 9000, NULL, 8),
('2023-09-15', NULL, NULL, 'Installment3', NULL, 8500, NULL, 9),
('2023-10-15', 'Check4', NULL, NULL, NULL, 9500, NULL, 10);

 /* Insert into Building table */

insert into Buildings (no_unit_sold, no_of_unit, bulid_start_date, build_end_date, build_status, bulid_no, No_of_floors, project_id , build_reserved,build_sold,build_avaliable)
values
(5, 20, '2023-03-01', '2023-12-31', 'Under Construction', 1, 5, 1 , '10','50','yes'),
(10, 15, '2023-04-01', '2023-11-30', 'Completed', 2, 8, 2,'10','55','yes'),
(7, 25, '2023-05-01', '2023-10-31', 'Under Construction', 3, 6, 1, '50','58','yes'),
(8, 18, '2023-06-01', '2023-09-30', 'In Progress', 4, 7, 2, '17','25','yes'),
(6, 22, '2023-07-01', '2023-08-31', 'Completed', 5, 4, 1, '10','50','yes'),
(9, 17, '2023-08-01', '2023-07-31', 'Under Construction', 6 , 6, 2, '10','50','yes'),
(4, 30, '2023-09-01', '2023-06-30', 'Completed', 7 ,3 ,1, '10','50','yes'),
(11, 14, '2023-10-01', '2023-05-31', 'In Progress', 8,  5, 2, '10','50','yes'),
(3, 28, '2023-11-01', '2023-04-30', 'Completed', 9,  4, 1, '10','50','yes'),
(12, 12, '2023-12-01', '2023-03-31', 'Under Construction', 10, 7, 2, '10','50','yes');





 /* Insert into Unit table */

insert into Unit (unit_price, unit_no, unit_area, unit_sold, unit_reserved, unit_aviliable,unit_level_of_completion, cust_ssn, build_id)
values
(150000, 101, 1200, 'Yes', 'No', 'No', '50%', 1, 1),
(180000, 201, 1500, 'No', 'Yes', 'No', '75%', 2, 2),
(160000, 301, 1300, 'Yes', 'No', 'No', '60%', 3, 1),
(200000, 102, 1100, 'No', 'No', 'Yes', '80%', 4, 2),
(170000, 202, 1400, 'No', 'Yes', 'No', '70%', 5, 1),
(190000, 302, 1200, 'Yes', 'No', 'No', '65%', 6, 2),
(140000, 103, 1000, 'No', 'No', 'Yes', '85%', 7, 1),
(210000, 203, 1600, 'Yes', 'Yes', 'No', '90%', 8, 2),
(130000, 303, 900, 'No', 'Yes', 'No', '55%', 9, 1),
(220000, 104, 1700, 'Yes', 'No', 'No', '95%', 10, 2);


 /* Insert into Contarcts table */

insert into Contarcts (contarct_type, contarct_date, emp_ssn, pay_id ,unit_ID)
values
('Type1', '2023-01-15', 1, 1,1),
('Type2', '2023-02-20', 1, 2,2),
('Type3', '2023-03-25', 3, 3,1),
('Type4', '2023-04-30', 5, 4,3),
('Type5', '2023-05-05', 5, 5,1),
('Type6', '2023-06-10', 3, 6,2),
('Type7', '2023-07-15', 7, 7,5),
('Type8', '2023-08-20', 8, 8,3),
('Type9', '2023-09-25', 7, 9,2),
('Type10', '2023-10-30', 8, 10,3);


/* Insert into emp_work_project table */

insert into emp_work_project (emp_ssn, project_id)
values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


 /* ____ Update _______ */

/* _ Update Customers_ */
UPDATE Customers
SET cust_city = 'NewCity'
WHERE cust_ssn = 1;

/* _ Update Cust_phone_ */
UPDATE Cust_phone
SET cust_phone = '555-555-5555'
WHERE cust_ssn = 1;

/* _ Update Projects_ */
UPDATE Projects
SET project_budget = 154112
WHERE project_id = 1;

/* _ Update Departments */
UPDATE Departments
SET no_of_employyes = 20
WHERE depart_name = 'Department1';

 /* _ Update Employee_ */
UPDATE Employee
SET emp_salary = 70000
WHERE emp_ssn = 1;


 /* ____ Delete _______ */

 /* __ Delete Data From Unit */
 delete from Unit
 where unit_ID = 11;

  /* __ Delete Data From Buildings */
 delete from Buildings
 where build_ID = 11;

   /* __ Delete Data From Payments */
 delete from Payments
 where pay_id = 11;

    /* __ Delete Data From Employee */
 delete from Employee
 where emp_ssn = 11;

     /* __ Delete Data From Employee */
 delete from Employee
 where emp_ssn = 11;
 
      /* __ Delete Data From Employee */
 delete from Departments
 where depart_name = 'Money';

 /* ____ Select _______ */
  

/* _ Select Data From Customer table _ */
 select  cust_f_name, cust_l_name, cust_city, cust_street, cust_state, cust_mertail_status, email
 from  Customers; 
 select distinct * from Customers;

/* _ Select Data From Employee table _ */
 select emp_f_name, emp_l_name, emp_city, emp_street, emp_state, emp_salary, email, manager_ID, depart_name
 from Employee
 select distinct * from Employee;

/*_ Select Data From Departments table _ */
 select depart_name, no_of_employyes
 from Departments
 select distinct * from Departments;

/*_ Select Data From Building table _ */
  select no_unit_sold, no_of_unit, bulid_start_date, build_end_date, build_status, bulid_no, No_of_floors, project_id
  from Buildings
  select distinct * from Buildings

/*_  Select Data From Unit table _ */

select unit_price, unit_no, unit_area, unit_sold, unit_reserved, unit_aviliable, cust_ssn, build_id
from Unit
select distinct * from Unit


/*___aggregation function______*/

/*_ Aggregation Select Data From Unit table___*/
select  count(*) as "number_of_unit" , min(unit_price) as "minimum_price" , avg(unit_price) as "avg_price"  , max(unit_area) as "maximum_area"
from Unit

/*_ Aggregation Select Data From Employee table__ */
select  count(*) as "number_of_Employee" , min(emp_salary) as "minimum_salary" , avg(emp_salary) as "avg_salary"  , max(emp_salary) as "maximum_salary"
from Employee

/*_ Aggregation Select Data From Projects table__*/
select  count(*) as "number_of_Projects" , min(project_budget) as "minimum_project_budget" , avg(project_budget) as "avg_project_budget"  , max(project_area) as "maximum_project_area"
from Projects

/*__ Aggregation Select Data From Buildings table __*/
select  count(no_unit_sold) as "no_unit_sold" , count(no_of_unit) as "no_of_unit" , avg(No_of_floors) as "avg_No_of_floors" 
from Buildings



/*_____ Groub By and Order Buy and Having and selsect and join _______ */


/*_ Retrieve the department names and the count of employees in each department from__*/
SELECT depart_name, COUNT(emp_ssn) as "number of Employee" 
from Employee
group by depart_name

/*_ Retrieve project managers and the count of projects they manage__*/
SELECT project_manager, COUNT(project_id) as "number of project" 
from Projects
group by project_manager
having COUNT(project_id)> 1
order by project_manager
 /*_ Retrieval for each building  the number of floors it contains__*/
SELECT  build_ID,No_of_floors
from Buildings
group by No_of_floors ,build_ID;



 
 /*_ Retrieve columns contract id contract date and unit ID and sort the results by unit ID__*/
SELECT contarct_id ,contarct_date,unit_ID
from Contarcts
order by unit_ID asc;

 /*_ Retrieve for each employee the full name along with the count of contracts they make, considering only 
 those employees with more than one contract, and sorting the results by full name__*/

SELECT emp_f_name+emp_l_name as "Full name" ,COUNT(contarct_id) as "Count_contarct"
from Employee e join Contarcts c
on e.emp_ssn =c.emp_ssn
group by emp_f_name+emp_l_name
having COUNT(contarct_id)>1
order by emp_f_name+emp_l_name desc;

 /*_ Retrieve for each customer the full name of the maximum unit price and total units and sort the data by total units descending sort  __*/
SELECT cust_f_name + cust_l_name as "Full name", max(unit_price) as "max_unit_price" ,count(unit_ID) as "count_unit"
from Customers c left join Unit u
on c.cust_ssn=u.cust_ssn
group by cust_f_name + cust_l_name
order by count(unit_ID) desc;

 /*_ Retrieve information about the top 5 employees based on the count of projects they worked on, The information includes the project details such as project name, 
 project manager project location  along with the maximum project budget and average project area for each employee and sort the data by employee  __*/		
SELECT  top 5 emp_ssn , count(p.project_id) ,project_name,project_manager ,project_location , max (project_budget) ,avg (project_area)
from emp_work_project w right join Projects p
on w.project_id=p.project_id
group by  project_name,project_manager,project_location,emp_ssn
order by emp_ssn asc;

/*
   This query retrieves payment details (payment ID, date, amount) along with customer information 
   (first name, last name, email) by joining the Payments table with the Customers table 
   based on the customer's social security number (cust_ssn).
*/

select p.pay_id,p.pay_date, p.pay_amount, c.cust_f_name, c.cust_l_name, c.email
from Payments p join Customers c 
on p.cust_ssn = c.cust_ssn;

/*_____ Select Top _______ */

/* 
Retrieve information about the top 5 employees based on the count of projects they worked on. 
The information includes the project details such as project name, project manager, project location, 
along with the maximum project budget and average project area for each employee. 
Sort the data by employee.
*/
select top 5 w.emp_ssn,  count(w.project_id) AS "Number_of_Projects_Worked",   max(p.project_budget)  "Max_Project_Budget", avg(p.project_area)  "Avg_Project_Area"
from emp_work_project w left join Projects p
on w.project_id = p.project_id
group by w.emp_ssn
order by "Number_of_Projects_Worked" desc;


		
/****_Retrieve the top 5 unit prices_***/
select top 5 unit_price
from Unit;