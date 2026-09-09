-- Food Delivery App Database Schema & Sample Data

CREATE DATABASE IF NOT EXISTS `food`;
USE `food`;

-- Drop existing tables if any
DROP TABLE IF EXISTS `order_item`;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS `menu`;
DROP TABLE IF EXISTS `restaurant`;
DROP TABLE IF EXISTS `user`;

-- 1. User Table
CREATE TABLE `user` (
    `userid` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `username` VARCHAR(100) NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `phonenumber` VARCHAR(20),
    `address` VARCHAR(255),
    `role` VARCHAR(50) DEFAULT 'Customer',
    `createddate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `lastlogindate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Restaurant Table
CREATE TABLE `restaurant` (
    `restaurantid` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `address` VARCHAR(255),
    `phonenumber` VARCHAR(20),
    `cusinetype` VARCHAR(100),
    `deliverytime` VARCHAR(50),
    `admineuserid` INT DEFAULT 1,
    `rating` VARCHAR(10) DEFAULT '4.5',
    `isactive` VARCHAR(10) DEFAULT 'true',
    `imagepath` VARCHAR(500)
);

-- 3. Menu Table
CREATE TABLE `menu` (
    `menuid` INT AUTO_INCREMENT PRIMARY KEY,
    `restaurantid` INT NOT NULL,
    `itemname` VARCHAR(100) NOT NULL,
    `description` VARCHAR(500),
    `price` INT NOT NULL,
    `isavailable` VARCHAR(10) DEFAULT 'true',
    `ratings` FLOAT DEFAULT 4.5,
    `imagepath` VARCHAR(500),
    FOREIGN KEY (`restaurantid`) REFERENCES `restaurant`(`restaurantid`) ON DELETE CASCADE
);

-- 4. Order Table
CREATE TABLE `order` (
    `orderid` INT AUTO_INCREMENT PRIMARY KEY,
    `restaurantid` INT NOT NULL,
    `userid` INT NOT NULL,
    `orderdate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `totalamount` INT NOT NULL,
    `status` VARCHAR(50) DEFAULT 'Pending',
    `paymentmode` VARCHAR(50),
    FOREIGN KEY (`restaurantid`) REFERENCES `restaurant`(`restaurantid`) ON DELETE CASCADE,
    FOREIGN KEY (`userid`) REFERENCES `user`(`userid`) ON DELETE CASCADE
);

-- 5. Order Item Table
CREATE TABLE `order_item` (
    `orderitemid` INT AUTO_INCREMENT PRIMARY KEY,
    `orderid` INT NOT NULL,
    `menuid` INT NOT NULL,
    `quantity` INT NOT NULL,
    `totalamount` INT NOT NULL,
    FOREIGN KEY (`orderid`) REFERENCES `order`(`orderid`) ON DELETE CASCADE,
    FOREIGN KEY (`menuid`) REFERENCES `menu`(`menuid`) ON DELETE CASCADE
);

-- Sample Users
INSERT INTO `user` (`name`, `username`, `password`, `email`, `phonenumber`, `address`, `role`) VALUES
('John Doe', 'johndoe', 'password123', 'john@example.com', '9876543210', 'Flat 402, Sunshine Heights, MG Road, Bangalore', 'Customer'),
('Admin User', 'admin', 'admin123', 'admin@foodzone.com', '9999988888', 'FoodZone HQ, Outer Ring Road, Bangalore', 'Super Admin'),
('Jane Smith', 'janesmith', 'jane@123', 'jane@example.com', '9123456780', 'Villa 12, Palm Meadows, Whitefield, Bangalore', 'Customer');

-- Sample Restaurants
INSERT INTO `restaurant` (`name`, `address`, `phonenumber`, `cusinetype`, `deliverytime`, `admineuserid`, `rating`, `isactive`, `imagepath`) VALUES
('Biryani Bliss', 'Indiranagar 100ft Road, Bangalore', '080-25251122', 'Hyderabadi, Biryani, Mughlai', '30-35 mins', 1, '4.8', 'true', 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=600&auto=format&fit=crop&q=80'),
('Pizza Paradise', 'Koramangala 5th Block, Bangalore', '080-41412233', 'Italian, Pizza, Fast Food', '25-30 mins', 1, '4.6', 'true', 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600&auto=format&fit=crop&q=80'),
('Spice Symphony', 'HSR Layout Sector 2, Bangalore', '080-67678899', 'North Indian, Mughlai, Curry', '35-40 mins', 1, '4.5', 'true', 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=600&auto=format&fit=crop&q=80'),
('Dragon Wok', 'Church Street, Brigade Road, Bangalore', '080-33445566', 'Chinese, Asian, Noodles, Dimsums', '20-25 mins', 1, '4.7', 'true', 'https://images.unsplash.com/photo-1541696432-82c6da8ce7bf?w=600&auto=format&fit=crop&q=80'),
('Burger Bistro', 'Lavelle Road, Bangalore', '080-88990011', 'American, Burgers, Shakes & Fries', '20-30 mins', 1, '4.4', 'true', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&auto=format&fit=crop&q=80'),
('South Spice Kitchen', 'Jayanagar 4th Block, Bangalore', '080-22334455', 'South Indian, Dosas, Thali', '15-20 mins', 1, '4.9', 'true', 'https://images.unsplash.com/photo-1610192244261-3f33de3f55e4?w=600&auto=format&fit=crop&q=80'),
('Sweet Treats & Bakery', 'Residency Road, Bangalore', '080-55667788', 'Desserts, Cakes, Ice Cream', '15-25 mins', 1, '4.8', 'true', 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=600&auto=format&fit=crop&q=80'),
('Green Delight Bowl', 'Sarjapur Road, Bangalore', '080-99001122', 'Healthy, Salads, Smoothie Bowls', '20-30 mins', 1, '4.3', 'true', 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600&auto=format&fit=crop&q=80');

-- Sample Menu Items
-- Biryani Bliss (restaurantid = 1)
INSERT INTO `menu` (`restaurantid`, `itemname`, `description`, `price`, `isavailable`, `ratings`, `imagepath`) VALUES
(1, 'Hyderabadi Chicken Dum Biryani', 'Authentic basmati rice cooked with succulent chicken pieces and traditional spices', 299, 'true', 4.9, 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=600&auto=format&fit=crop&q=80'),
(1, 'Mutton Dum Biryani', 'Slow-cooked tender mutton layered with fragrant basmati saffron rice', 399, 'true', 4.8, 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=600&auto=format&fit=crop&q=80'),
(1, 'Paneer Tikka Biryani', 'Marinated cottage cheese cubes roasted and layered with spicy fragrant rice', 249, 'true', 4.5, 'https://images.unsplash.com/photo-1645177628172-a94c1f96e6db?w=600&auto=format&fit=crop&q=80'),
(1, 'Chicken 65', 'Crispy spicy deep fried chicken pieces with curry leaves and green chilies', 199, 'true', 4.7, 'https://images.unsplash.com/photo-1610057099443-fde8c4d50f91?w=600&auto=format&fit=crop&q=80');

-- Pizza Paradise (restaurantid = 2)
INSERT INTO `menu` (`restaurantid`, `itemname`, `description`, `price`, `isavailable`, `ratings`, `imagepath`) VALUES
(2, 'Margherita Classic Pizza', 'Fresh tomato sauce, melted mozzarella cheese, and fresh basil leaves', 249, 'true', 4.6, 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=600&auto=format&fit=crop&q=80'),
(2, 'Farmhouse Veggie Delight', 'Loaded with crisp capsicum, onion, grilled mushrooms, and fresh tomatoes', 299, 'true', 4.5, 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600&auto=format&fit=crop&q=80'),
(2, 'Pepperoni Feast Pizza', 'Spicy pepperoni slices on rich tomato sauce with double mozzarella', 399, 'true', 4.8, 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=600&auto=format&fit=crop&q=80'),
(2, 'Garlic Bread with Cheese', 'Freshly baked baguette topped with garlic herb butter and melted mozzarella', 149, 'true', 4.7, 'https://images.unsplash.com/photo-1619535860434-ba1d8fa12536?w=600&auto=format&fit=crop&q=80');

-- Spice Symphony (restaurantid = 3)
INSERT INTO `menu` (`restaurantid`, `itemname`, `description`, `price`, `isavailable`, `ratings`, `imagepath`) VALUES
(3, 'Butter Chicken', 'Tender boneless chicken cooked in a rich, buttery tomato cream gravy', 320, 'true', 4.9, 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=600&auto=format&fit=crop&q=80'),
(3, 'Paneer Butter Masala', 'Soft cottage cheese cubes in mildly spiced aromatic creamy tomato gravy', 260, 'true', 4.6, 'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=600&auto=format&fit=crop&q=80'),
(3, 'Dal Makhani', 'Slow simmered black lentils and kidney beans enriched with cream and butter', 220, 'true', 4.7, 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=600&auto=format&fit=crop&q=80'),
(3, 'Butter Garlic Naan (2 pcs)', 'Tandoor baked soft flatbread brushed with garlic herb butter', 70, 'true', 4.8, 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=600&auto=format&fit=crop&q=80');

-- Dragon Wok (restaurantid = 4)
INSERT INTO `menu` (`restaurantid`, `itemname`, `description`, `price`, `isavailable`, `ratings`, `imagepath`) VALUES
(4, 'Veg Hakka Noodles', 'Wok tossed noodles with crunchy julienned veggies and oriental sauces', 180, 'true', 4.6, 'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=600&auto=format&fit=crop&q=80'),
(4, 'Chilli Chicken Gravy', 'Crispy diced chicken tossed in spicy garlic soy sauce with bell peppers', 260, 'true', 4.8, 'https://images.unsplash.com/photo-1525755662778-989d0524087e?w=600&auto=format&fit=crop&q=80'),
(4, 'Steamed Dim Sums (6 pcs)', 'Delicate dumplings stuffed with seasoned vegetables, served with spicy dip', 190, 'true', 4.7, 'https://images.unsplash.com/photo-1496116218417-1a781b1c416c?w=600&auto=format&fit=crop&q=80'),
(4, 'Schezwan Fried Rice', 'Spicy stir-fried rice tossed with Schezwan peppers, garlic, and fresh veggies', 210, 'true', 4.5, 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=600&auto=format&fit=crop&q=80');

-- Burger Bistro (restaurantid = 5)
INSERT INTO `menu` (`restaurantid`, `itemname`, `description`, `price`, `isavailable`, `ratings`, `imagepath`) VALUES
(5, 'Crispy Chicken Zinger Burger', 'Crispy seasoned chicken patty topped with fresh lettuce and spicy mayo in a brioche bun', 199, 'true', 4.7, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&auto=format&fit=crop&q=80'),
(5, 'Double Cheese Veggie Smash Burger', 'Crunchy veggie patty layered with double cheddar, caramelized onions, and secret sauce', 179, 'true', 4.4, 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=600&auto=format&fit=crop&q=80'),
(5, 'Peri Peri French Fries', 'Crispy golden potato fries seasoned with spicy peri-peri spice dust', 119, 'true', 4.6, 'https://images.unsplash.com/photo-1576107232684-1279f3908594?w=600&auto=format&fit=crop&q=80'),
(5, 'Chocolate Thick Shake', 'Rich Belgian chocolate milkshake topped with whipped cream and chocolate drizzle', 149, 'true', 4.8, 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=600&auto=format&fit=crop&q=80');

-- South Spice Kitchen (restaurantid = 6)
INSERT INTO `menu` (`restaurantid`, `itemname`, `description`, `price`, `isavailable`, `ratings`, `imagepath`) VALUES
(6, 'Masala Ghee Dosa', 'Crisp golden crepe roasted in pure ghee, filled with spiced potato masala', 120, 'true', 4.9, 'https://images.unsplash.com/photo-1610192244261-3f33de3f55e4?w=600&auto=format&fit=crop&q=80'),
(6, 'Steamed Idli Vada Combo', 'Two pillowy soft idlis and one crispy medu vada served with hot sambar and chutneys', 90, 'true', 4.8, 'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=600&auto=format&fit=crop&q=80'),
(6, 'Filter Coffee (Special)', 'Traditional South Indian frothy chicory filter coffee brewed with hot milk', 45, 'true', 4.9, 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=600&auto=format&fit=crop&q=80');

-- Sweet Treats (restaurantid = 7)
INSERT INTO `menu` (`restaurantid`, `itemname`, `description`, `price`, `isavailable`, `ratings`, `imagepath`) VALUES
(7, 'Belgian Dark Chocolate Cake Slice', 'Decadent moist chocolate sponge layered with smooth 70% dark chocolate ganache', 150, 'true', 4.9, 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=600&auto=format&fit=crop&q=80'),
(7, 'Red Velvet Pastry', 'Classic red velvet layered with creamy vanilla bean cream cheese frosting', 140, 'true', 4.7, 'https://images.unsplash.com/photo-1586788680434-30d324b2d46f?w=600&auto=format&fit=crop&q=80'),
(7, 'Gulab Jamun with Rabri', 'Warm soft khoya dumplings soaked in rose sugar syrup, served with creamy chilled rabri', 120, 'true', 4.8, 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=600&auto=format&fit=crop&q=80');

-- Green Delight Bowl (restaurantid = 8)
INSERT INTO `menu` (`restaurantid`, `itemname`, `description`, `price`, `isavailable`, `ratings`, `imagepath`) VALUES
(8, 'Avocado & Quinoa Power Bowl', 'Organic quinoa, fresh Hass avocado, cherry tomatoes, cucumbers, and lemon tahini dressing', 280, 'true', 4.5, 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600&auto=format&fit=crop&q=80'),
(8, 'Berry Blast Smoothie Bowl', 'Blended acai, blueberries, and bananas topped with chia seeds, granola, and sliced kiwi', 240, 'true', 4.6, 'https://images.unsplash.com/photo-1590301157890-4810ed352733?w=600&auto=format&fit=crop&q=80');
