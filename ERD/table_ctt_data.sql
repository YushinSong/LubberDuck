

-- 샘플 authority
INSERT INTO ctt_authority (name) VALUES
    ('ROLE_CUSTOMER'), ('ROLE_MANAGER')
;

-- 샘플 user
INSERT INTO ctt_user (username, password, nickname, email, authority_id) VALUES
    ('MANAGER1', '$2a$10$ZYPlIVx3aQED1LRGb1vrNeSezD3.rARxjmOYeBksGf0bC0dAzBIzy', '사장님1', 'manager1@mail.com', 2)
;
INSERT INTO ctt_user (username, password, nickname, email, authority_id) VALUES
    ('USER1', '$2a$10$ZYPlIVx3aQED1LRGb1vrNeSezD3.rARxjmOYeBksGf0bC0dAzBIzy', '손님1', 'user1@mail.com', 1)
;
INSERT INTO ctt_user (username, password, nickname, email, authority_id) VALUES
    ('USER2', '$2a$10$ZYPlIVx3aQED1LRGb1vrNeSezD3.rARxjmOYeBksGf0bC0dAzBIzy', '손님2', 'user2@mail.com', 1)
;

INSERT INTO ctt_user (username, password, nickname, email, birth_date, authority_id) VALUES
    ('USER3', '$2a$10$ZYPlIVx3aQED1LRGb1vrNeSezD3.rARxjmOYeBksGf0bC0dAzBIzy', '손님3', 'user3@mail.com', '1997-01-01', 1)
;


