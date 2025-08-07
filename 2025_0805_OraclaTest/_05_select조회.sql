/*
	
	
 */
--	1. heading : 조회된 결과의 컬럼명(column)명  : as 명령어를 쓰고 뒤에 컬럼이름설정
	select
--	*
--	sabun,saname,sapay -- 부르고자하는 컬럼
	sabun as 사번, --heading : as를 붙여서도 쓸수있고
	sapay 연봉, --heading : as를 붙이지 않고도 사용가능
	sapay*0.1 as 보너스, --heading : 연산하여서 사용
	sapay/12   월급여, 
	round(sapay/12) 월급여2, --round 반올림
	floor(sapay/12*0.09) as "의료 보험료" --띄어쓰기를 쓰고싶을땐 " " 안에 넣으면 문자로 인식한다. // floor 소수점에 있는거 버리기 (작은정수를 선택함)
--	from dept
	from sawon --from 뒤에는 테이블명
--  where 1=1 -- 절 생략시 모든 데이터(조건부)
--	where deptno >20

--	2. 문자열 연산
--	|| : 문자열 결합연산자
--	concat(문자열1,문자열2)
	
	select '우리나라' 나라 , '대한민국'from dual
	select '우리나라'|| '대한민국' from dual
	select concat('우리나라','대한민국') from dual
	
	select saname||' 승진' from sawon
	select concat(saname,'님 여름휴가 잘 다녀오세요') from sawon
	
	select * from sawon
--	1) 사원 테이블에서 10번 부서직원만 조회 : where 을 이용하면 해당되는 행 정보를 가져올수 있다.
	select * from sawon where deptno=10
	
--	2) 사원 테이블에서 여자직원 조회
	select * from sawon where sasex='여자'
	
--	3) 사원테이블에서 10번부서의 여자직원 조회 : 여러개의 조건일떄는 and를 쓴다
	select * from sawon where deptno=10 and sasex='여자'
	
--	4) 사원테이블에서 직급이 과장, 대리 조회
	select * from sawon where sajob='과장' or sajob='대리';
	select * from sawon where sajob in('과장','대리');
	
--	5) 사원테이블에서 급여가 3500이상인 직원 조회
	select * from sawon where sapay >= 3500
	select * from sawon where 3500 <= sapay
	
--	6) 사원테이블에서 급여가 3500 ~ 4000인 직원 조회
	select * from sawon where 3500 <= sapay and sapay <= 4000
	select * from sawon where sapay between 3500 and 4000
	
--	7) 사원테이블에서 2000년도 이후에 입사한 직원 조회
	select * from sawon where sahire >= '2000-1-1'
	select * from sawon where sahire >= '2000-01-01'
	
--	8) 사원테이블에서 2000 ~ 2003년 입사한 직원 조회
	select * from sawon where sahire >='2000-01-01' and sahire <= '2003-12-31'
	select * from sawon where sahire between '2000-01-01' and '2003-12-31'
	
--	업데이트 해서 날짜수정
	update sawon set sahire = to_date('2003-12-31 00:00:01','YYYY-mm-dd HH24:mi:ss')where sabun = 18
	select * from sawon where sahire >='2000-01-01' and sahire < '2004-01-01'
	select * from sawon where sahire >=to_date('2000-01-01 00:00:00','yyyy-mm-dd HH24:mi:ss') and sahire <= to_date('2003-12-31 23:59:59','yyyy-mm-dd HH24:mi:ss')
	select * from sawon where sahire >='2000-01-01' and sahire <'2004-01-01'
	
--	년도만 가지고 조회해오기
	select * from sawon where to_number(to_char(sahire,'yyyy')) between 2000 and 2003
	
	select 
		sysdate, --현재시스템 정보
		to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')
		,to_char(sysdate,'yyyy') as 년도
		,to_char(sysdate,'mm') month
		,tO_number(to_char(sysdate,'mm')) month2
		,to_char(sysdate,'dd') 일
		,to_char(sysdate,'mi') 분
		,to_number('08') as "문자를 숫자로"
	from dual; 
	
--	9) 사원테이블에서 7월에 입사한 직원 조회
--	SQL(Structured Query Languasge)
--				 질의(묻다)  언어
	select to_char(sahire,'mm') from sawon where to_char(sahire,'mm')='07'
	select to_char(sahire,'mm') from sawon where to_char(sahire,'mm')=7 -- 이렇게 써도 to_number(to_char(sahire,'mm')) 처리를 해줘서 원하는 결과를 얻을수 있지만 지양해야한다. 
	
	select * from sawon where to_number(to_char(sahire,'mm'))=7 ;
	select saname from sawon where sajob='대리' and to_number(to_char(sahire,'mm'))=3

--	10) 사원테이블에서 봄(3~5)에 입사한 직원 조회
	select * from sawon where to_number(to_char(sahire,'mm')) >= 3 and to_number(to_char(sahire,'mm')) <= 5
	select * from sawon where to_number(to_char(sahire,'mm')) between 3 and 5
	select * from sawon where to_number(to_char(sahire,'mm')) in(3,4,5)
	
--	### 문자열 유사검색식
--		필드 like '%_'
--		
--		% : 모든문자(1..n)
--		_ : 모든문자(1문자)
--	11) 사원테이블에서 '이'씨 성씨를 갖는 사원 조회
	select * from sawon where saname = '이미자'
	select * from sawon where saname like '이%'
	
--	12) 사원테이블에서 이름의 2번쨰 글자가 '미' 인 사원 조회
	select * from sawon where saname like '_미_'
	select * from sawon where saname like '%미%'
	
--	13) 고객 테이블에서 여자 고객만 조회(문자열 유사검색식 이용해서 조회)
	select * from GOGEK where gojumin like '_______2%'
	select * from GOGEK where gojumin like '______-2%'  or  gojumin like '%-0%'
														or  gojumin like '%-4%'
														or  gojumin like '%-6%'
														or  gojumin like '%-8%'
														
--	14) 고객테이블에서 강남구 사는 고객 조회
	select * from Gogek where goaddr like '%강남구%'
														
--	15) 고객테이블에서 봄에 태어난 고객을 조회 , 고객테이블에서 겨울에 태어난 고객을 조회 
 	select * from GOGEK where gojumin like '__03%' or gojumin like '__05%' or gojumin like '__04%'
	select * from GOGEK where gojumin like '__01%' or gojumin like '__02%' or gojumin like '__12%'

--	16) 고객테이블에서 90년대생 고객을 조회
	select * from gogek where gojumin like '9%' 

	select * from gogek where
	gojumin like      '91%'   or
	gojumin like      '92%'   or
	gojumin like      '93%'   or
	gojumin like      '94%'   or
	gojumin like      '95%'   or
	gojumin like      '96%'   or
	gojumin like      '97%'   or
	gojumin like      '98%'   or
	gojumin like      '99%'   or
	gojumin like      '90%'
	
	17) 사원 테이블에서 모든컬럼 + 보너스 + 급여순위
	select * from sawon
	select s.*, sapay/10 as 보너스 , rank() over(order by sapay desc) as rank from (select * from sawon) s order by sabun asc