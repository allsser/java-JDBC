Select employee_id, first_name, department_name, jobs.first_name
From employees, departments, jobs
Where job_title like ’%manager%’;

Select *
From employees, departments, jobs
Where upper (job_title) = upper(’manager’);


select * from employees;

select * from departments;
--1
SELECT e.employee_id "사번", e.first_name "사원 이름", d.department_name "업무 장소", m.first_name "매니저 이름"
FROM employees e, employees m, departments d
WHERE e.department_id = d.department_id
		AND e.manager_id = m.employee_id;
		
--2
Select e.last_name, e.salary
from employees e,employees m, departments d
where e.department_id = d.department_id
and e.manager_id = m.employee_id
and e.salary>m.salary;


--3
select e.first_name, e.last_name , e.salary
from employees e,  jobs j
where j.job_id= e.job_id
and lower(j.job_title) = lower'Sales Representative' --lower로 감싸주기
and (salary>=9000 or salary<=10000);


--4
select e.employee_id , e.last_name, e.hire_date
from employees e, employees m
where e.manager_id = m.employee_id
and e.hire_date <m.hire_date;


--5
select DISTINCT job_title, department_name
from employees e,departments d,jobs j
where e.department_id = d.department_id
and (e.job_id = j.job_id)
order by job_title;

--6
select to_char(hire_date, 'mm')"월",to_char(count(*)) "입사자수" --count 하고 to_char변환 해야 왼쪽 정렬됨.
from employees e
group by to_char(hire_date, 'mm')
order by to_char(hire_date, 'mm');

select to_char(hire_date, 'mm')"월",count(to_char(hire_date, 'mm')) "입사자수" 
from employees e
group by to_char(hire_date, 'mm')
order by "월";

--7
select e.first_name, e.hire_date, m.employee_id, m.first_name
from employees e left join employees m
on m.employee_id = e.manager_id
where to_char(e.hire_date, 'yy')= 08;

--8
select e.first_name, e.salary, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and d.department_name = 'Sales';

--9
select e.employee_id, e.first_name, e.last_name, nvl(d.department_name, '<<NOT ASSIGEND>>')
from employees e left join departments d
on e.department_id = d.department_id
where to_char(e.hire_date, 'yyyy')= 2008;

--10
select e.first_name, e.hire_date, m.employee_id, m.first_name
from employees e left join departments d
on e.department_id=d.department_id
where to_char(e.hire_date, 'yy') like '198_';

		