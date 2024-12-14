-- select book id,book name ,book author of book id 2
set serveroutput on
declare
book_id BOOK_INFO.BOOK_ID%type;
book_name BOOK_INFO.BOOK_NAME%type;
book_author BOOK_INFO.BOOK_AUTHOR%type;
begin
select book_id,book_name,book_author into book_id,book_name,book_author from book_info where book_id=2;
dbms_output.put_line('id '||book_id||' name '||book_name||' author '||book_author);
end;
/

--Insert and set default value
set serveroutput on
declare
id REVIEW_WRITER_INFO.REV_WR_ID%type :=11;
name REVIEW_WRITER_INFO.REV_WR_NAME%type :='Jesiara';
email REVIEW_WRITER_INFO.REV_WR_EMAIL%type :='jesiara@gmail.com';
contact REVIEW_WRITER_INFO.REV_WR_CONTACT%type :='12345';
begin
insert into REVIEW_WRITER_INFO values(id,name,email,contact);
end;
/

--use of row type
set serveroutput on
declare
rev_wr_info REVIEW_WRITER_INFO%rowtype;
begin
select rev_wr_name,rev_wr_email into rev_wr_info.rev_wr_name,rev_wr_info.rev_wr_email from REVIEW_WRITER_INFO where rev_wr_id=1;
dbms_output.put_line(rev_wr_info.rev_wr_name||'    '||rev_wr_info.rev_wr_email);
end;
/

--Cursor and row count
set serveroutput on
declare
cursor c is select * from relation ;
r relation%rowtype;
begin
open c;
fetch c into r.review_id,r.book_id,r.rev_wr_id;

while c%found loop
dbms_output.put_line(r.review_id||'  '||r.book_id||'  '||r.rev_wr_id);
fetch c into r.review_id,r.book_id,r.rev_wr_id;
end loop;

close c;
end;
/

-- if elseif else
set serveroutput on
declare
id BOOK_INFO.BOOK_ID%type:=4;
name BOOK_INFO.BOOK_NAME%type;
begin
select book_name into name from book_info where book_id=id;
if name='Introduction to Automata' then 
dbms_output.put_line('if');
elsif name = 'Object Oriented Programming in C' then
dbms_output.put_line('elsif');
else
dbms_output.put_line('else');
end if;
end;
/

-- find review id and review writer id where book id =1 using procedure;

create or replace procedure proc1( var1 out review_info.review_id%type, var2 in book_info.book_id%type,
var3 out review_writer_info.rev_wr_id%type)
as 
begin
select review_id,rev_wr_id into var1,var3 from relation where book_id=var2;
end;
/

set serveroutput on
declare
var1 REVIEW_INFO.REVIEW_ID%type;
var2 BOOK_INFO.BOOK_ID%type:=2;
var3 REVIEW_WRITER_INFO.REV_WR_ID%type;
begin
proc1(var1,var2,var3);
dbms_output.put_line(var1||'  '||var2||'  '||var3);
end;
/


-- function
create or replace function func1(  var2 in book_info.book_id%type) return REVIEW_INFO.REVIEW_ID%type
as var3 REVIEW_INFO.REVIEW_ID%type;
begin
select review_id into var3 from relation where book_id=var2;
return var3;
end;
/

set serveroutput on
begin
dbms_output.put_line('review id is  '||func1('2'));
end;
/

-- drop
drop procedure proc1;
drop function func1;


-- array with extend
set serveroutput on
declare
name BOOK_INFO.BOOK_NAME%type;
counter number;
type namearray is varray(5) of BOOK_INFO.BOOK_NAME%type;
a_name namearray:= namearray();
begin
counter:=1;
for x in 2..6
loop
select  book_name into name from book_info where book_id =x;
a_name.extend();
a_name(counter):=name;
counter := counter +1;
end loop;
counter:=1;
while counter <=a_name.count
loop
dbms_output.put_line(a_name(counter));
counter:=counter+1;
end loop;
end;
/

--array without extend
set serveroutput on
declare
name BOOK_INFO.BOOK_NAME%type;
counter number;
type namearray is varray(5) of BOOK_INFO.BOOK_NAME%type;
a_name namearray:= namearray('a','b','c','d','e');
begin
counter:=1;
for x in 2..6
loop
select  book_name into name from book_info where book_id =x;
a_name(counter):=name;
counter := counter +1;
end loop;
counter:=1;
while counter <=a_name.count
loop
dbms_output.put_line(a_name(counter));
counter:=counter+1;
end loop;
end;
/





-- need to delete followings.

create table t1(
    name varchar(10),
    age int
);
create table t2(
    name varchar(10),
    age int
);


set serveroutput on
declare

type namearray is varray(5) of book_info.book_name%type;
a namearray:= namearray();
name BOOK_INFO.BOOK_NAME%type;
c number;
begin
c:=1;
for x in 2..6
loop 
select book_name into name from BOOK_INFO where book_id=x;
a.extend();
a(c):=name;
dbms_output.put_line('name is '||a(c));
c:=c+1;
end loop;

end;
/