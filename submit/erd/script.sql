CREATE TABLE `users` (
  `user_id` varchar(50) NOT NULL COMMENT '아이디',
  `user_name` varchar(50) NOT NULL COMMENT '이름',
  `user_password` varchar(200) NOT NULL COMMENT 'mysql password 사용',
  `user_birth` varchar(8) NOT NULL COMMENT '생년월일 : 19840503',
  `user_auth` varchar(10) NOT NULL COMMENT '권한: ROLE_ADMIN,ROLE_USER',
  `user_point` int NOT NULL COMMENT 'default : 1000000',
  `created_at` datetime NOT NULL COMMENT '가입일자',
  `latest_login_at` datetime DEFAULT NULL COMMENT '마지막 로그인 일자',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원';

CREATE TABLE IF NOT EXISTS address (
    address_id int NOT NULL AUTO_INCREMENT,
    user_id varchar(50) NOT NULL,
    address nvarchar(200) NOT NULL,
    is_default varchar(1) NULL DEFAULT 'N' CHECK (is_default IN ('N', 'Y')),
    PRIMARY KEY(address_id),
    FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS product (
    product_id int NOT NULL AUTO_INCREMENT,
    product_name nvarchar(100) NOT NULL,
    price decimal(15) NOT NULL DEFAULT 0,
    description text NULL,
    cnt int NOT NULL DEFAULT 0,
    PRIMARY KEY(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS product_image (
    img_id int NOT NULL AUTO_INCREMENT,
    product_id int NOT NULL,
    img_url text NOT NULL,
    created_at datetime NOT NULL,
    updated_at datetime NULL,
    is_thumbnail varchar(1) NULL DEFAULT 'N' CHECK(is_thumbnail IN ('N', 'Y')),
    PRIMARY KEY(img_id),
    FOREIGN KEY(product_id) REFERENCES product(product_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS categories (
    category_id int NOT NULL AUTO_INCREMENT,
    category_name nvarchar(50) NOT NULL,
    PRIMARY KEY(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS category_product_registeration (
    product_id int NOT NULL,
    category_id int NOT NULL,
    FOREIGN KEY(product_id) REFERENCES product(product_id) ON DELETE CASCADE,
    FOREIGN KEY(category_id) REFERENCES categories(category_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS shopping_cart (
    product_id int NOT NULL,
    user_id varchar(50) NOT NULL,
    quantity int NOT NULL DEFAULT 0,
    FOREIGN KEY(product_id) REFERENCES product(product_id) ON DELETE CASCADE,
    FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS orders (
    order_id int NOT NULL AUTO_INCREMENT,
    user_id varchar(50) NOT NULL,
    order_state varchar(50) NOT NULL DEFAULT 'CHECKING_ORDER' CHECK(order_state IN ('CHECKING_ORDER', 'PACKING_FOR_SHIPMENT', 'ON_DELIVERY', 'DELIVERY_OVER')),
    order_date datetime NOT NULL,
    shipping_address nvarchar(200) NOT NULL,
    receiver_name varchar(50) NOT NULL,
    receiver_phone varchar(13) NOT NULL,
    PRIMARY KEY(order_id),
    FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS order_details (
    order_details_id int NOT NULL AUTO_INCREMENT,
    order_id int NOT NULL,
    product_id int NOT NULL,
    cnt int NOT NULL,
    PRIMARY KEY(order_details_id),
    FOREIGN KEY(order_id) REFERENCES orders(order_id),
    FOREIGN KEY(product_id) REFERENCES product(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS point (
    point_id int NOT NULL AUTO_INCREMENT,
    user_id varchar(50) NOT NULL,
    point_type varchar(20) NOT NULL CHECK (point_type IN ('JOIN_SAVE', 'PURCHASE_SAVE', 'DAILY_SAVE')),
    point_value int NOT NULL,
    created_at datetime NOT NULL,
    PRIMARY KEY(point_id),
    FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;