--Insert the data in the table

insert into book_info values (1,'Basic Electrical','S K Bhattacharjo', 'Pearson', date '2001-01-01');
insert into book_info values (2,'Introduction to Automata','Hopcroft', 'Pearson', date '2001-07-01');
insert into book_info values (3,'Object Oriented Programming in C','E Balagurusamy', 'Mc Graw Hill', date '2017-07-01');
insert into book_info values (4,'Object Oriented Software Engineering','Timothy', 'Mc Graw Hill', date '2015-01-01');
insert into book_info values (5,'Data Structure ','Adam', 'Cengage Learning', date '2018-12-12');

insert into book_info values (6,'Algorithm in C','Robert', 'Pearson', date '2010-01-01');
insert into book_info values (7,'Machine Learning','Hasmat Malik', 'Springer', date '2010-01-01');
insert into book_info values (8,'Electrical Power','Mandeep Singh', 'Pearson', date '2009-01-01');
insert into book_info values (9,'Programmers Handbook','Hopcroft', 'Pearson', date '2001-01-01');
insert into book_info values (10,'Object Oriented Programming in C++','E Balagurusamy', 'Mc Graw Hill', date '2017-07-01');


insert into review_writer_info values ( 1, 'Shimu','shimu@gmail.com',123456);
insert into review_writer_info values ( 2, 'Sina','sina@gmail.com',123456);
insert into review_writer_info values ( 3, 'Turjo','turjo@gmail.com',123456);
insert into review_writer_info values ( 4, 'Shujoy','shujoy@gmail.com',123456);
insert into review_writer_info values ( 5, 'Eleus','eleus@gmail.com',123456);

insert into review_writer_info values ( 6, 'Hasib','hasib@gmail.com',456789);
insert into review_writer_info values ( 7, 'Nasib','nasib@gmail.com',456789);
insert into review_writer_info values ( 8, 'Abrar','abrar@gmail.com',456789);
insert into review_writer_info values ( 9, 'Rafi','rafi@gmail.com',456789);
insert into review_writer_info values ( 10, 'Nihal','nihal@gmail.com',456789);


insert into relation values( 11,1,1 );
insert into relation values( 12,1,1 );
insert into relation values( 13,2,1 );
insert into relation values( 14,3,2 );
insert into relation values( 15,3,2 );

insert into relation values( 16,4,3 );
insert into relation values( 17,5,5 );
insert into relation values( 18,6,5 );
insert into relation values( 19,6,6 );
insert into relation values( 20,6,7 );

insert into review_info values ( 11,date '2021-01-01','excellent' );
insert into review_info values ( 12,date '2022-01-01','good' );
insert into review_info values ( 13,date '2023-01-01','excellent' );
insert into review_info values ( 14,date '2019-01-01','very good' );
insert into review_info values ( 15,date '2018-01-01','Have a look on this book' );

insert into review_info values ( 16,date '2021-01-01','Highly suggested' );
insert into review_info values ( 17,date '2022-01-01','Good to read' );
insert into review_info values ( 18,date '2023-01-01','excellent' );
insert into review_info values ( 19,date '2019-01-01','good' );
insert into review_info values ( 20,date '2018-01-01','excellent' );






--Displaying table data using SELECT command
select * from book_info;
select * from book_info where publisher='Pearson';
select review_description,review_date from review_info where review_id = ( select review_id from relation where book_id = 4 );



--Updating the data in a table
update review_info set review_description = 'You can suggest other' where review_id = 19;



--Deleting row from a table
delete from review_info where review_id = 19;
insert into review_info values ( 19,date '2019-01-01','good' ); 



--union, intersect, and except
select book_id,book_name from book_info where book_name like 'O%' 
 union
select book_id,book_name from book_info where book_name like '%C'; 

select book_id,book_name from book_info where book_name like 'O%' 
 intersect
select book_id,book_name from book_info where book_name like '%C'; 


--With clause
--use a with clause to find the book whose publisher is 'Pearson'
with pub as ( select * from book_info where publisher='Pearson' )
select * from pub;


--use a with clause to find the book that has maximum number of reviews.
with no_of_review_table(no_of_review,book_id) as
( select count(book_id) , book_id from relation group by book_id )
select max(no_of_review) from no_of_review_table;


--use a with clause to find the book info of the book that has maximum no of review.
with no_of_review_table(no_of_review,book_id) as
( select count(book_id) , book_id from relation group by book_id ),
max_review_table(max_review) as
( select max(no_of_review) from no_of_review_table )
select * from no_of_review_table,max_review_table,book_info where no_of_review = max_review and no_of_review_table.book_id=book_info.book_id; 


--Group by
--find the number of reviews of each books.
select count(book_id) , book_id from relation group by book_id;


--Group by and Having
--find the number of reviews of each books that has review more than 1.
select count(book_id) , book_id from relation group by book_id having count(book_id)>1;


--Aggregate function
select count(*) from book_info;
select count(book_id) as number_of_book from book_info;
select count ( distinct publisher) from book_info;
select avg(book_id) from book_info;
select max(book_id) from book_info;
select min(book_id) from book_info;



--Nested subquery
--find the all review info of the book that has book_id 6;
select * from review_info where review_id in ( select review_id from relation where book_id=6 );


--Set Membership(AND, OR,NOT)
-- find the book info where author= E Balagurusamy and publisher = Mc Graw Hill
select * from book_info where book_author= 'E Balagurusamy' and publisher = 'Mc Graw Hill'


select * from review_info where review_id > some ( select review_id from relation where book_id>=3 );


--String operations
--find review writer info where writer name starts with s
select * from review_writer_info where rev_wr_name like 'S%';

--find review writer info where writer name length is five or six character
select * from review_writer_info where rev_wr_name like '_____' or rev_wr_name like'______';




--Join operations
select * from review_writer_info natural join relation where rev_wr_id =1;
select * from review_writer_info join relation using (rev_wr_id) where rev_wr_id =1;

select * from review_writer_info join relation on review_writer_info.rev_wr_id = relation.rev_wr_id where relation.rev_wr_id =1;

select *  from review_writer_info left outer join relation using (rev_wr_id);

select *  from review_writer_info right outer join relation using (rev_wr_id);

--drop view view1;
--drop view view2;

--View
create view view2 as select rev_wr_id,rev_wr_name from review_writer_info;
create view view1 as select rev_wr_id, review_id from review_writer_info natural join relation;

drop view view1;
drop view view2;





