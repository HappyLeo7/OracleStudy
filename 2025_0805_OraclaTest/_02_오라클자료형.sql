-- 오라클 자료형
-- 1. 문자형 자료형
char : 고정형
varchar2 : 가변형

create table t1
(
	meo1 char(1000),
	memo2 varchar2(1000),
)
-- 				(1000바이트,2바이트)
insert into t1 values('hi','hi')

-- 2. 숫자형 자료형(가변형)
 	int  	  : number(38) 동일함
	number(n) : 정수 자릿수 지정
	number(p,s) precision(전체자릿수) scale(소수점자릿수)
	
-- 3. 날짜형자료형
--	  date : 년월일시분초
--    sysdate : 현재시스템날짜구하는 함수
--	  dual : 임시 테이블
	
	select sysdate from dual --년 월 일
	select to_char(sysdate, 'YYYY-mm-dd HH24:mi:ss')from dual
	select 1+1 from dual
	
-- 4. LOB(Large Object)
--	  BLOB(binary Large Object) : 2진형식
--	  CLOB(character Large Object) : text형식
	