-- 메뉴 모음집
INSERT INTO ctt_menu (name, img_url, info, sequence, price) VALUES
    ('Americano', '/img/menu/Americano.webp', '미국인들이 밀라노-토리노의 씁쓸한 맛을 부드럽게 마시기 위해 탄산수를 섞어 만든 칵테일 (14도)', -1, 7600),
    ('Aviation', '/img/menu/Aviation.webp', '비행기 하늘을 연상시키는 보라색 빛깔과 풍미를 가진 클래식 칵테일 (27도)', 1, 6700),
    ('Bellini', '/img/menu/Bellini.webp', '아름답고 화사한 색으로 복숭아의 상큼함과 샴페인의 탄산이 조화를 이루는 칵테일 (10도)', -1, 4600),
    ('Black Russian', '/img/menu/BlackRussian.webp', '커피 리큐르의 달콤함과 보드카를 한번에 즐길 수 있는 도수 높은 칵테일 (33도)', 9, 6800),
    ('Blue Hawaii', '/img/menu/BlueHawaii.webp', '푸른 바다로 둘러싸인 하와이 섬을 연상시키며 상쾌한 맛이 강한 트로피컬 칵테일 (11도)', -1, 7000),
    ('Hot Buttered Rum', '/img/menu/ButterRum.webp', '향긋한 향신료의 향과 버터의 고소하고 부드러운 맛과 함께 겨울철의 따뜻함과 친근함을 느낄 수 있는 따뜻한 칵테일 (15도)', -1, 9000),
    ('Clover Club', '/img/menu/CloverClub.webp', '1910년대 뉴욕의 클럽인 "클로버 클럽"에서 탄생한 예쁜 분홍빛의 라즈베리 색의 새콤한 맛이 강한 칵테일 (24도)', -1, 6000),
    ('Cosmopolitan', '/img/menu/Cosmopolitan.webp', '예쁜 선홍빛 색으로 향긋하고 달콤한 맛을 가진 높은 도수의 칵테일 (26도)', -1, 7100),
    ('Eggnog', '/img/menu/Eggnog.webp', '미국인들이 크리스마스에 즐겨 마시는 부드럽고 달콤한 맛을 가진 흰색 칵테일 (16도)', -1, 5600),
    ('Godfather', '/img/menu/GodFather.webp', '강렬한 위스키의 첫 맛과 달달하고 향긋한 아마레또의 향으로 마무리 되어 영화 "대부"가 연상되는 상남자 느낌의 칵테일 (37도)', -1, 4000),
    ('Grog', '/img/menu/Grog.webp', '영국 해군에서 생겨나 레몬의 신맛과 설탕의 단맛, 럼의 쓴맛을 함께 느낄 수 있는 칵테일 (8도)', 8, 5900),
    ('Hot Teddy', '/img/menu/HotTeddy.webp', '스코틀랜드에서 감기나 독감에 걸렸을 때 마시던 따뜻하고 부드러운 맛을 가진 칵테일 (12도)', -1, 5500),
    ('Hurricane', '/img/menu/Hurricane.webp', '처음의 충격과 충격이 지나간 후에 흔적이 남는 허리케인처럼 여름에 어울리는 깔끔하고 상쾌한 맛을 가진 트로피컬 칵테일 (26도)', -1, 5100),
    ('Long Island Iced Tea', '/img/menu/IcedTeaWithLemon.webp', '달달하고 부드러운 맛이 특징이며 강한 도수 때문에 칵테일계의 폭탄주라고 불리는 칵테일 (29도)', -1, 6000),
    ('Irish Cream', '/img/menu/IrishCream.webp', '고소한 풍미의 커피 향과 위스키의 조화로 달콤한 휘핑크림을 얹어 단맛과 쓴맛이 매력적인 칵테일 (14도)', 13, 5500),
    ('Kir Royale', '/img/menu/KirRoyale.webp', '샴페인의 청량함과 카시스의 달콤함으로 부드럽고 달콤한 매력적인 맛을 가진 칵테일 (14도)', -1, 6000),
    ('Lemonade Classic', '/img/menu/LemonadeClassic.webp', '진 베이스로 레몬의 새콤함과 시원한 맛을 가진 칵테일 (12도)', 15, 5000),
    ('Mai-Tai', '/img/menu/MaiTai.webp', '열대과일의 풍부한 향이 조화를 이루며 트로피컬 칵테일의 여왕이라고 불리는 칵테일 (30도)', 10, 7000),
    ('Dry Martini', '/img/menu/MartiniDry.webp', '칵테일의 제왕이라고 불리며 고유한 씁쓸한 맛과 올리브의 짠맛을 음미할 수 있는 칵테일 (37도)', -1, 8000),
    ('Mojito', '/img/menu/Mojito.webp', '민트의 시원한 청량감과 달달함이 섞인 입체적인 맛을 가진 칵테일 (19도)', 7, 8100),
    ('Mulled Apple Cider', '/img/menu/MulledAppleCider.webp', '따뜻한 사과 사이다에 향신료의 향이 잘 스며들어 부드럽고 향긋한 향이 가득한 칵테일 (10도)', 12, 7300),
    ('Mulled Wine', '/img/menu/MulledWine.webp', '와인에 4가지 과일과 5가지 향신료를 넣고 끓여 만든 낮은 도수의 칵테일 (6도)', -1, 6200),
    ('Old Fashioned', '/img/menu/OldFashioned.webp', '"비터드슬링"이라 불리며 위스키, 설탕, 비터스 세 가지의 조합의 칵테일 (33도)', 3, 7200),
    ('Planters Punch', '/img/menu/PlantersPunch.webp', '럼 베이스로 신맛과 단맛이 어우러지는 과일 위주의 맛을 가진 칵테일 (20도)', -1, 6900),
    ('Rob Roy', '/img/menu/RobRoy.webp', '위스키의 향과 스윗 베르뭇의 달콤한 맛이 잘 어우러지며 비터의 씁쓸한 맛으로 깔끔하게 마무리 해주는 칵테일 (32도)', 16, 6700),
    ('Sazerac', '/img/menu/Sazerac.webp', '상큼한 레몬의 풍미와 상쾌한 허브, 향긋한 아니스의 조합으로 부드러운 질감과 은은한 단맛이 환상적인 밸런스를 이룬 칵테일 (35도)', -1, 4900),
    ('Screwdriver', '/img/menu/ScrewDriver.webp', '오렌지의 새콤한 향과 단맛으로 보드카의 독한 맛을 잡아주어 쉽게 접할 수 있는 칵테일 (13도)', 6, 9000),
    ('Sea Breeze', '/img/menu/SeaBreeze.webp', '"바다에서 불어오는 바람"이라는 뜻으로 크렌베리와 자몽주스로 새콤달콤한 맛을 가진 칵테일 (8도)', 2, 8700),
    ('Singapore Sling', '/img/menu/SingaporeSling.webp', '여성들을 위한 과일주스처럼 예쁜 붉은 색의 상큼하고 단맛을 가진 칵테일 (11도)', 11, 7800),
    ('Strawberry Lemonade', '/img/menu/StrawberryLomonade.webp', '아름답고 상큼하고 다채로운 여름의 맛을 내어 반하게 만드는 기분 좋은 칵테일 (9도)', -1, 5500),
    ('Strawberry Peach Smoothie', '/img/menu/StrawberryPeachSmoothie.webp', '달콤하고 상큼한 맛과 크리미한 질감으로 더운 여름 날에 남녀노소 모두가 즐길 수 있는 칵테일 (9도)', -1, 5000),
    ('Tom & Jerry', '/img/menu/Tom&Jerry.webp', '미국 남부지방에서 즐겨 마시던 달걀 노른자와 흰자를 따로 거품 내어 럼과 브랜디를 섞어서 만든 따뜻한 칵테일 (20도)', -1, 5000),
    ('Watermelon Fresh Juice', '/img/menu/WatermelonFreshJuice.webp', '가벼운 거품과 수박의 달콤함, 상큼한 라임의 맛이 더해져 더운 여름 날에 어울리는 칵테일 (9도)', -1, 7900),
    ('Watermelon Kiwi Smoothie', '/img/menu/WatermelonKiwiSmoothie.webp', '시원하게 얼린 키위와 수박의 조합으로 새콤달콤한 맛과 함께 무더운 여름을 보낼 수 있는 가벼운 칵테일 9도)', -1, 6600),
    ('Whiskey Cola', '/img/menu/WhiskeyCola.webp', '톡톡 터지는 콜라의 탄산과 은은한 계피향, 위스키가 만나 단맛이 더 강렬하게 피어오르는 칵테일 (15도)', 14, 6000),
    ('Whiskey Sour', '/img/menu/WhiskeySour.webp', '레몬 주스와 설탕으로 신맛과 단맛이 부드럽게 조화를 이루는 칵테일 (18도)', 5, 4000),
    ('White Lady', '/img/menu/WhiteLady.webp', '갓 짜낸 레몬 주스처럼 귀여운 연노랑색 빛깔의 상큼함과 세련되고 부드러운 크리미한 질감을 가진 칵테일 (30도)', -1, 9000),
    ('White Russian', '/img/menu/WhiteRussian.webp', 'Black Russian에 크림을 첨가해 훨씬 부드럽고 중후한 맛을 가진 칵테일 (23도)', -1, 7700),
    ('Zombie', '/img/menu/Zombie.webp', '여러 과일과 시럽의 조합으로 새콤달콤한 맛을 가졌지만 "Zombie" 이름처럼 될 수 있는 높은 도수의 칵테일 (31도)', 4, 7800)
