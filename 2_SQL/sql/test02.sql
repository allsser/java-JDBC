create table users(
	id varchar2(12) primary key,
	password varchar2(12),
	name varchar2(12),
	role varchar2(12)
	);
	
	create table board(
	seq number(6) primary key,
	title varchar2(12),
	content varchar2(12),
	regdate date default sysdate ,
	cnt number(6)default 0,
	userid varchar2(12) CONSTRAINT board_userid_fk REFERENCES users
	);
--	
create sequence seq;
insert into board (seq) values(board.nextval);
--
alter table board add CONSTRAINT board_userid_fk foreign key(userid);

회원등록 
insert into users values('multicampus1','java','kim',?);	
--

insert into users (id,password,name) 
			values('multicampus1','java','kim');
insert into users (id,password,name) 
			values('multicampus2','java','lee');
insert into users (id,password,name) 
			values('multicampus3','java','hwang');
insert into users (id,password,name) 
			values('multicampus4','java','jung');
insert into users (id,password,name) 
			values('ehsehs90','j12','kim');
insert into users (id,password,name) 
			values('multicampus5','j12','park');
insert into users (id,password,name) 
			values('multicampus6','j12','park');
회원정보수정 -
update users set role='user';
update users set role='admin' where name='kim';	
update users set role='user' where name ='park';
--
update users SET password=(select name='park' from users)'oracle';
--
로그인-
if('입력받은 id'.equals(users.id) && '입력받는 password'.equals(users.password))
    return UNIQUE 키값
else
    return '로그인 실패'

게시판글등록 
create sequence seq;
insert into board (seq) values(seq.nextval);


insert into board (seq,title,content,regdate,userid)
	values(seq.nextval,'java','howtodo','19/05/15','multicampus1');
insert into board (title,content,regdate,userid)
	values('sql','howtodo','19/05/15','multicampus3');
insert into board (title,content,regdate,userid)
	values('html','howtodo','19/05/15','multicampus2');
insert into board (title,content,regdate,userid)
	values('sql','chapter1','19/04/15','multicampus3');
insert into board (title,content,regdate,userid)
	values('java1','chapter1','19/03/15','multicampus3');
insert into board (title,content,regdate,userid)
	values('sql','chapter1','19/07/15','multicampus3');
insert into board (title,content,regdate,userid)
	values('sql','chapter1','19/08/15','multicampus10');
insert into board (title,content,regdate,userid)
	values('sql','chapter1','19/12/15','multicampus5');
insert into board (title,content,regdate,userid)
	values('sql','chapter1','19/12/15','multicampus4');
글수정
update board set content='homework' where userid='multicampus2'
update board set title='javalanguage' where userid='multicampus2'

게시판 글 삭제

데이터검색(Query)
select content from board

전체 등록글 수 select* from all_board;

create or replace view all_board
as
select title, regdate
from board
     join users
     on users.id=board.userid;


사용자별 등록글수 
select seq  from board  where userid = 'multicampus1'

select count(userid),userid, 
from board,
group by userid,
order by userid;

월별게시글수 
select to_char(regdate,'mm'), to_char(count(*))
from board 
group by to_char(regdate, 'mm')
order by to_char(regdate, 'mm');


사용자별 게시글 검색 select userid from board where userid='multicampus1'

제목으로 게시글 검색 select title from board where title='null';


drop table board;
drop table users; --지우는 순서/생성하는 순서 유념하기.

--5/16
--primary key로 적절 한건 id
create table users (
	id       varchar2(8) primary key,
	password varchar2(8)not null,
	name     varchar2(15)not null,
	role     varchar2(8) default'user'--일반적으로 사용자는user니까 디폴트갑승로 설정
);

create table board(
	seq		number(5)     primary key,--일련의 번호로 1,2,3,4,5 부여할 때 적절한 데이터 타입:number
	title   varchar2(15)   not null,
	contant varchar2(30)   not null,
	regdate date          default sysdate, --날짜에 대해 언급하지 않으면 등록할 때의 날짜임.
	cnt 	number(5)     default 0,--조회 횟수 처음에 아무도 안읽으면 0이니까 default 0으로 설정
	id		varchar2(8)   references users --users테이블에 레퍼런싱 할거임. 그럼 users의 primary key로 자동레퍼런싱.
);



회원등록
insert into users (id,password,name) values('','','');--아주 기본적인 회원등록 포멧
insert into users (id,password,name) values('java01','1234','홍길동');

insert into users (id,password,name,role)
	values('admin','1234','admin','admin');

commit; -- 커밋 날리면 

게시판 글 등록
--seq다루기 위해 sub쿼리문 사용// seq가 1도 없는 게시판도 있는 경우를 고려함(0고려)^^
--만들고 나서 test과정 꼭 거쳐야 함 : 내가만든 제약조건들에 의도대로 잘 걸리고 있는지 확인해야함
insert into board (seq,title,contant,id) --regdate,cnt 는 언급 안해도 됨(default값 설정 되기도 했고)
	values((select nvl(max(seq),0)+1 from board),'공지사항','----','admin');

insert into board (seq,title,contant,id) --regdate,cnt 는 언급 안해도 됨(default값 설정 되기도 했고)
	values((select nvl(max(seq),0)+1 from board),'등업해요','----','java01');

insert into board (seq,title,contant,id) --regdate,cnt 는 언급 안해도 됨(default값 설정 되기도 했고)
	values((select nvl(max(seq),0)+1 from board),'등업해요2','----','java01');

	
	
select * from board;

내가 쓴 글 확인하기
--내가 쓴 글 확인하기 (조건문 들어가야하는거 catch)
--이 아이는 리턴타입이 0 or 1 or 여러개니까 여러개일경우 collection으로 관리 들어가야함.
select * from board where id='java01';

--seq는 primary key이므로 결과는 0또는 1이된다
select * from board where seq=1;


월 별 게시글 수 확인하기
--월별이니까 group by 인거 캐치.
-- group by이니까 *는 사용 못함
--월별이니까 집계함수 사용가능 - count
select to_char(regdate, 'mm'),count(*) 
from board group by to_char(regdate,'mm');

글 삭제--조건절이 올거라고 생각해
delete 


글 수정
-- (users)id세팅은 다시하면 안됨/비밀번호 수정정도만 바꾸기 가능할거라고 생각해
-- (board table) 글번호는 수정 안됨/ 글title/ content정도만 바꾸기 가능할거라 생각해
update




로그인
select * from users where id='' and password='';
select * from users where id='java01' and password='1234'; --로그인 성공
select * from users where id='admin' and password='0000'; --로그인 실패











