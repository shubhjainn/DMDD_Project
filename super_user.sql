purge recyclebin;
SET SERVEROUTPUT on;

DECLARE

BEGIN
  EXECUTE IMMEDIATE 'DROP USER APPADMINUSER CASCADE';
  EXECUTE IMMEDIATE 'DROP USER APPSUBSCRIBERUSER CASCADE';
  EXECUTE IMMEDIATE 'DROP USER REPORTVIEWER CASCADE';
  EXECUTE IMMEDIATE 'DROP ROLE APP_ADMIN';
  EXECUTE IMMEDIATE 'DROP ROLE APP_SUBSCRIBER';
  
  EXCEPTION
   WHEN OTHERS THEN
   IF SQLCODE != -1918
   THEN RAISE;
   END IF;
END;
/

CREATE role APP_ADMIN;
CREATE role APP_SUBSCRIBER;

CREATE USER APPADMINUSER IDENTIFIED BY "Neudmdd007123";
CREATE USER APPSUBSCRIBERUSER IDENTIFIED BY "Neudmdd007123";
CREATE USER REPORTVIEWER IDENTIFIED BY "Neudmdd007123";

GRANT APP_ADMIN TO APPADMINUSER;
GRANT APP_SUBSCRIBER TO APPSUBSCRIBERUSER;

GRANT CONNECT TO APP_ADMIN;
GRANT CONNECT TO APP_SUBSCRIBER;
GRANT CONNECT TO REPORTVIEWER;

DECLARE
   media_table_count number;
   post_tags_table_count number;
   likes_table_count number;
   comments_table_count number;
   posts_table_count number;
   mess_table_count number;
   conn_table_count number;
   users_table_count number;
   post_type_table_count number;
   media_type_table_count number;
   visibility_table_count number;
   tags_table_count number;
   user_id_seq_count number;
   tag_id_seq_count number;
   media_id_seq_count number;
   post_id_seq_count number;
   msg_id_seq_count number;
   comment_id_seq_count number;
