select  * from DEPARTMENTS;
select empno,ename,job,hiredate,dept from emp;

사원이름 , job,급여,comm
select ename  사원명,job  "업 무",sal  급____여, comm  수당 from emp; 

select distinct job from emp;
select ename,sal,sal*12 as 연봉 from emp;
select ename,sal,comm,sal+comm from emp; //null은 계산해도 null

select ename,sal,nvl(comm,0) from emp;
select ename,sal,sal+nvl(comm,0) from emp;

select ename,mgr from emp;
select ename,nvl(mgr,0) from emp;
select ename,nvl(to_char(mgr),'없음') from emp;
select ename,nvl(to_char(mgr),'없음')as 매니져 from emp;

alter table<employees>drop<id>;

select ename, mgr,'sql' from emp;
select ename,sal,comm,sal+nvl(comm,0) as 지급액,'원' from emp;
select ename,sal,comm,sal+nvl(comm,0)||'원' as 지급액 from emp; //파이프기호 - 연결연산자
-- 이게 주석임.....

select goods_name, sell_price,sell_price*2 as "sell_price_*2" from goods

비교연산자
select good_name, good_classify from goods where sell_price = 500;

select ename,job,hiredate,deptno from emp;
select ename||job||hiredate,deptno from emp;
select goods}_name, buy_price from goods where buy_price is not null;
select goods_classfiy, sell_price from goods where goods_classify='주방용품' and sell_price >=3000;
select goods_name, goods_classify, register_date from goods where goods_classify = '사무용품'


select sysdate from emp; //지금 현재 날짜정보
select sysdate from dept;
select sysdate from dual;
select sysdate,3+7+8 from dual;

select goods_id, goods_name, buy_price from goods;
select '상품' ㅁㄴ munja, 38 as num, '20001-r-3-2' as nalja, from goods;
select goods_classify from goods where goods_classify = '의류';

select * from emp;
select * from emp where sal>3000;
select * from emp where job='MANAGER';
select * from emp where job=upper ('manager'); //이렇게 쓰면 절대 안된데... job도 어퍼로 에워 싸야함.(양쪽을같이바꿔)
select * from emp where upper (job)=upper ('manager');

select * from emp where hiredate > '81/05/01';
select * from emp where sal >=2000 and sal<=3000;
select * from emp where sal between 3000 and 5000;           o
select * from emp where sal not between 3000 and 5000;
select * from emp where sal between 5000 and 3000; //결과값안나옴 x
select * from emp where deptno=10;
select * from emp where deptno=10 or deptno=20;
select * from emp where deptno in(10,20); //in연산자
select * from emp where deptno not in(10,20);
select * from emp where deptno <> all(10,20);

select*from dept;
select*from dept where deptno=20 and loc='DALLAS' ;
select*from dept where deptno=30 and loc='CHICAGO' ;

select*from dept where (deptno=20 and loc='DALLAS') or (deptno=30 and loc='CHICAGO');
select*from dept where (deptno,loc) in ( (20 , 'DALLAS') , (30 ,'CHICAGO'));

select*from emp where ename ='KING';
select*from emp where job like 'S%'; //s로 시작하는 job찾기
select*from emp where ename like '%M%'; //M들어가는거 다찾아

select*from emp where upper(ename) like '%'||upper('m')||'%'; //대소문자 구분짓지말고 다다다다

select * from emp where deptno !=10 or deptno!=20;

select*from emp where hiredate like  '82%'; //82년도 입사한 사람
select*from emp where hiredate between '82/01/01' and '82/12/31';  //82년도 입사한 사람 표현2


select*from emp where comm is null; //null비교는 is연산자 사용.
select*from emp where comm is not null;


select*from emp order by deptno;  //정렬할때
select*from emp order by deptno desc; //내림차순
select*from emp order by 1; //위치인덱스 기반으로도 정렬 가능(첫번째=dempno)
select*from emp order by 5; //(다섯번째-hiredate)
select*from emp order by 5,deptno;

select ename,sal,comm,sal+nvl(comm,0) as total from emp;
select ename,sal,comm,sal+nvl(comm,0) as total 
from emp
where total>3000; //total인식못하고 있음 -얼라이언스 되고 있기 때문에.. 이거 안됨 where에는

해결책
select ename,sal,comm,sal+nvl(comm,0) as total 
from emp
where sal+nvl(comm,0)>3000;  //그대로 갖다 쓰삼
//해결책2
select ename,sal,comm,sal+nvl(comm,0) as total 
from emp
where sal+nvl(comm,0)>3000
order by total;


**변환 함수

문자->문자열 TO_NUMBER()
문자열 -> DATE TO_DATE()

select sysdate from dual; //날짜정보 출력
select sysdate,to_char(sysdate,'MM') from dual; //문자열 변환  뽑을것만 뽑자.....
select sysdate,to_char(sysdate,'YYYY') from dual
select sysdate,to_char(sysdate,'YY') from dual

select to_char(hiredate,'MM') from emp;  //emp에서 hiredate mm기준뽑아
select to_char(hiredate,'day') from emp;

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),
1300,NULL,10);



insert into emp values(9999,'java01','CLERK',7782,sysdate,900,null,10);
select*from emp;

insert into emp values(9999,'java01','CLERK',7782,'19/05/13',900,null,10);

insert into emp values(9999,'java01','CLERK',7782,'05/13/19',900,null,10);//날짜로 컨버팅하다 실패.
//이렇게 알려줘야함
insert into emp values(9999,'java01','CLERK',7782,to_date('05/13/19','mm/dd/yy'),900,null,10);
rollback; //insert 취소하는 명령어
