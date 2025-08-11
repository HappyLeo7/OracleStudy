/*
뷰 (view)
1. 가상의 테이블
2. 뷰내부에 수행해야될 sql문장이 저장되어있다.
	-> 테이블처럼 실행하면 내부 sql문이 실행된다.
3. 목적 :
	1)편리성 : 복잡한 명령을 간결하게 사용가능
	2)보안성 : 선택적으로 특정유저에게 데이터를 공개/비공개처리할 수 있다.
 */
	
--4. 형식)
--	남자 뷰 만들기
	create or replace view sawon_man_view
	as
		select * from sawon where sasex='남자'
--	여자 뷰 만들기
	create or replace view sawon_women_view
	as
		select * from sawon where sasex='여자'
--	뷰확인
	select * from sawon_man_view
	select * from sawon_women_view
	
--	아래 내용을 뷰로 만든다.	
	create or replace view sawon_view
	as
	select 
		s.*
		,to_number(to_char(sahire,'yyyy')) as hire_year
		,to_number(to_char(sahire,'mm')) as hire_month
		,case floor(to_number(to_char(sahire,'mm'))/3)
		when 1 then '봄'
		when 2 then '여름'
		when 3 then '가을'
		else '겨울'
		end as hire_season
	from 
		(select *from sawon)s
	
--	뷰 사용
	select * from sawon_view
	
--	exam) 이미자와 동일한 계절에 입사한 직원 조회
	select * from sawon_view
		where hire_season in
		(select hire_season from sawon_view where saname='이미자')
	
--	뷰 생성
	create or replace view gogek_view 
	as
		select 
		gobun
		,goname
		,goaddr
		,godam
		,substr(gojumin,1,8)||'******' as gojumin
		from gogek
		
	select * from gogek_view
	
--	보안성 테스트
	1. system 계정 
		sqlplus system/oracle 접속
	2. test9계정 생성
		create user test9 identified by test9
	3. 접속권한부여
		grant connect to test9
	4. 객체에 대한 접근권한 부여(객체주인(DBO)이 설정해야 한다.)
		conn test/test
	5. gogek_view에 대한 select권한 부여
		grant select on gogek_view to test9
		grant select,insert,update,delete on gogek_view to test9
		grant all on gogek_view to test9
	6. test9 계정으로 연결
		conn test9/test9
	7.test가 부여해준 gogek_wiew의 조회(select)기능 확인
					(dbo).테이블/뷰
		select * from test.gogek_view
		
		
		
