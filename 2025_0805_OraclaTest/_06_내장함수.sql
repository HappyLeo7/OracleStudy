ctrl + shift + x : 대문자
ctrl + shift + y : 소문자


--###문자열 함수
--			   1234567890  오라클sql 에서 substr은 인덱스가 1부터 시작
select substr('oracleclub',3)name from dual;

select substr('oracleclub',3,4)name from dual;
--			  -0987654321
select substr('oracleclub',-3,2)name from dual;


--###날짜형 함수
select to_char(sysdate,'rrrr-mm-dd hh24:mi:ss') "지금시간"
  from dual ;
 
select to_char(sysdate-1,'rrrr-mm-dd hh24:mi:ss') "하루전지금시간"
  from dual ;
 
select to_char(sysdate-1/24,'rrrr-mm-dd hh24:mi:ss') "1시간전시간"
  from dual ;
 
select to_char(sysdate-1/24/60,'rrrr-mm-dd hh24:mi:ss') "1분전시간"
  from dual ;
 
select to_char(sysdate-1/24/60/10,'rrrr-mm-dd hh24:mi:ss') "6초전시간"
  from dual ;
 
select to_char(sysdate-(5/24 + 30/24/60 + 10/24/60/60),'rrrr-mm-dd hh24:mi:ss') "5시간 30분 10초전"
  from dual ;
  

--입대일자 / 전역일자
select sysdate , add_months(sysdate,18) as 전역일자 from dual

--살아온 일수 / 월수
select sysdate -to_date('1999-01-01','yyyy-mm-dd') 살아온날수 , months_between(sysdate,to_date('1992-9-8','yyyy-mm-dd'))as 살아온월수 from dual

--날짜 년도 반올림
SELECT TO_CHAR(ROUND(TO_DATE('2011-09-11 21:00:01',
                             'RRRR-MM-DD HH24:MI:SS'), 'YEAR'),
               'RRRR-MM-DD HH24:MI:SS')  
  FROM DUAL;

--  날짜 시간기준 반올림
  SELECT TO_CHAR(ROUND(TO_DATE('2011-06-31 21:00:01',
                             'RRRR-MM-DD HH24:MI:SS')), 
               'RRRR-MM-DD HH24:MI:SS')   
  FROM DUAL;
 
  
  
  문제 1) 사원테이블에서 아래 내용을 조회
  	sabun saname  sajob  sahire  근속(총)월수 근속년수 근속잔여월수
  	
  	select sabun, saname, sajob, sahire, floor(months_between(sysdate,sahire)) as "근속(총)월수" ,floor(months_between(sysdate,sahire)/12) as "근속년수",mod(floor(months_between(sysdate,sahire)),12) as 근속잔여월수 from sawon
  	
  	select floor(months_between(sysdate,sahire)) from sawon