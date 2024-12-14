

drop table review_info;
drop table relation;
drop table book_info;
drop table review_writer_info;

create table book_info(
  book_id number(20),
  book_name varchar(50),
  book_author varchar(50),
  publisher varchar(50),
  publish_date date,
  primary key(book_id)
  );

create table review_writer_info(
  rev_wr_id number(20),
  rev_wr_name varchar(50),
  rev_wr_email varchar(50),
  rev_wr_contact number(20),
  primary key(rev_wr_id)
  );

create table relation(
  review_id number(20),
  book_id number(20),
  rev_wr_id number(20),
  primary key(review_id),
  foreign key(book_id) references book_info(book_id),
  foreign key(rev_wr_id) references review_writer_info(rev_wr_id)
  );

create table review_info(
  review_id number(20),
  review_date date,
  review_description varchar(1000),
  primary key(review_id),
  foreign key( review_id) references relation(review_id)
  );







--Add column in the table
alter table book_info add edition varchar(20);

--Modify column definition in the table
alter table book_info modify edition number(25);

--Rename the column name
alter table book_info rename column edition to book_edition;

--Drop the column from table
alter table book_info drop column book_edition;