;


;
-- 샘플 카트
INSERT INTO ctt_cart (user_id, cocktail_id, quantity) VALUES
    (2, 39, 2)
;
INSERT INTO ctt_cart (user_id, cocktail_id, quantity) VALUES
    (2, 2, 1)
;
INSERT INTO ctt_cart (user_id, cocktail_id, quantity) VALUES
    (2, 20, 3)
;
INSERT INTO ctt_cart (user_id, cocktail_id, quantity) VALUES
    (3, 18, 2)
;
INSERT INTO ctt_cart (user_id, cocktail_id, quantity) VALUES
    (3, 20, 2)
;
INSERT INTO ctt_cart (user_id, cocktail_id, quantity) VALUES
    (5, 18, 2)
;
INSERT INTO ctt_cart (user_id, cocktail_id, quantity) VALUES
    (5, 39, 1)
;

INSERT INTO ctt_order (user_id, regdate) VALUES
    (2, 20240617);
INSERT INTO ctt_order (user_id, regdate) VALUES
    (2, 20240617);

INSERT INTO ctt_order (user_id, regdate) VALUES
    (2, 20240617121250);

INSERT INTO ctt_order (user_id, regdate) VALUES
    (3, 20240617121250);

INSERT INTO ctt_order (user_id, regdate) VALUES
    (5, 20240617121250);

INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (5, 18, 1, 7600);
INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (5, 18, 1, 7600);
INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (5, 18, 1, 7600);
INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (5, 18, 1, 7600);

INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (1, 18, 1, 7600);

INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (1, 18, 2, 6700);
INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (2, 18, 1, 7600);

INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (2, 18, 2, 6700);

INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (3, 18, 5, 8900);

INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (3, 18, 3, 9600);

INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (3, 18, 2, 7600);


INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (4, 18, 1, 8800);

INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (4, 18, 2, 9800);

INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (4, 18, 3, 5800);

INSERT INTO ctt_order_item (order_id, cocktail_id, quantity, price) VALUES
    (5, 18, 1, 8100);



-- 샘플 리뷰


INSERT INTO ctt_review (item_id, rate, content) VALUES
    (12, 5, '정말 맛있어요 최고예요. 달콤한 맛이 계속 기억에 남네요!');

INSERT INTO ctt_review (item_id, rate, content) VALUES
    (13, 4, '제가 생각한 맛이에요 ! 그런데 가게 분위기가 조금 시끄러워서 아쉽네요. 별점 1개 깎겠습니다!');

INSERT INTO ctt_review (item_id, rate, content) VALUES
    (14, 2, '흑흑 이걸 마신다고 해도 그녀가 잊혀지지 않아!!!!!!!!!!!');


INSERT INTO ctt_review (item_id, rate, content) VALUES
    (9, 1, '정말 맛있어요 최고예요. 달콤한 맛이 계속 기억에 남네요!');

INSERT INTO ctt_review (item_id, rate, content) VALUES
    (10, 3, '제가 생각한 맛이에요 ! 그런데 가게 분위기가 조금 시끄러워서 아쉽네요. 별점 1개 깎겠습니다!');

INSERT INTO ctt_review (item_id, rate, content) VALUES
    (11, 2, '흑흑 이걸 마신다고 해도 그녀가 잊혀지지 않아!!!!!!!!!!!');

INSERT INTO ctt_review (item_id, rate, content) VALUES
    (15, 3, '흑흑 이걸 마신다고 해도 그녀가 잊혀지지 않아!!!!!!!!!!!');

INSERT INTO ctt_review (item_id, rate, content) VALUES
    (8, 1, '정말 맛있어요 최고예요. 달콤한 맛이 계속 기억에 남네요!');

-- 샘플 최근
INSERT INTO ctt_recent (user_id, cocktail_id) VALUES
    (2,2)
;

-- 샘플 캘린더
INSERt INTO ctt_calendar (id, date, cocktail_id, comment, memo) VALUES
    (20240604,'2024-06-04',1,'가나다','일정메모는 longtext?')
;

INSERt INTO ctt_calendar (id, date, memo) VALUES
    (20240618,'2024-06-18','일정메모는 longtext?')
;

INSERt INTO ctt_calendar (id, date, cocktail_id, comment) VALUES
    (20240618,'2024-06-28', 29, '와 맛있겠죠??^^')
;

-- 샘플 recent
INSERT INTO ctt_recent (user_id, cocktail_id) VALUES
    (2,10)
;

INSERT INTO ctt_recent(user_id, cocktail_id)
VALUES (5,12)
;

INSERT INTO ctt_guestbook(user_id, x_coordinate, y_coordinate, z_coordinate, content, postItKind) VALUES
    (1, 46.54, 89.87, 1, '분위기가 너무 좋아요!', 2);

INSERT INTO ctt_guestbook(user_id, x_coordinate, y_coordinate, z_coordinate, content, postItKind) VALUES
    (5, 654.54, 893.87, 2, '사장님이 친절하세요~', 1);

INSERT INTO ctt_guestbook(user_id, x_coordinate, y_coordinate, z_coordinate, content, postItKind) VALUES
    (3, 897.34, 234.87, 3, '또 올거예요!!', 4);

INSERT INTO ctt_guestbook(user_id, x_coordinate, y_coordinate, z_coordinate, content, postItKind) VALUES
    (5, 346.56, 987.37, 4, '이번엔 다른 친구랑 같이 왔어요~~~', 3);

INSERT INTO ctt_guestbook(user_id, x_coordinate, y_coordinate, z_coordinate, content, postItKind) VALUES
    (4, 345.54, 679.87, 5, '칵테일이 맛있네요~~~', 5);


