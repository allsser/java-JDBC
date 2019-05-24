

select * from tab;
--table 생성
drop table book; -- table 삭제
create table book(  
 	bookno number(5),
 	title varchar2(12),
 	author varchar2(12),
 	pubdate date
);
 
 create table book(  
 	bookno number(5),
 	title varchar2(12),
 	author varchar2(12),
 	pubdate date
);

commit;
rollback;
select * from book;
--데이터 집어넣기
insert into book values(1,'java','kim',sysdate);
insert into book values(1,'java','kim',sysdate);
insert into book values(2,null,null,'19/05/15');


--이렇게 컬럼 기술해주고 데이터 삽입도 가능
insert into book (bookno,title,author,pubdate) 
			values(3,'SQL','lee',null);
			
--컬럼 기술 3개 해줬으면 values에도 3개 맞춰 넣어주면 언급 안된 컬럼은 알아서 null이 삽입됨
insert into book (bookno,title,author) 
			values(4,'db','java01');
			
			
--작가 없는 date 지우기
delete from book where title is null;
--kim인 저자 다 지우고 싶어요
delete from book where author = 'kim';
	
-- price 컬럼 추가 하는 명령어. (number 타입 들어올거고 자리수는 7)
alter table book add(price number(7));
			

insert into book values(5,default,default,default,default);
--update구문써보기(price에 다 0값넣을겨)

update book set price=null;
--이거 날리면 n(정수) rows updated; 라고 뜸.
-- update/delete/~ = return 값은 정수값.
-- 하지만 select구조 의 리턴값은?


update book set price=10,title='jsp' where bookno=3;
alter table book modify(price number(7,2));			


--불필요한 컬럼 삭제
alter table book drop column price;					
			
rename book to book2;
			
--booktable 에 있는 아이 다지워(rollback가능)
delete from book;
--자르기(rookback불가)
truncate table book;
drop table book;
			
			
select * from emp;
select * from dept;


--테이블 만드는 또다른 방법! (emp2는 emp의 복사본이됨)
create table emp2
 as select * from emp;
			
create table emp3
 as select * from emp where deptno =10;			
			
--dept 테이블 생성
create table dept2
 as select * from dept;		

 alter table dept add(othername number(7));
 
insert into dept values(50,'dohyun','korea',50 );
insert into dept values(50,'java','korea',50 );		
alter table dept drop column othername;	


--이거 dept에 넣으면 에러!!!!!!!!!!! 제약조건에 걸림
insert into dept values(50,'edu','korea' );
insert into dept values(50,'edu','korea');		

--이거 dept2에 넣으면 에러 x! = 복사 할때 구조~만복사하고 제약조건은 복사x함
insert into dept values(50,'edu','korea' );



-- pubdate 요아이는 date 인데 defualt 박아둘거햐 & CONSTRAINT :제약조건 거는 구문/
-- book_pk 이 이름을 줄 때는 내가 사용하는 영역에서 없다는 보장을 받아야함(제약조건 이름 부여한거임)
-- book_title_notnull unique:절대 중복 불허할거임
--CONSTRAINT check(price>0) : 음수절대불허
--CONSTRAINT book_author_notnull not null: 절대불허
drop table book;
create table book(
	bookno number(5) CONSTRAINT scott_book_pk primary key,
	title varchar2(12)CONSTRAINT book_title_unique unique,
	author varchar2(12),
	price number(5)CONSTRAINT book_price_ check(price>0),
	pubdate date default sysdate;
);
--sysdaye: default값 설정함.


insert into book (bookno, title, author, price, pubdate)
			values(1, 'mydiary', 'dohyunlee',9000,sysdate);

insert into book (bookno, title, author, price, pubdate)
			values(2, 'mydiary1', 'dohyunlee',9000,sysdate);


insert into book (bookno, title, author, price, pubdate)
			values(4, 'java3','kim',9000,default);
			
insert into book (bookno, title,  price)
			values(5, 'java5',9000);

--제약조건 이름확인하는 select구문
select CONSTRAINT_name from user_cons_columns;


--book table 제약조건 확인하는 select구문
select CONSTRAINT_name
from user_cons_columns
where table_name='BOOK';

--book table지우기
drop table book;

--휴지통 비우기
purge recyclebin;





