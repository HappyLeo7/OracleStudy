
--decode 오라클에만 있음
decode(value, if1,value1,
              if2,value2,
              default)
              
	select sabun,saname,sapay,deptno,
	decode(deptno, 10, '총무부'
			      ,20, '영업부'
			      ,30, '전산실'
			      ,40, '관리부'
			      ,50, '경리부','부서없음')as "부서명" from sawon
	
	select *from dept
	
--### case ~ end

형식1)
	case (컬럼 또는 수식)
		when 값1 then 결과1
		when 값2 then 결과2
		when 값3 then 결과3
		else 기본값
	end
	
형식2)
	case
		when 조건1 then 결과1
		when 조건2 then 결과2
		when 조건3 then 결과3
	end
	
	
select
	sabun,saname,sajob,deptno,
	case deptno
		when 10 then '총무부'
		when 20 then '영업부'
		when 30 then '전산실'
		when 40 then '관리부'
		when 50 then '경리부'
		else '기타'
	end as 부서명
from sawon
order by deptno desc

-- 사원테이블에서 각사원의 입사 계절
select
	saname,sahire,
	case 
		when to_number(to_char(sahire,'mm')) in(3,4,5) then '봄'
		when to_number(to_char(sahire,'mm')) between 6 and 8  then '여름'
		when to_number(to_char(sahire,'mm')) >= 9 and to_number(to_char(sahire,'mm'))<= 11  then '가을'
		else '겨울'
	end as "입사계절"
from sawon

select
	saname,sahire,
	case floor(to_number(to_char(sahire,'mm'))/3) as "월/3"
		when 1  then '봄'
		when 2  then '여름'
		when 3  then '가을'
		else '겨울'
	end as "입사계절"
from sawon

--### NVL(필드,대체값) : 필드가 null이면 대체값으로 대체해라
	select sabun,saname,samgr,nvl(samgr,'X')as samgr2 from sawon -- nvl일때 넣는 타입이 맞지 않아서 오류남
	select sabun,saname,samgr,nvl(samgr,0)as samgr2 from sawon

	-- nvl2() 함수
	select sabun,saname,samgr,nvl2(samgr,1,0)as nvl2 from sawon
	select nvl2 from sawon
	
	
	--case문 성별, 계절,
	--select* from gogek
			   12345678901234  <-index
	gojumin = '760815-1325467'
	
	substr(문자열,시작,갯수) : 문자열 잘라내기
	substr(문자열,시작    ) : 시작부터 ~ 끝까지 문자열 잘라내기
	
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
		
		end)as goyob from (select * from gogek)m) g --주의할점 g는 heaing이 아니고 변수에 넣은 느낌이다.
	
		
	--
	select gojumin
	,case
--		when to_number(substr(gojumin,9,2)) (between (between 0 and 8) and (between 10 and 25)) then '화성'
		when to_number(substr(gojumin,9,2)) between 50 and 99 then '지구'
	end as "test"
	from gogek
	
	select * from gogek
	update gogek set gojumin='660215-1665467' where gobun=1
	update gogek set gojumin='791015-2935467' where goname='영희'
	order by