UPDATE ctt_menu
SET img_url = '/img/menu/Americano.webp'
WHERE id=1;
UPDATE ctt_menu
SET img_url = '/img/menu/Aviation.webp'
WHERE id=2;
UPDATE ctt_menu
SET img_url = '/img/menu/Bellini.webp'
WHERE id=3;
UPDATE ctt_menu
SET img_url = '/img/menu/BlackRussian.webp'
WHERE id=4;
UPDATE ctt_menu
SET img_url = '/img/menu/BlueHawaii.webp'
WHERE id=5;
UPDATE ctt_menu
SET img_url = '/img/menu/ButterRum.webp'
WHERE id=6;
UPDATE ctt_menu
SET img_url = '/img/menu/CloverClub.webp'
WHERE id=7;
UPDATE ctt_menu
SET img_url = '/img/menu/Cosmopolitan.webp'
WHERE id=8;
UPDATE ctt_menu
SET img_url = '/img/menu/Eggnog.webp'
WHERE id=9;
UPDATE ctt_menu
SET img_url = '/img/menu/GodFather.webp'
WHERE id=10;
UPDATE ctt_menu
SET img_url = '/img/menu/Grog.webp'
WHERE id=11;
UPDATE ctt_menu
SET img_url = '/img/menu/HotTeddy.webp'
WHERE id=12;
UPDATE ctt_menu
SET img_url = '/img/menu/Hurricane.webp'
WHERE id=13;
UPDATE ctt_menu
SET img_url = '/img/menu/IcedTeaWithLemon.webp'
WHERE id=14;
UPDATE ctt_menu
SET img_url = '/img/menu/IrishCream.webp'
WHERE id=15;
UPDATE ctt_menu
SET img_url = '/img/menu/KirRoyale.webp'
WHERE id=16;
UPDATE ctt_menu
SET img_url = '/img/menu/LemonadeClassic.webp'
WHERE id=17;
UPDATE ctt_menu
SET img_url = '/img/menu/MaiTai.webp'
WHERE id=18;
UPDATE ctt_menu
SET img_url = '/img/menu/MartiniDry.webp'
WHERE id=19;
UPDATE ctt_menu
SET img_url = '/img/menu/Mojito.webp'
WHERE id=20;
UPDATE ctt_menu
SET img_url = '/img/menu/MulledAppleCider.webp'
WHERE id=21;
UPDATE ctt_menu
SET img_url = '/img/menu/MulledWine.webp'
WHERE id=22;
UPDATE ctt_menu
SET img_url = '/img/menu/OldFashioned.webp'
WHERE id=23;
UPDATE ctt_menu
SET img_url = '/img/menu/PlantersPunch.webp'
WHERE id=24;
UPDATE ctt_menu
SET img_url = '/img/menu/RobRoy.webp'
WHERE id=25;
UPDATE ctt_menu
SET img_url = '/img/menu/Sazerac.webp'
WHERE id=26;
UPDATE ctt_menu
SET img_url = '/img/menu/ScrewDriver.webp'
WHERE id=27;
UPDATE ctt_menu
SET img_url = '/img/menu/SeaBreeze.webp'
WHERE id=28;
UPDATE ctt_menu
SET img_url = '/img/menu/SingaporeSling.webp'
WHERE id=29;
UPDATE ctt_menu
SET img_url = '/img/menu/StrawberryLomonade.webp'
WHERE id=30;
UPDATE ctt_menu
SET img_url = '/img/menu/StrawberryPeachSmoothie.webp'
WHERE id=31;
UPDATE ctt_menu
SET img_url = '/img/menu/Tom&Jerry.webp'
WHERE id=32;
UPDATE ctt_menu
SET img_url = '/img/menu/WatermelonFreshJuice.webp'
WHERE id=33;
UPDATE ctt_menu
SET img_url = '/img/menu/WatermelonKiwiSmoothie.webp'
WHERE id=34;
UPDATE ctt_menu
SET img_url = '/img/menu/WhiskeyCola.webp'
WHERE id=35;
UPDATE ctt_menu
SET img_url = '/img/menu/WhiskeySour.webp'
WHERE id=36;
UPDATE ctt_menu
SET img_url = '/img/menu/WhiteLady.webp'
WHERE id=37;
UPDATE ctt_menu
SET img_url = '/img/menu/WhiteRussian.webp'
WHERE id=38;
UPDATE ctt_menu
SET img_url = '/img/menu/Zombie.webp'
WHERE id=39;