BEGIN
  select count(*)
  into media_table_count from user_tables
  where table_name = 'MEDIA';
  
  select count(*)
  into post_tags_table_count from user_tables
  where table_name = 'POST_TAGS';
  
  select count(*)
  into likes_table_count from user_tables
  where table_name = 'LIKES';
  
  select count(*)
  into comments_table_count from user_tables
  where table_name = 'COMMENTS';
  
  select count(*)
  into posts_table_count from user_tables
  where table_name = 'POSTS';
  
  select count(*)
  into mess_table_count from user_tables
  where table_name = 'MESSAGES';
  
  select count(*)
  into conn_table_count from user_tables
  where table_name = 'CONNECTIONS';
  
  select count(*)
  into users_table_count from user_tables
  where table_name = 'USERS';
  
  select count(*)
  into post_type_table_count from user_tables
  where table_name = 'POST_TYPE';
  
  select count(*)
  into media_type_table_count from user_tables
  where table_name = 'MEDIA_TYPE';
  
  select count(*)
  into visibility_table_count from user_tables
  where table_name = 'VISIBILITY';
  
  select count(*)
  into tags_table_count from user_tables
  where table_name = 'TAGS';
  
  select count(*)
  into user_id_seq_count from user_sequences
  where sequence_name = 'USER_ID_SEQ';
  
  select count(*)
  into tag_id_seq_count from user_sequences
  where sequence_name = 'TAG_ID_SEQ';
  
  select count(*)
  into media_id_seq_count from user_sequences
  where sequence_name = 'MEDIA_ID_SEQ';
  
  select count(*)
  into comment_id_seq_count from user_sequences
  where sequence_name = 'COMMENT_ID_SEQ';
  
  select count(*)
  into post_id_seq_count from user_sequences
  where sequence_name = 'POST_ID_SEQ';
  
  select count(*)
  into msg_id_seq_count from user_sequences
  where sequence_name = 'MSG_ID_SEQ';
  
  IF(media_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE media'; END IF;
  
  if(post_tags_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE post_tags'; END IF;
  
  if(likes_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE likes'; END IF;
  
  if(comments_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE comments'; END IF;
  
  if(posts_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE posts'; END IF;
  
  if(mess_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE messages'; END IF;
  
  if(conn_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE connections'; END IF;
  
  if(users_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE users'; END IF;
  
  if(post_type_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE post_type'; END IF;
  
  if(media_type_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE media_type'; END IF;
  
  if(visibility_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE visibility'; END IF;
  
  if(tags_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE tags'; END IF;
  
  if(user_id_seq_count > 0) THEN EXECUTE IMMEDIATE 'DROP SEQUENCE USER_ID_SEQ'; END IF;
  
  if(tag_id_seq_count > 0) THEN EXECUTE IMMEDIATE 'DROP SEQUENCE TAG_ID_SEQ'; END IF;
  
  if(media_id_seq_count > 0) THEN EXECUTE IMMEDIATE 'DROP SEQUENCE MEDIA_ID_SEQ'; END IF;
  
  if(comment_id_seq_count > 0) THEN EXECUTE IMMEDIATE 'DROP SEQUENCE COMMENT_ID_SEQ'; END IF;
  
  if(post_id_seq_count > 0) THEN EXECUTE IMMEDIATE 'DROP SEQUENCE POST_ID_SEQ'; END IF;
  
  if(msg_id_seq_count > 0) THEN EXECUTE IMMEDIATE 'DROP SEQUENCE MSG_ID_SEQ'; END IF;
      
END;
/

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    password RAW(100) NOT NULL,
    full_name varchar(30) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender varchar(20) NOT NULL,
    bio varchar(255),
    email varchar(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE visibility (
    visibility_id INT PRIMARY KEY,
    visibility_type varchar(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE post_type (
    type_id INT PRIMARY KEY,
    type_name varchar(20) NOT NULL,
    num_of_days INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    post_id INT PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users,
    post_type INT NOT NULL REFERENCES post_type,
    visibility_type INT NOT NULL REFERENCES visibility,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE comments (
    comment_id INT PRIMARY KEY,
    comment_text varchar(255) NOT NULL,    
    user_id INT NOT NULL REFERENCES users,
    post_id INT NOT NULL REFERENCES posts,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE likes (
    user_id INT NOT NULL REFERENCES users,
    post_id INT NOT NULL REFERENCES posts,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    constraint like_pk PRIMARY KEY(user_id, post_id)
);

CREATE TABLE CONNECTIONS (
    follower_id INT NOT NULL REFERENCES users,
    followee_id INT NOT NULL REFERENCES users,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    constraint conn_pk PRIMARY KEY(follower_id, followee_id) 
);

CREATE TABLE tags (
  tag_id INT PRIMARY KEY,
  tag_name VARCHAR(30) UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE post_tags (
    post_id INT NOT NULL REFERENCES posts,
    tag_id INT NOT NULL REFERENCES tags,
    constraint pt_pk PRIMARY KEY(post_id, tag_id)
);

CREATE TABLE messages (
    msg_id INT PRIMARY KEY,
    sender_id INT NOT NULL REFERENCES users,
    receiver_id INT NOT NULL REFERENCES users,
    msg_body varchar(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE media_type (
    media_type_id INT PRIMARY KEY,
    media_type_name varchar(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE media (
    media_id INT PRIMARY KEY,
    post_id INT NOT NULL REFERENCES posts,
    media_url varchar(255) NOT NULL,
    media_type_id INT REFERENCES media_type,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE SEQUENCE user_id_seq
ORDER;

CREATE SEQUENCE tag_id_seq
ORDER;

CREATE SEQUENCE media_id_seq
ORDER;

CREATE SEQUENCE comment_id_seq
order;

CREATE SEQUENCE post_id_seq
ORDER;

CREATE SEQUENCE msg_id_seq
ORDER;

CREATE OR REPLACE FUNCTION STANDARD_HASH_OUTPUT(str IN VARCHAR2)
  RETURN RAW
  AS
  rawVal RAW(100);
  BEGIN
  SELECT standard_hash(str, 'SHA256') INTO rawVal FROM dual;
  RETURN rawVal;
END;
/

CREATE OR REPLACE PACKAGE subscriber_insert_pack AS 
    PROCEDURE insert_users_proc
    (
           v_userid IN users.user_id%TYPE,
           v_password IN users.password%TYPE,
           v_username IN users.username%TYPE,
           v_fullname IN users.full_name%TYPE,
           v_dob IN users.date_of_birth%TYPE,
           v_gender IN users.gender%TYPE,
           v_bio IN users.bio%TYPE,
           v_email IN users.email%TYPE,
           v_createdat IN users.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    );    
    PROCEDURE insert_posts_proc
    (
           v_postid IN posts.post_id%TYPE,
           v_userid IN posts.user_id%TYPE,
           v_posttype IN posts.post_type%TYPE,
           v_visibilitytype IN posts.visibility_type%TYPE,
           v_createdat IN posts.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    );
    PROCEDURE insert_comments_proc
    (         
           v_commentid IN comments.comment_id%TYPE,
           v_commenttext IN comments.comment_text%TYPE,
           v_userid IN comments.user_id%TYPE,
           v_postid IN comments.post_id%TYPE,
           v_createdat IN comments.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    );
    PROCEDURE insert_likes_proc
    (
           v_userid IN likes.user_id%TYPE,
           v_postid IN likes.post_id%TYPE,
           v_createdat IN likes.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    );
    PROCEDURE insert_connections_proc
    (
           v_followerid IN connections.follower_id%TYPE,
           v_followeeid IN connections.followee_id%TYPE,
           v_createdat IN connections.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    );
    PROCEDURE insert_tags_proc
    (
           v_tagid IN tags.tag_id%TYPE,
           v_tagname IN tags.tag_name%TYPE,
           v_createdat IN tags.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    );
    PROCEDURE insert_post_tags_proc
    (
           v_postid IN post_tags.post_id%TYPE,
           v_tagid IN post_tags.tag_id%TYPE 
    );
    PROCEDURE insert_msg_proc
    (
           v_msgid IN messages.msg_id%TYPE,
           v_senderid IN messages.sender_id%TYPE,
           v_receiverid IN messages.receiver_id %TYPE,
           v_msgbody IN messages.msg_body%TYPE,
           v_createdat IN messages.created_at%TYPE DEFAULT CURRENT_TIMESTAMP 
    );    
    PROCEDURE insert_media_proc
    (
          v_mediaid IN media.media_id%TYPE,
          v_postid IN media.post_id%TYPE,
          v_mediaurl IN media.media_url%TYPE,
          v_mediatypeid IN media.media_type_id%TYPE,
          v_createdat IN media.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    );
END subscriber_insert_pack;
/

CREATE OR REPLACE PACKAGE BODY subscriber_insert_pack AS 
    PROCEDURE insert_users_proc
    (
           v_userid IN users.user_id%TYPE,
           v_password IN users.password%TYPE,
           v_username IN users.username%TYPE,
           v_fullname IN users.full_name%TYPE,
           v_dob IN users.date_of_birth%TYPE,
           v_gender IN users.gender%TYPE,
           v_bio IN users.bio%TYPE,
           v_email IN users.email%TYPE,
           v_createdat IN users.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    )
    IS
    BEGIN
      INSERT INTO users (user_id, password, username, full_name, date_of_birth, gender, bio, email, created_at)
      VALUES (v_userid, v_password, v_username, v_fullname, v_dob, v_gender, v_bio, v_email, v_createdat);
    END;
    
    PROCEDURE insert_posts_proc
    (
       v_postid IN posts.post_id%TYPE,
       v_userid IN posts.user_id%TYPE,
       v_posttype IN posts.post_type%TYPE,
       v_visibilitytype IN posts.visibility_type%TYPE,
       v_createdat IN posts.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    )   
    IS
    BEGIN
        INSERT INTO posts VALUES(v_postid, v_userid, v_posttype, v_visibilitytype, v_createdat);
    END;
    
    PROCEDURE insert_comments_proc
    (
           v_commentid IN comments.comment_id%TYPE,
           v_commenttext IN comments.comment_text%TYPE,
           v_userid IN comments.user_id%TYPE,
           v_postid IN comments.post_id%TYPE,
           v_createdat IN comments.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    )
    IS
    BEGIN
      INSERT INTO comments(comment_id, comment_text, user_id, post_id, created_at)
      VALUES (v_commentid, v_commenttext, v_userid, v_postid, v_createdat);
    END;
    
    PROCEDURE insert_likes_proc
    (    
           v_userid IN likes.user_id%TYPE,
           v_postid IN likes.post_id%TYPE,
           v_createdat IN likes.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    )       
    IS
    BEGIN
       INSERT INTO likes(user_id, post_id, created_at) VALUES(v_userid, v_postid, v_createdat);
    END;
    
    PROCEDURE insert_connections_proc
    (
           v_followerid IN connections.follower_id%TYPE,
           v_followeeid IN connections.followee_id%TYPE,
           v_createdat IN connections.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    )
    IS
    BEGIN
      INSERT INTO connections(follower_id, followee_id, created_at) VALUES (v_followerid, v_followeeid, v_createdat);
    END;
    
    PROCEDURE insert_tags_proc
    (
           v_tagid IN tags.tag_id%TYPE,
           v_tagname IN tags.tag_name%TYPE,
           v_createdat IN tags.created_at%TYPE DEFAULT CURRENT_TIMESTAMP 
    )
    IS
    BEGIN
       INSERT INTO tags(tag_id, tag_name, created_at) values(v_tagid, v_tagname, v_createdat);
    END;
    
    PROCEDURE insert_post_tags_proc
    (
           v_postid IN post_tags.post_id%TYPE,
           v_tagid IN post_tags.tag_id%TYPE 
    )
    IS
    BEGIN
       INSERT INTO post_tags(post_id, tag_id) values(v_postid, v_tagid);
    END;
    
    PROCEDURE insert_msg_proc
    (
           v_msgid IN messages.msg_id%TYPE,
           v_senderid IN messages.sender_id%TYPE,
           v_receiverid IN messages.receiver_id%TYPE,
           v_msgbody IN messages.msg_body%TYPE,
           v_createdat IN messages.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    )
    IS
    BEGIN
      INSERT INTO messages(msg_id, sender_id, receiver_id, msg_body, created_at)
      VALUES (v_msgid, v_senderid, v_receiverid, v_msgbody, v_createdat);
    END;
    
    PROCEDURE insert_media_proc
    (
       v_mediaid IN media.media_id%TYPE,
       v_postid IN media.post_id%TYPE,
       v_mediaurl IN media.media_url%TYPE,
       v_mediatypeid IN media.media_type_id%TYPE,
       v_createdat IN media.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    )   
    IS
    BEGIN
        INSERT INTO media (media_id, post_id, media_url, media_type_id, created_at)
        VALUES (v_mediaid, v_postid, v_mediaurl, v_mediatypeid, v_createdat);
    END;
END subscriber_insert_pack;
/

CREATE OR REPLACE PACKAGE admin_only_insert_pack AS 
    PROCEDURE insert_visibility_proc
    (
           v_visibilityid IN visibility.visibility_id%TYPE,
           v_visibilitytype IN visibility.visibility_type%TYPE,
           v_createdat IN visibility.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    );
    PROCEDURE insert_post_type_proc
    (
           v_typeid IN post_type.type_id%TYPE,
           v_typename IN post_type.type_name%TYPE,
           v_numofdays IN post_type.num_of_days%TYPE,
           v_createdat IN post_type.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    );
    PROCEDURE insert_media_type_proc
    (
          v_mediatypeid IN media_type.media_type_id%TYPE,
          v_mediatypename IN media_type.media_type_name%TYPE,
          v_createdat IN media_type.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    );
END admin_only_insert_pack;
/

CREATE OR REPLACE PACKAGE BODY admin_only_insert_pack AS
    PROCEDURE insert_visibility_proc
    (
           v_visibilityid IN visibility.visibility_id%TYPE,
           v_visibilitytype IN visibility.visibility_type%TYPE,
           v_createdat IN visibility.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    )
    IS
    BEGIN
       INSERT INTO visibility(visibility_id, visibility_type, created_at) values(v_visibilityid, v_visibilitytype, v_createdat);
    END;

    PROCEDURE insert_post_type_proc
    (
           v_typeid IN post_type.type_id%TYPE,
           v_typename IN post_type.type_name%TYPE,
           v_numofdays IN post_type.num_of_days%TYPE,
           v_createdat IN post_type.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    )
    IS
    BEGIN
       INSERT INTO post_type(type_id, type_name, num_of_days, created_at) values(v_typeid, v_typename, v_numofdays, v_createdat);
    END;
    
    PROCEDURE insert_media_type_proc
    (
           v_mediatypeid IN media_type.media_type_id%TYPE,
           v_mediatypename IN media_type.media_type_name%TYPE,
           v_createdat IN media_type.created_at%TYPE DEFAULT CURRENT_TIMESTAMP
    )
    IS
    BEGIN
      INSERT INTO media_type(media_type_id, media_type_name, created_at) VALUES (v_mediatypeid, v_mediatypename, v_createdat);
    END;
    
END admin_only_insert_pack;
/

CREATE OR REPLACE PROCEDURE reset_data(table_name varchar)
AS
BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE ' || table_name;
END;
/

CREATE OR REPLACE PROCEDURE reset_seq(seq_name varchar)
AS
BEGIN
  EXECUTE IMMEDIATE 'alter sequence ' || seq_name || ' restart start with 1';
END;
/


/*INDEXES*/

CREATE INDEX USER_NAME_IN 
ON 
USERS(USERNAME, FULL_NAME, EMAIL);

CREATE INDEX POST_OWNER_IN 
ON 
POSTS(USER_ID);

CREATE INDEX COMMENT_OWNER_IN 
ON 
COMMENTS(USER_ID);


/*TRIGGERS*/
CREATE OR REPLACE TRIGGER INTRO_MESSAGE_TRIG
AFTER INSERT 
ON 
USERS
FOR EACH ROW
WHEN (NEW.user_id > 0)
BEGIN
     INSERT INTO messages(msg_id, sender_id, receiver_id, msg_body, created_at)
      VALUES (msg_id_seq.nextval, 1, :NEW.user_id, 'Hello ' || :NEW.USERNAME || ', WE WELCOME YOU TO THE PLATFORM.', :NEW.created_at);
END;
/

/*Reports*/
/*List all the users who posted the private posts having greater than 2 comments*/
CREATE OR REPLACE VIEW PRIVATE_POSTS AS
select users.user_id, users.username, count(posts.post_id) as Total_Private_Posts 
from users inner join posts on posts.user_id = users.user_id 
inner join visibility on posts.visibility_type = visibility.visibility_id 
join comments on posts.post_id=comments.post_id 
where visibility.visibility_type = 'private' 
group by users.user_id, users.username having (count(comments.comment_id) > 2) 
order by Total_Private_Posts desc;

/*List top 3 users who posted more number of posts*/
CREATE OR REPLACE VIEW TOP_3_USERS_MAX_POSTS AS
with users_posts as
(
select users.user_id as user_id, users.username as user_name, count(posts.post_id) as Total_Posts
from users join posts on posts.user_id = users.user_id
group by users.user_id, users.username
order by Total_Posts desc
)
select * from (select user_id, user_name, Total_Posts, DENSE_RANK() OVER (order by Total_Posts DESC) RANK
from users_posts
order by RANK) where rank <= 3;

/*List the users and their total number of posts between 15-JAN-2018 and 17-JAN-2019*/
CREATE OR REPLACE VIEW POSTS_BETWEEN AS
SELECT users.user_id, users.username, count(posts.post_id) TOTAL_POSTS 
from users inner join posts on posts.user_id=users.user_id 
WHERE posts.created_at between '15-JAN-2018' AND '17-JAN-2019' 
group by users.user_id, users.username order by TOTAL_POSTS DESC;


/*The top 5 media post with highest number of comments*/
CREATE OR REPLACE VIEW MAX_COMMENTS AS
WITH posts_comments as
(
select m.post_id as post_id,count(c.comment_id) as comment_count from media m join comments c 
on m.post_id = c.post_id
group by m.post_id
order by count(c.comment_id)
)
select * from (select post_id, comment_count, DENSE_RANK() OVER (order by comment_count DESC) RANK
from posts_comments
order by RANK) where rank <= 5;

/* The users with no connections*/
CREATE OR REPLACE VIEW NO_CONNECTION_USERS AS
select username, count(followee_id) no_of_connections from users 
left join connections 
on user_id = follower_id 
group by username 
having count(followee_id) = 0
order by count(followee_id);

/*USER TIMELINE*/
CREATE OR REPLACE VIEW USER_TIMELINE AS
SELECT CONNECTIONS.FOLLOWER_ID, POSTS.POST_ID, COUNT(COMMENTS.COMMENT_ID) TOTAL_COMMENTS FROM POSTS 
INNER JOIN
CONNECTIONS 
ON 
POSTS.USER_ID=CONNECTIONS.FOLLOWEE_ID
LEFT JOIN
COMMENTS 
ON
POSTS.POST_ID=COMMENTS.POST_ID
GROUP BY 
POSTS.POST_ID, CONNECTIONS.FOLLOWER_ID
ORDER BY 
TOTAL_COMMENTS DESC
WITH READ ONLY;

grant EXECUTE ON SUBSCRIBER_INSERT_PACK to APP_SUBSCRIBER;
grant EXECUTE ON reset_data to APP_SUBSCRIBER;
grant EXECUTE ON reset_seq to APP_SUBSCRIBER;
grant EXECUTE ON STANDARD_HASH_OUTPUT to APP_SUBSCRIBER;
grant SELECT ON user_id_seq to APP_SUBSCRIBER;
grant SELECT ON tag_id_seq to APP_SUBSCRIBER;
grant SELECT ON media_id_seq to APP_SUBSCRIBER;
grant SELECT ON comment_id_seq to APP_SUBSCRIBER;
grant SELECT ON post_id_seq to APP_SUBSCRIBER;
grant SELECT ON msg_id_seq to APP_SUBSCRIBER;

grant EXECUTE ON ADMIN_ONLY_INSERT_PACK to APP_ADMIN;
grant EXECUTE ON reset_data to APP_ADMIN;

grant select on PRIVATE_POSTS to REPORTVIEWER;
grant select on TOP_3_USERS_MAX_POSTS to REPORTVIEWER;
grant select on POSTS_BETWEEN to REPORTVIEWER;
grant select on MAX_COMMENTS to REPORTVIEWER;
grant select on NO_CONNECTION_USERS to REPORTVIEWER;
grant select on USER_TIMELINE to REPORTVIEWER;
