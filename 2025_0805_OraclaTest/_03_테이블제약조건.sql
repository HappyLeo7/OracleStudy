 /*
 
 테이블 제약조건
  : 데이터 무결성 체크 (Data Integrity)
	
  종류)
  1. not null : 필수입력
  2. unique : 도메인내에 유일한값(중복불가)
  3. check : 조건에 맞는 데이터만 입력가능
  4. default : 기본값(입력하지 않으면 기본값 입력됨)
  5. primary key : 기본키
  					not null + unique+index(검색성능향상)
  6. foreign key : 외래키
  					현재들어온값의 유효성유무를 외부테이블의 컬럼에서 참조

 
 */
--  ex1)not null : 필수입력(null허용 안함)
-- 			null : null 허용
  create table tb1
  (
 --컬럼명  자료형        [제약조건]
   name varchar2(100) not null,
   memo varchar2(100) null
  )
  
  insert into tb1 values('일길동','메모1');
  insert into tb1 values('삼길동','null');
  insert into tb1(name) values('이길동');
  
  --ORA-01400: NULL을 ("TEST"."TB1"."NAME") 안에 삽입할 수 없습니다
  insert into tb1(memo) values('메모2'); --오류남
select * from tb1

-------------------------------------------------------------------
/*
  ex2) unique제약 : 도메인내에 중복불가 */

--  제약조건을 인라인방식으로 설정 
create table tb2
(
	id varchar2(100) unique,
	name varchar2(100) not null,
	pwd varchar2(100) not null	
)
insert into tb2 values('one','일길동','1231');
insert into tb2 values('two','이길동','1232');

--ORA-00001: 무결성 제약 조건(TEST.SYS_C004003)에 위배됩니다
insert into tb2 values('one','원길동','1231');

create table tb22
(
	id varchar2(100) not null,
	name varchar2(100) not null,
	pwd varchar2(100) not null	
)

--DDL명령 (alter : 구조변경)
alter table tb22
	add constraint unique_tb22_id unique(id)
	--	constraint는 변수이름 정의 가능(제약조건이름,변수이고 사용자가 보기편하게 이름정하면된다.)
select * from tb22

insert into tb22 values('one','일길동','1234');

--ORA-00001: 무결성 제약 조건(TEST.UNIQUE_TB22_ID)에 위배됩니다
insert into tb22 values('one','원길동','1234');
insert into tb22 values('two','삼길동','1233');

alter table tb22

	add unique(pwd)

--테이블을 생성할때 이름을 넣을수도 있지만 제약조건을 따로따로 관리한다.
create table tb222
(
	id varchar2(100) constraint unique_tb222_id unique,
	name varchar2(100) not null,
	pwd varchar2(100) not null	
)

 -------------------------------------------------------------
/*
ex3) check제약 : 조건에 맞는 값만 입력을 허용
				(도메인무결성)   */
				create table tb3(
				name varchar2(100) not null,
				gender varchar2(100)
				)
				
	--'남자','남' , 'man' , 'male', 'M' 등  ? 사용자가 작성하고싶은데로 작성할수 있다.
	--'남자' , '여자' 외에는 입력불가처리
	-- 비교연산자 : 같은? : = 같지않냐? : !=< >
	--			>  >=   < <=
	--논리연산자 and     or  	not
	--기타연산자 : 
	--        필드 in (A,B) => 필드=A or 필드=B  ,  필드 in (A,B,C) =>필드=A or 필드=B or 필드=c
	--		  필드 between A and B : 필드값이 A~B 사이냐?
	alter table tb3
	add constraint ck_tb3_gender check(gender='남자'or gender='여자') 
	add constraint ck_tb3_gender check(gender in('남자','여자')) 
	
	
	insert into tb3 values('홍길동','남자') ;
	insert into tb3 values('이미자','여자') ;
	
	--ORA-02290: 체크 제약조건(TEST.CK_TB3_GENDER)이 위배되었습니다 '여자 ' 라고 공백이 들어가서 조건에 맞지않기때문에
	insert into tb3 values('이미주','여자 ') ;
	
	select * from tb3;
	
	create table tb33(
	no int constraint pk_tb33_no primary key,
	name varchar2(100) not null,
	kor int,
	eng int,
	math int
	)
	
	--kor 점수 유효범위설정 :0~100
	alter table tb33 
		add constraint ck_tb33_kor check(kor>0 and kor<100)

	--eng 점수 유효범위설정 :0 ~100
	alter table tb33
		add constraint ck_tb33_eng check(eng between 0 and 100)
		
	--math 점수 유효범위설정 :0~100
	alter table tb33
		add constraint ck_tb33_math check(math between 0 and 100)
		
	insert into tb33 values(1,'일길동',77,88,99);
	insert into tb33 values(2,'이길동',97,88,99);
	--ORA-02290: 체크 제약조건(TEST.CK_TB33_KOR)이 위배되었습니다
	insert into tb33 values(3,'국길동',-97,88,99);
	--ORA-02290: 체크 제약조건(TEST.CK_TB33_ENG)이 위배되었습니다
	insert into tb33 values(4,'오길동',97,188,99);
	--ORA-02290: 체크 제약조건(TEST.CK_TB33_MATH)이 위배되었습니다
	insert into tb33 values(5,'수길동',97,88,-1);
	
		select * from tb33;
		-- 제약조건을 확인(user_constraints : dictionary table)
		select constraint_type,constraint_name,table_name from user_constraints where table_name='TB33';
	
		--제약조건 제거
		alter table tb33
			drop constraint ck_tb33_math;
			

		
		--컬럼이 해당된 데이터 행 삭제
		delete tb33 where no=5;
		delete from tb33 where no=5;
		
