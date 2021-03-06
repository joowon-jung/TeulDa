
<!-- SQL : INSERT -->

<insert	id="addReview"	parameterType="com.teulda.service.domain.Review" >

INSERT INTO review(review_id, nickname, review_addr, content, review_photo, review_date, star, is_allowed)
		VALUES (seq_review_review_id.NEXTVAL, 'king성영', '여기는 어디 난 누구?', 
			'여기가 어딘지는 몰라도 재미있는 곳 같다. 맛있는 것도 많구만', 'uuid!fileNamegg', 
			SYSDATE, 4, 't')


<!-- SQL : SELECT ONE -->
<select	id="getReview"	parameterType="int"	resultMap="reviewSelectMap">
	
SELECT review_id, nickname, review_addr, content, review_photo, review_date, star, is_allowed 
FROM review
WHERE review_id = 10003


<!-- SQL : LAST ONE -->
<select id="lastMyReview" parameterType="String" resultType="int">

SELECT MAX(review_id)
FROM review
WHERE nickname = 'king성영'


<!-- SQL : UPDATE -->
<update	id="updateReview"	parameterType="com.teulda.service.domain.Review" >

UPDATE review SET
	nickname		= 'king정인', 
	review_addr 	= '뚝섬 유원지 다리 아래', 
	content			= '뚝섬 유원지에 자전거를 타고 놀러갔는데 사람들이 정말 많았다. 라면을 먹으면서 천천히 구경하다 돌아왔다.', 
	review_photo	= 'uuidfiname9212',
	review_date		= SYSDATE,
	star			= 3,
	is_allowed		= 'f'
WHERE review_id = 10004


<!-- SQL : DELETE -->
<delete id="deleteReview"	parameterType="int">

	DELETE
	FROM review
	WHERE review_id = 10005


<!-- SQL : SELECT Review LIST -->
<select	id="getReviewList"	parameterType="com.teulda.common.Search"	resultMap="reviewSelectMap">

SELECT *  FROM(
	SELECT inner_table.*, ROWNUM AS row_seq	FROM(
		SELECT r.review_id, r.nickname, r.review_addr, r.content, r.review_photo, r.review_date, r.star, r.is_allowed
		FROM review r
		ORDER BY r.review_date DESC
		) inner_table
		WHERE ROWNUM <= 10 )
WHERE row_seq 
BETWEEN 1 AND 5


<!-- SQL : SELECT ROW Count -->
<select	id="getTotalCount"	parameterType="com.teulda.common.Search"	resultType="int">

SELECT COUNT(*) FROM(
	SELECT r.review_id, r.nickname, r.review_addr, r.content, r.review_photo, r.review_date, r.star, r.is_allowed
		FROM review r) countTable