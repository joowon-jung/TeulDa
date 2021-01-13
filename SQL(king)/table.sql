
DROP TABLE GROUPS;
DROP TABLE USERS;

DROP SEQUENCE SEQ_GROUPS_ID;

CREATE SEQUENCE SEQ_GROUPS_ID INCREMENT BY 1 START WITH 10000;


CREATE TABLE USERS 
(
  NICKNAME VARCHAR2(50) NOT NULL 
, EMAIL VARCHAR2(50) NOT NULL 
, PASSWORD VARCHAR2(50) NOT NULL 
, USER_NAME VARCHAR2(50) NOT NULL 
, PHONE_NUMBER VARCHAR2(50) NOT NULL 
, USER_ADDR VARCHAR2(300) 
, LIKE_ADDR VARCHAR2(300) 
, BIRTH DATE 
, USER_PHOTO VARCHAR2(100)
, UPDATE_STATUS_DATE DATE
, IS_PUBLIC CHAR(1) DEFAULT 'T' NOT NULL
, STATUS CHAR(1) DEFAULT 0 NOT NULL
, ROLE CHAR(1) DEFAULT 1 NOT NULL
, CONSTRAINT USERS_PK PRIMARY KEY 
  (
    NICKNAME 
  )
  ENABLE 
);

ALTER TABLE USERS
ADD CONSTRAINT USERS_UK1 UNIQUE 
(
  EMAIL 
)
ENABLE;

COMMENT ON TABLE USERS IS '회원정보를 관리한다.'

COMMENT ON COLUMN USERS.NICKNAME IS '닉네임';
COMMENT ON COLUMN USERS.EMAIL IS '이메일';
COMMENT ON COLUMN USERS.PASSWORD IS '비밀번호';
COMMENT ON COLUMN USERS.USER_NAME IS '이름';
COMMENT ON COLUMN USERS.PHONE_NUMBER IS '휴대전화번호';
COMMENT ON COLUMN USERS.USER_ADDR IS '거주지';
COMMENT ON COLUMN USERS.LIKE_ADDR IS '관심지역';
COMMENT ON COLUMN USERS.BIRTH IS '출생일';
COMMENT ON COLUMN USERS.USER_PHOTO IS '프로필사진';
COMMENT ON COLUMN USERS.UPDATE_STATUS_DATE IS '계정 상태 수정날짜';
COMMENT ON COLUMN USERS.IS_PUBLIC IS '공개/비공개 여부';
COMMENT ON COLUMN USERS.STATUS IS '계정상태';
COMMENT ON COLUMN USERS.ROLE IS '역할';


CREATE TABLE GROUPS 
(
  GROUP_ID NUMBER NOT NULL 
, GROUP_NAME VARCHAR2(30) NOT NULL 
, NICKNAME VARCHAR2(50) NOT NULL 
, DELETE_DATE DATE 
, GROUP_TYPE CHAR(1) NOT NULL 
, CONSTRAINT GROUPS_PK PRIMARY KEY 
  (
    GROUP_ID 
  )
  ENABLE 
);

ALTER TABLE GROUPS
ADD CONSTRAINT GROUPS_FK1 FOREIGN KEY
(
  NICKNAME
)
REFERENCES USERS
(
  NICKNAME 
)
ENABLE;

COMMENT ON TABLE GROUPS IS '사진, 기록, 스크랩을 그룹으로 묶어 관리할 수 있다.';

COMMENT ON COLUMN GROUPS.GROUP_ID IS '그룹 No';
COMMENT ON COLUMN GROUPS.GROUP_NAME IS '그룹명';
COMMENT ON COLUMN GROUPS.NICKNAME IS '그룹을 생성한 유저 닉네임';
COMMENT ON COLUMN GROUPS.DELETE_DATE IS '삭제일자';
COMMENT ON COLUMN GROUPS.GROUP_TYPE IS '그룹 유형';






