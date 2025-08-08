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
select sysdate - to_date('1999-01-01','yyyy-mm-dd') 살아온날수 , months_between(sysdate,to_date('1992-9-8','yyyy-mm-dd'))as 살아온월수 from dual

--날짜 년도 반올림
select to_char(round(to_date('2011-09-11 21:00:01',
                             'rrrr-mm-dd hh24:mi:ss'), 'year'),
               'rrrr-mm-dd hh24:mi:ss')  
  from dual;

--  날짜 시간기준 반올림
  select to_char(round(to_date('2011-06-31 21:00:01',
                             'rrrr-mm-dd hh24:mi:ss')), 
               'rrrr-mm-dd hh24:mi:ss')   
  from dual;
 
  
  
--  문제 1) 사원테이블에서 아래 내용을 조회
--  	sabun saname  sajob  sahire  근속(총)월수 근속년수 근속잔여월수
  	
  	select sabun, saname, sajob, sahire, floor(months_between(sysdate,sahire)) as "근속(총)월수" ,floor(months_between(sysdate,sahire)/12) as "근속년수",floor(mod(months_between(sysdate,sahire),12)) as 근속잔여월수 from sawon
  	
  	
  	select floor(months_between(sysdate,sahire)) from sawon
  	
  	/* 연습
  	select sabun,saname,sajob,sahire,floor(months_between(sysdate, sahire)) as "근속(총)월수" ,floor(months_between(sysdate,sahire)/12) as "근속(총)년수",floor(mod(months_between(sysdate,sahire),12)) as "근속 잔여월수" from sawon
  	
  	select floor(months_between(sysdate, sahire)) as "근속(총)월수" from sawon
  	select floor(months_between(sysdate,sahire)/12) as "근속(총)년수" from sawon
  	select months_between(sysdate,sahire)/12 as "근속(총)년수" from sawon
  	select floor(mod(months_between(sysdate,sahire),12)) as "근속 잔여월수" from sawon
  	
  	select saname,sahire from sawon where sajob ='부장' 
  	--부장중에 이름. 입사날짜
  	-- 2000년 입사한 사람중에 이름과 입사날짜 직급
  	select saname,sapay,sajob from sawon  where sapay >= 3000  
  	select * from sawon
  	*/
  	
  	select 3 컬럼
  	from 1 테이블명
  	where 2 조건
  	order by 4 정렬
  	
 /*변환함수*/
-- ###숫자를 문자로 변환
-- 콤마 예제
select to_char(123456781111111,'999,999,999,999,999') comma from dual;
 
-- 소숫점 예제  
select to_char(123.45678,'999,999,999.99') period from dual; 
 
-- $ 표시 예제
select to_char(12345678,'$999,999,999') dollar  from dual;
 
-- local 화폐 표시 예제 (한국의 경우 ￦로 자동 변환 됨)
select to_char(12345678,'l999,999,999') local  from dual;
 
-- 왼쪽에 0을 삽입
select to_char(123,'09999') zero from dual;  
 
-- 16진수로 변환
select to_char(123,'xxxx') hexadecimal  from dual;
  
  	
-- ###날짜를 문자로 변환
-- 년,월,일,시,분,초 예제
select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') "sysdate" from dual;
 
-- 365일 중 몇 일째인지 조회
select to_char(sysdate, 'ddd') "day of year" from dual;
 
-- 53주 중 몇 주차 인지 조회
select to_char(sysdate, 'iw') "week of year" from dual;
 
-- 해당 월의 이름 조회
select to_char(sysdate, 'month') "name of month" from dual;

-- ###문자 -> 날짜형으로 변환
-- DATE 타입으로 변환하는 예제
SELECT '2011-01-01 00:00:00' FROM DUAL; -- char형이다
SELECT TO_DATE('2011-01-01 12:35:50','RRRR-MM-DD HH24:MI:SS:') FROM DUAL;
SELECT to_char(TO_DATE('2011-01-01 12:35:50','RRRR-MM-DD HH24:MI:SS:'),'rrrr-mm-dd Hh24:mi:ss') FROM DUAL;
--시간 설정을 안하면 초기값 00:00:00 으로 나온다.
SELECT to_char(TO_DATE('2011-01-02 ','RRRR-MM-DD HH24:MI:SS:'),'rrrr-mm-dd Hh24:mi:ss') FROM DUAL;


-- 문자를 숫자로 변환하는 간단한 예제이다.
SELECT TO_NUMBER('01210616') FROM DUAL; 