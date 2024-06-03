-- Create the database
CREATE DATABASE Library;
-- Use the created database
USE Library;
-- Create Branch table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);
-- Create Employee table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
-- Create Books table
CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3) CHECK (Status IN ('yes', 'no')),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);
-- Create Customer table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

-- Create IssueStatus table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(13),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
-- Create ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(13),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
 SHOW tables;
   -- Insert into to all tables are shown below.
insert INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
values (1, 101, 'ABC', '9123423564'),
       (2, 102, 'DDC', '9687900000'),
       (3, 103, 'KJK', '9564543212'),
       (4, 104, 'PIT', '9065432321'),
       (5, 105, 'ELD', '9087777886'),
       (6, 106, 'QQR', '9054345678');

INSERT into Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
values (101, 'Zera Philip', 'Librarian', 30000, 2),
       (102, 'Roy Thomas', 'Library Manager', 60000, 1),
       (103, 'Kevin George', 'Cashier', 35000, 5),
       (104,'Anna Maria', 'Library Assistant', 45000, 1),
       (105, 'Merry Rin', 'Library Clerk', 40000, 2),
       (106, 'Ram Kumar', 'Library Technician', 40000, 3),
       (107, 'John Paul', 'Security', 25000, 4),
       (108, 'Riya Anil', 'Library Clerk', 40000, 2),
       (109, 'Neethu John', 'Senior Librarian', 40000, 1),
       (110, 'Anu Jose', 'Librarian', 30000, 3);

INSERT into Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
values ('121', 'The kite runner ', 'Fiction Drama', 500, 'yes', 'Khaled Hosseini', 'Riverhead Books'),
       ('122', 'Every breath', 'Romance Fiction', 600, 'no', 'Nicholas Sparks', 'Grand Central'),
       ('123', 'Half Girlfriend', 'Romance Fiction', 400, 'yes', 'Chetan Bhagat', 'Rupa & Co'),
       ('124', 'The Alchemist', 'Fantasy Fiction', 500, 'yes', 'Paulo Coelho', 'HarperCollins'),
       ('125', 'Ikigai', 'Self help', 550, 'yes', 'Hector García ', 'Penguin Random House'),
       ('126', 'Pride and Prejudice', 'Fiction', 445, 'no', 'Jane Austen', 'Penguin Classics'),
	   ('127', 'The cartoon', 'History', 300, 'no', 'Sangeeth R', 'Red and Company');

insert INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
values (101, 'Sarah', '123 Abc ', '2023-05-22'),
       (102, 'Tom', '121 Knn', '2024-01-01'),
       (103, 'Alex', '120 Lrv', '2022-11-20'),
       (104, 'Jijo', '125 Pnm','2021-09-03'),
       (105, 'Diya', '127 Stt', '2020-02-19'),
       (106, 'Paul', '122 Dsm', '2024-05-01'),
       (107, 'Richa', '128 Ncv', '2023-12-10');

INSERT into IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
values (1, 101, 'Every breath', '2021-02-05', '122'),
       (2, 102, 'Pride and Prejudice', '2022-03-28', '126'),
       (3, 103, 'Ikigai', '2021-07-25', '125'),
       (4, 104,'Half Girlfriend','2023-01-11','123'),
       (5, 105, 'The Alchemist', '2020-03-21', '124'),
       (6, 106, 'The kite runner', '2020-03-15', '121'),
       (7, 101, 'Every breath', '2021-02-05', '122'),
       (8, 103, 'Ikigai', '2021-07-25', '125'),
       (9, 106, 'The kite runner', '2020-03-15', '121');
       
INSERT into ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date,Isbn_book2)
values (1, 101, 'Ikigai', '2024-05-03', '125'),
       (2, 102, 'The Alchemist', '2024-03-10', '124'),
       (3, 103, 'Every breath', '2024-02-12', '122'),
       (4, 104,'Ikigai', '2024-05-19','125'),
       (5, 105, 'Half Girlfriend', '2024-05-13', '123'),
       (6, 106, 'Every breath', '2024-06-23', '122');

-- Retrieve the book title, category, and rental price of all available books
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- List the employee names and their respective salaries in descending order of salary
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- Retrieve the book titles and the corresponding customers who have issued those books
SELECT B.Book_title, C.Customer_name
FROM IssueStatus I
JOIN Books B ON I.Isbn_book = B.ISBN
JOIN Customer C ON I.Issued_cust = C.Customer_Id;


-- Display the total count of books in each category
SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

-- Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- List the customer names who registered before 2022-01-01 and have not issued any books yet
SELECT C.Customer_name
FROM Customer C
LEFT JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
WHERE C.Reg_date < '2022-01-01' AND I.Issue_Id IS NULL;

-- Display the branch numbers and the total count of employees in each branch
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

-- Display the names of customers who have issued books in the month of June 2023
SELECT DISTINCT C.Customer_name
FROM IssueStatus I
JOIN Customer C ON I.Issued_cust = C.Customer_Id
WHERE I.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- Retrieve book_title from book table containing history
SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

-- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;
       
       