---------------------------------------------------------------------------
create or replace view gogek_view2
as
	select g.*
		, to_number(to_char(sysdate,'yyyy'))-goyob as "나이(살)"
	,	case -- 성별
			when to_number(substr(gojumin,8,1)) in (0,2,4,6,8) then '여자'
			when to_number(substr(gojumin,8,1)) in (1,3,5,7,9) then '남자'
			else '외계인'
		end as gogekgender
		,case -- 계절
			when to_number(substr(gojumin,3,2))in(3,4,5) then '봄'
			when to_number(substr(gojumin,3,2))in(6,7,8) then '여름'
			when to_number(substr(gojumin,3,2))in(9,10,11) then '가을'
			when to_number(substr(gojumin,3,2))in(1,12,2) then '겨울'
		else '외계인'
		end as "계절"
		,
		case mod(goyob,12)
			when 0 then '원숭이'
			when 1 then '닭'
			when 2 then '강아지'
			when 3 then '돼지'
			when 4 then '쥐'
			when 5 then '소'
			when 6 then '호랑이'
			when 7 then '토끼'
			when 8 then '용'
			when 9 then '뱀'
			when 10 then '말'
			when 11 then '양'
		end as "동물띠"
		,case 
		when mod(goyob,10) in  (0,1) then '푸른색'
		when mod(goyob,10) in  (2,3) then '붉은색'
		when mod(goyob,10) in  (4,5) then '황금색'
		when mod(goyob,10) in  (6,7) then '백색'
		when mod(goyob,10) in  (8,9) then '검은색'
		end as "동물색"
		,case mod(goyob,10)
			when 0 then '경'
			when 1 then '신'
			when 2 then '임'
			when 3 then '계'
			when 4 then '갑'
			when 5 then '을'
			when 6 then '병'
			when 7 then '정'
			when 8 then '무'
			when 9 then '기'
		end as "10간지"
		, case mod(goyob,12)
		when 0 then '신'
		when 1 then '유'
		when 2 then '술'
		when 3 then '해'
		when 4 then '자'
		when 5 then '축'
		when 6 then '인'
		when 7 then '묘'
		when 8 then '진'
		when 9 then '사'
		when 10 then '오'
		when 11 then '미'
		end as "12간지"
		, (substr('경신임계갑을병정무기',mod(goyob,10)+1,1) ||
		substr('신유술해자축인묘진사오미',mod(goyob,12)+1,1) || '년'
		)as ganji
		,
		case 
			when to_number(substr(gojumin,9,2))=40 then '대전'
			when to_number(substr(gojumin,9,2)) in (44,49) then '세종특별시'
			when to_number(substr(gojumin,9,2)) in (55,56) then '광주광역시'
			when to_number(substr(gojumin,9,2)) in (85) then '울산광역시'
			when to_number(substr(gojumin,9,2)) between 0 and 8 then '서울특별시'
			when to_number(substr(gojumin,9,2)) between 9 and 12 then '부산광역시'
			when to_number(substr(gojumin,9,2)) between 13 and 15 then '인천광역시'
			when to_number(substr(gojumin,9,2)) between 16 and 25 then '경기도'
			when to_number(substr(gojumin,9,2)) between 26 and 34 then '강원도'
			when to_number(substr(gojumin,9,2)) between 35 and 39 then '충청북도'
			when to_number(substr(gojumin,9,2)) between 41 and 47 then '충청남도'
			when to_number(substr(gojumin,9,2)) between 48 and 54 then '전라북도'
			when to_number(substr(gojumin,9,2)) between 55 and 66 then '전라남도'
			when to_number(substr(gojumin,9,2)) >= 67 and 
				to_number(substr(gojumin,9,2)) <=69 or to_number(substr(gojumin,9,2))= 76 then '대구광역시'
			when to_number(substr(gojumin,9,2)) between 70 and 75 then '경상북도'
			when to_number(substr(gojumin,9,2)) between 77 and 81 then '경상북도'
			when to_number(substr(gojumin,9,2)) between 82 and 84 then '경상남도'
			when to_number(substr(gojumin,9,2)) between 86 and 92 then '경상남도'
			when to_number(substr(gojumin,9,2)) between 93 and 95 then '제주특별시'
			
				
			else '외국?'
		end as "출생지역"
	from (select m.*,	(to_number(substr(gojumin,1,2))+
		case -- 띠
		when to_number(substr(gojumin,8,1)) in(1,2,5,6) then 1900
		when to_number(substr(gojumin,8,1)) in(3,4,7,8) then 2000
		when to_number(substr(gojumin,8,1)) in(9,0) then 1800
		else 3000
		
		end)as goyob from (select * from gogek)m) g
--------------------end---gogek_view2----------------------------------------------------

		select * from gogek_view2
		
		create or replace view gogek_view3
		as
			select 
			gv2.gobun 
			,gv2.goname  
			,gv2.goaddr 
			,substr(gv2.gojumin,1,8)||'******' as gojumin
			,gv2.godam 
			,gv2.goyob
			,gv2."나이(살)" 
			,gv2.gogekgender 
			,gv2."계절" 
			,gv2."동물띠" 
			,gv2."동물색"
			,gv2."10간지" 
			,gv2."12간지"
			,gv2.ganji
			,gv2."출생지역" 
			from (select * from gogek_view2)gv2
			
		select * from gogek_view3
		
--			drop view gogek_view3
		
		
		
--		### 뷰를 이용해서 또다른 뷰 생성 (gogek_view3)
	select gv2.*
		from
		(select * from gogek_view2)gv2
		
--		### 사원테이블에서 퇴직급 계산(sawon_view2)
--		퇴직금1 = 근무년수 * 월급 + 잔녀월수/12 *월급
--		퇴직금2 = (총근무월수 *월급)/12;
		
		select * from sawon_view
		
		create or replace view sawon_view2
		as
		select s_v.* 
		,floor(months_between(sysdate,s_v.sahire)) as 총근무월수
		,months_between(sysdate,s_v.sahire) as 총근무월수2
		,floor(s_v.sapay/12) as 월급
		,s_v.sapay/12 as 월급2
		,months_between(sysdate,s_v.sahire) * s_v.sapay/12 as 총근무월수X월급
		,floor(((months_between(sysdate,s_v.sahire)*(s_v.sapay/12))/12)) as severance_pay
		,((months_between(sysdate,s_v.sahire)*(s_v.sapay/12))/12) as severance_pay2
		from (select * from sawon_view)s_v
		
		select * from sawon_view2
		
		  	select months_between(to_date('2025-05-06','yyyy-mm-dd')
												  ,to_date('2024-05-06','yyyy-mm-dd'))
												  from dual;
		