/* 
 DDL (Data Definition Language) : 구조정의언어 (객체생성관리)
 	: create CREATE (생성)
 	  drop DROP (삭제)
 	  alter ALTER (수정)
 	  
 DCL (Data Control Language) : 권한 부여 / 회수(취소)
 	: grant (권한부여)
 	  revoke (권한회수)
 	  
 	  
 	  1. 유저생성 (DDL)
 	  create user test identified by test;

 	  2. 권한부여 (DCL)
 	  grant connect to test;	-- 접속권한
 	  grant resource to test;   -- 자원활용권한
 	  grant connect,resource to test; (동시에 주는방법)
 	  
 	  3. 권한회수 (DCL)
 	  revoke connect,resource from test;
 	  
 	  
 	  0. 테이블생성코드
 	  create table ttt(no int);
 	  	 	
 	  0. 테이블에 데이터 생성하는방법
 	  insert into ttt values(1);  
 	  
 	  commit; --커밋하기해야 데이터 나옴
 	  
 	  0.테이블 삭제
 	  drop table ttt;
 	  
 	  
 -- test 계정 작업 내용
 -- 성적 테이블 만들기
 	create table sungjuk
 	(
 	no int, --번호
 	name varchar2(100), --이름
 	kor int , --국어
 	eng int , --영어
 	math int  -- 수학
 	);
 	
 	--데이터 추가
 	DML(Data Manipulation Laungage) : 데이터 조작언어
 	: insert (추가)
 	  update (수정)
 	  delete (삭제)
 	  
 	--데이터 추가 (insert : DML)
 	insert into sungjuk values(1,'일길동',77,88,99);
 	--입력순서 변경
 	insert into sungjuk(no,name,eng,kor,math) values(); 	  
 	insert into sungjuk(no,eng,kor,math,name) values(2,99,88,66,'이길동');
 	insert into sungjuk values(3,'삼길동',87,68,79);
 	
 	--테이블 불러오기
 	 select *from sungjuk;
 	 
 	 select 
 	 	no,name,
 	 	(kor+eng+math) --따로연산한 데이터 
 	 	as tot,   --갈호안에 데이터 컬럼명 설정
 	 	(kor+eng+math)/3 as avg, --소수점 1자리까지
 	 	round((kor+eng+math)/3,1) as avg소수점, --소수점 1자리까지 round(값,소수점갯수)
 	 -- rank()순위 숫자를 부여하는 over(안에 가공할 내용을 적고) order 정렬할 데이터기준조건 desc 역순으로
 	 -- 페이징 처리할때 사용
 	 	rank() over( order by (kor+eng+math) desc) as rank
 	 	from sungjuk;
 	 	
 	 	
 	 select no,name from sungjuk;
 	 
 	  	  
 	--데이터 삭제(delete : DML)
 	-- 테이블명 where 조건절
 	delete from sungjuk where no=1;	  
 	   
 	--데이터 수정(update: DML)
 	--no=1인 레코드의 국어점수를 100으로 수정
 	update sungjuk set kor=100 where no=1;
 	update sungjuk set kor=100, eng=100 where no=2;
 	update sungjuk set kor=100, eng=100, math=99 where no=3;
 	
 	--test유저 샘플 db 조회
 	select * from dept
 	select * from sawon
 	
 	
 */