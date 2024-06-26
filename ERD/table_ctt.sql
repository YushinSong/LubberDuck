
CREATE TABLE ctt_aichat
(
    id      INT               NOT NULL AUTO_INCREMENT,
    user_id INT               NOT NULL COMMENT '유저아이디',
    role    ENUM('바텐더', '손님') NOT NULL COMMENT '채팅의 주체',
    content LONGTEXT          NOT NULL COMMENT '채팅내용',
    PRIMARY KEY (id)
) COMMENT '유저ai채팅테이블';

CREATE TABLE ctt_authority
(
    id   INT         NOT NULL AUTO_INCREMENT COMMENT '권한아이디',
    name VARCHAR(40) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE ctt_authority
    ADD CONSTRAINT UQ_id UNIQUE (id);

ALTER TABLE ctt_authority
    ADD CONSTRAINT UQ_name UNIQUE (name);

CREATE TABLE ctt_bookmark
(
    user_id     INT          NOT NULL COMMENT '유저아이디',
    cocktail_id INT          NOT NULL COMMENT '칵테일아이디',
    comment     VARCHAR(200) NULL     COMMENT '코멘트',
    PRIMARY KEY (user_id, cocktail_id)
) COMMENT '즐겨찾기테이블';

CREATE TABLE ctt_calendar
(
    id          INT          NOT NULL COMMENT '캘린더아이디',
    date        DATE         NOT NULL COMMENT '날짜',
    cocktail_id INT          NULL     COMMENT '칵테일아이디',
    comment     VARCHAR(400) NULL     COMMENT '메뉴 코멘트',
    memo        LONGTEXT     NULL     COMMENT '일정메모',
    PRIMARY KEY (id)
) COMMENT '관리자캘린더테이블';

ALTER TABLE ctt_calendar
    ADD CONSTRAINT UQ_id UNIQUE (id);

CREATE TABLE ctt_cart
(
    user_id     INT NOT NULL COMMENT '유저아이디',
    cocktail_id INT NOT NULL COMMENT '칵테일아이디',
    quantity    INT NOT NULL DEFAULT 1 COMMENT '수량',
    PRIMARY KEY (user_id, cocktail_id)
) COMMENT '카트 테이블';

CREATE TABLE ctt_menu
(
    id       INT          NOT NULL AUTO_INCREMENT COMMENT '칵테일아이디',
    name     VARCHAR(100) NOT NULL COMMENT '칵테일이름',
    img_url  VARCHAR(500) NOT NULL COMMENT '이미지url',
    info     LONGTEXT     NOT NULL,
    price    INT          NULL     DEFAULT 0 COMMENT '칵테일가격',
    sequence INT          NOT NULL DEFAULT -1 COMMENT '등록x:-1/등록:1이상',
    PRIMARY KEY (id)
) COMMENT '칵테일메뉴';

ALTER TABLE ctt_menu
    ADD CONSTRAINT UQ_id UNIQUE (id);

ALTER TABLE ctt_menu
    ADD CONSTRAINT UQ_name UNIQUE (name);

CREATE TABLE ctt_order
(
    id      INT      NOT NULL AUTO_INCREMENT COMMENT '주문아이디',
    user_id INT      NOT NULL COMMENT '유저아이디',
    regdate DATETIME NOT NULL DEFAULT now() COMMENT '주문일시',
    PRIMARY KEY (id)
) COMMENT '주문히스토리테이블';

ALTER TABLE ctt_order
    ADD CONSTRAINT UQ_id UNIQUE (id);

CREATE TABLE ctt_order_item
(
    id          INT NOT NULL AUTO_INCREMENT COMMENT '주문아이템아이디',
    order_id    INT NOT NULL COMMENT '주문아이디',
    cocktail_id INT NOT NULL COMMENT '칵테일아이디',
    quantity    INT NOT NULL DEFAULT 1 COMMENT '수량',
    price       INT NOT NULL DEFAULT 0 COMMENT '주문당시가격',
    PRIMARY KEY (id)
) COMMENT '주문아이템';

ALTER TABLE ctt_order_item
    ADD CONSTRAINT UQ_id UNIQUE (id);

CREATE TABLE ctt_recent
(
    saw_date    DATETIME NOT NULL DEFAULT now() COMMENT '상품 본 날짜',
    user_id     INT      NOT NULL COMMENT '유저아이디',
    cocktail_id INT      NOT NULL COMMENT '칵테일아이디',
    PRIMARY KEY (user_id, cocktail_id)
) COMMENT '최근 본 상품 테이블';

CREATE TABLE ctt_review
(
    id      INT          NOT NULL AUTO_INCREMENT COMMENT '후기아이디',
    item_id INT          NOT NULL COMMENT '주문아이템아이디',
    rate    INT          NOT NULL DEFAULT 0 COMMENT '별점',
    content LONGTEXT NOT NULL COMMENT '후기내용',
    regdate DATETIME     NOT NULL DEFAULT now() COMMENT '둥록일시',
    PRIMARY KEY (id)
) COMMENT '후기테이블';

ALTER TABLE ctt_review
    ADD CONSTRAINT UQ_id UNIQUE (id);

CREATE TABLE ctt_user
(
    id           INT          NOT NULL AUTO_INCREMENT COMMENT '유저아이디',
    authority_id INT          NOT NULL COMMENT '권한아이디',
    username     VARCHAR(100) NOT NULL,
    password     VARCHAR(200) NOT NULL,
    nickname     VARCHAR(80)  NOT NULL COMMENT '사용자닉네임',
    email        VARCHAR(80)  NULL    ,
    regdate      DATETIME     NOT NULL DEFAULT now(),
    birth_date   DATE         NULL    ,
    PRIMARY KEY (id)
);

ALTER TABLE ctt_user
    ADD CONSTRAINT UQ_id UNIQUE (id);

ALTER TABLE ctt_user
    ADD CONSTRAINT UQ_username UNIQUE (username);

ALTER TABLE ctt_user
    ADD CONSTRAINT FK_ctt_authority_TO_ctt_user
        FOREIGN KEY (authority_id)
            REFERENCES ctt_authority (id);

ALTER TABLE ctt_cart
    ADD CONSTRAINT FK_ctt_user_TO_ctt_cart
        FOREIGN KEY (user_id)
            REFERENCES ctt_user (id);

ALTER TABLE ctt_cart
    ADD CONSTRAINT FK_ctt_menu_TO_ctt_cart
        FOREIGN KEY (cocktail_id)
            REFERENCES ctt_menu (id);

ALTER TABLE ctt_bookmark
    ADD CONSTRAINT FK_ctt_user_TO_ctt_bookmark
        FOREIGN KEY (user_id)
            REFERENCES ctt_user (id);

ALTER TABLE ctt_bookmark
    ADD CONSTRAINT FK_ctt_menu_TO_ctt_bookmark
        FOREIGN KEY (cocktail_id)
            REFERENCES ctt_menu (id);

ALTER TABLE ctt_calendar
    ADD CONSTRAINT FK_ctt_menu_TO_ctt_calendar
        FOREIGN KEY (cocktail_id)
            REFERENCES ctt_menu (id);

ALTER TABLE ctt_order
    ADD CONSTRAINT FK_ctt_user_TO_ctt_order
        FOREIGN KEY (user_id)
            REFERENCES ctt_user (id);

ALTER TABLE ctt_recent
    ADD CONSTRAINT FK_ctt_menu_TO_ctt_recent
        FOREIGN KEY (cocktail_id)
            REFERENCES ctt_menu (id);

ALTER TABLE ctt_recent
    ADD CONSTRAINT FK_ctt_user_TO_ctt_recent
        FOREIGN KEY (user_id)
            REFERENCES ctt_user (id);

ALTER TABLE ctt_order_item
    ADD CONSTRAINT FK_ctt_order_TO_ctt_order_item
        FOREIGN KEY (order_id)
            REFERENCES ctt_order (id);

ALTER TABLE ctt_order_item
    ADD CONSTRAINT FK_ctt_menu_TO_ctt_order_item
        FOREIGN KEY (cocktail_id)
            REFERENCES ctt_menu (id);

ALTER TABLE ctt_review
    ADD CONSTRAINT FK_ctt_order_item_TO_ctt_review
        FOREIGN KEY (item_id)
            REFERENCES ctt_order_item (id);

ALTER TABLE ctt_aichat
    ADD CONSTRAINT FK_ctt_user_TO_ctt_aichat
        FOREIGN KEY (user_id)
            REFERENCES ctt_user (id);

CREATE TABLE ctt_guestbook
(
    id           INT          NOT NULL AUTO_INCREMENT COMMENT '게시판 아이디',
    user_id      INT          NOT NULL COMMENT '유저아이디',
    x_coordinate DOUBLE       NOT NULL COMMENT 'x좌표',
    y_coordinate DOUBLE       NOT NULL COMMENT 'y좌표',
    z_coordinate INT          NOT NULL COMMENT 'z좌표',
    content      VARCHAR(100) NULL     COMMENT '작성글',
    postItKind   INT   CHECK (postItKind between 1 AND 5)       NOT NULL COMMENT '포스트잇종류',
    PRIMARY KEY (id)
) COMMENT '게시판';

ALTER TABLE ctt_guestbook
    ADD CONSTRAINT UQ_id UNIQUE (id);

ALTER TABLE ctt_guestbook
    ADD CONSTRAINT UQ_z_coordinate UNIQUE (z_coordinate);

ALTER TABLE ctt_guestbook
    ADD CONSTRAINT FK_ctt_user_TO_ctt_board
        FOREIGN KEY (user_id)
            REFERENCES ctt_user (id);