# SQL_ExamQuestion3 MEMBERS: Mario Ojo and Gaby Norris

Apologies Tsungai, we really struggled overall with the setup of the foreign keys and it took up most of our time as we could not test other things.

Question 4 Queries:

INSERT INTO Books  (title, genre, original_language, publication_year) VALUES 
(‘Harry Gonzales’, ‘Fantasy’, ’English’, 2005),
(‘Assassins Creed’, ‘Action’, ’Italian’, 2015),
(‘Invisible Chicken’, ‘Fiction’, ’Spanish’, 1988);

INSERT  INTO Authors (last_name, first_name, country_origin) VALUES 
(‘Bank’, ‘George’, ’United Kingdom’),
(‘Rowling’, ‘J.K’,’China’),
(‘Tyrone’, ‘Edgar’, ’America’); 

INSERT INTO Contracts (contract_date ,expiration_date ,royalty_percentage) VALUES 
(‘1948-01-15’, ‘1970-01-15’, ’10.00’),
(‘1996-06-26’, ‘2025-05-24’, ’15.10’),
(‘200-05-30’, ‘2001-12-12’, ’12.50’);


Question 5 Queries: 
SELECT b.title, b.genre, a.firstname, a.lastname
FROM Books b
JOIN BookAuthors ba ON b.book_id = ba.book_id
JOIN Authors a ON ba.author_id = a.author_id;



SELECT firstname, lastname, country_origin 
FROM Authors
Where country_origin IN (‘China’, ‘America’);



SELECT 
    a.firstname,
    a.lastname,
    b.title,
    c.contract_date,
    c.royalty_percentage
FROM Authors a
JOIN Contracts c ON a.author_id = c.author_id
JOIN Books b ON c.book_id = b.book_id
WHERE c.royalty_percentage > 12.00
ORDER BY c.royalty_percentage DESC;