--강제삭제 하는법
drop table book cascade CONSTRAINT;

create table book(
	bookno number(5) primary key,
	title varchar2(12) unique,
	author varchar2(12),
	price number(5) check(price>0),
	pubdate date default sysdate
);

insert into book (bookno, title, price)
			values(5, 'java5',9000);

--primary key지워서 중복 허용함
create table book(
	bookno number(5) ,
	title varchar2(12) unique,
	author varchar2(12),
	price number(5) check(price>0),
	pubdate date default sysdate
);

--위에 create한 book table에다가  bookno column에 scott_book_pk 라고 이름 부여한 primarny key 조건넣기.
alter table book add CONSTRAINT scott_bookno_pk primary key(bookno);
alter table book drop CONSTRAINT scott_bookno_pk;

drop table dept2;

--제일 중요한 관계설정 하기~!!!!!!
--dept2 table 에 

create table dept2
	as select * from dept;
-- dept2 테이블에 deptno 컬럼에 pk설정
alter table dept2 add CONSTRAINT dept2_deptno_pk primary key(deptno);


	
create table emp2
as select* from emp;
--emp2테이블에 empno 컬럼에 pk설정
alter table emp2 add CONSTRAINT emp2_empno_pk primary key(empno);


--emp2테이블에 mgr 컬럼에 fk설정
alter table emp2 add foregin CONSTRAINT emp2_mgr_fk key(mgr) references dept2;


p265 참조  세개 이상의 테이블 안시조인 결합
select *
from emp
     join dept
     on emp.deptno=dept.deptno
     join salgrade
     on sal between losal and hisal ;

     
 --- table(3개 이상 안시조인 한) 쉽게 보기 위해 가상의 table만들어 보는 법  view!
create or replace view emp_detail
as
select ename, dname, sal, grade
from emp
     join dept
     on emp.deptno=dept.deptno
     join salgrade
     on sal between losal and hisal ;

     
 --위에 저거 선언 하고 밑에 처럼 쓰면 3개엮은 테이블 한줄에 보기 가능!!!
select * from emp_detail;
--보통 view들은 조인 걸린 확률 높고
--좋인 걸린 view들은 insert보기 불가능
--view는 그냥 view로 쓰자^^
-- view를 쓰므로써 테이블안에 민감한 data들을 보안할 수 있음


복수 키로 primary key 가능

create table book(
ssn1 number(6),
ssn2 number(7),
primary key (ssn1,ssn2)
);

--ssn1, ssn2 둘다 프라이머리 키 로 쓰임!


--삭제도 가능
drop view emp_detail; 



----insert into 테이블이름 values(~~) 말고 이런 형태의 sub쿼리 insert가능
insert into dept2
		select deptno, dname
		from dept
		where loc = 'NEW YORK';
		
--update구문을 subqurry를 이용해 할 수 ㅇ써!!!
--담당업무가 scott과 같은 사람들의 월급을 부서 최고 액으로 변경
update emp SET sal = (select max(sal) from emp)
where job=
(select job ~~~~~~~~~~~~);


--딜ㄹ리트도 섭쿼리가능

DELETE FROM emp
WHERE deptno = (SELECT deptno FROM dept
				WHERE dname = 'SALES')	;
				
update emp set sal= sal*1.1 where deptno=10;

--sequence생성(번호제조기, 이름은 bookno로)
create sequence bookno;

insert into book (bookno,title,price) values(bookno.nextval,'sql2d4',7000);
---------
--bookno가 몇번까지 갔는지 보래
select bookno.currval from dual;


--시퀀스 지우고싶어요
drop sequence bookno;

create table book(
	bookno number(5) ,
	title varchar2(12),
	author varchar2(12),
	price number(5) check(price>0),
	pubdate date default sysdate
);

--여기서 subqurry문 안쓰고 넘버링 가능한 함수 고민해서 그 함수 써서 해봐라


insert into book(bookno,title,price)
values(bookno.nextval,'sql18',7000);

select bookno.currval from dual;

insert into book(bookno,title,price)
values((select nvl(max(bookno,0)+1)from book),'spring',7000);

select nvl(max(bookno,0)) from book;
update emp set sal from 

set autotrace on
select * from book where title='sql2d4';

--title 기준으로 검색 속도 빠르게
create index book_title on book(title);
drop index book_title 