------------------------------------------------------------------------------
--					ex4)default 제약 : 입력되지않은 값을 기본값으로 설정
		
		select * from tb4;
		create table tb4
		(
		name 	varchar2(100) not null,
		msg 	varchar2(100) not null,
		regdate date default sysdate
		)
		
		insert into tb4 values('일길동','오늘 비오네',sysdate);
		insert into tb4 (name,msg) values('이길동','습하네');
		insert into tb4 values('삼길동','우산이 없네',default);
		
		select name,msg,regdate, to_char(regdate,'HH24:mi:ss') as time from tb4;

		----------------------------------------------------------------------------------------------------------
		
/*		ex5) 기본키제약( primary key) : 개체무결성을 위해서 쓴다.
				: not null + unique + index(검색기능이 빨라진다.)
				*/
		
				

			create table tb5
				(idx int ,
				name varchar2(100)not null,
				msg varchar2(100) not null,
				regdate date default sysdate)
			
			select *from tb5;
			--기본키
			alter table tb5
			 	add constraint pk_tb5_idx primary key(idx);
			 
			--시퀀스 (일련번호 관리객체)
			create sequence seq_tb5_idx;
			insert into tb5 values( seq_tb5_idx.nextVal ,'일길동','비가 안오네',sysdate);
			insert into tb5 values( seq_tb5_idx.nextVal ,'이길동','비가 다시온다',sysdate);
				
			select * from tb5;
					
					
					
					
			---------------------------------------------------------------------------------------------------------		
/*				ex6) foreign key (외래키)	: 참조무결성
 * 
 * 
 * 
 */
					
		create table tb6(
			학번 int constraint pk_학생_학번 primary key,
			이름 varchar2(100) not null,
			전화번호 varchar2(100) not null,
			보호자명 varchar2(100) not null,
			보호자직업 varchar2(100) not null,
			주소 varchar2(100) not null
		);
		
		insert into tb6 values(1,'일길동','111-1111','일아비','자영업','서울');
		insert into tb6 values(2,'이길동','222-2222','이아비','변호사','경기도');
		insert into tb6 values(3,'삼길동','333-333','삼아비','소방관','대전');
		
		select * from tb6
					
		create table 성적
		(일련번호 int,
		학번 int,
		국어 int,
		영어 int,
		수학 int,
		학년 int,
		학기 int,
	시험종류 varchar2(100) not null
		)
					
		--기본키
		alter table 성적
			add constraint pk_성적_일련번호 primary key(일련번호);
			
		--외래키 : 부모키가 될수 있는 조건(unique)
		alter table 성적
			add constraint fk_성적_학번 foreign key(학번)
										references tb6(학번); --table명(컬럼명)
										on delete cascade <- 부모키를 삭제하면 자식도 삭제해라
					
					
		insert into 성적 values (1,1,90,80,70,1,1,'중간고사');
		insert into 성적 values (2,1,100,70,80,1,2,'기말고사');

		--ORA-02291: 무결성 제약조건(TEST.FK_성적_학번)이 위배되었습니다- 부모 키가 없습니다
		insert into 성적 values (3,10,100,70,80,1,1,'중간고사');
		
		select * from 성적;
					