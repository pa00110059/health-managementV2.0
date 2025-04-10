
	/*
		注意：user表格的插入數據是程式自動生成，user表要有數據才能執行part2! 不然就會報錯!
		如果不想插入測試數據可以先不執行part2!
	*/

use HealthManagement
-- 插入測試數據
-- 插入 user_point 數據 (20筆)
INSERT INTO [user_point] ([user_id], [points], [last_updated])
VALUES (1, 100, '2023-01-15 09:30:00'),
       (2, 500, '2023-01-16 10:15:00'),
       (3, 200, '2023-01-17 14:20:00'),
       (4, 300, '2023-01-18 16:45:00'),
       (5, 150, '2023-01-19 08:10:00'),
       (6, 50, '2023-01-20 11:30:00'),
       (7, 250, '2023-01-21 13:15:00'),
       (8, 350, '2023-01-22 15:40:00'),
       (9, 400, '2023-01-23 17:25:00'),
       (10, 450, '2023-01-24 19:00:00'),
       (11, 120, '2023-01-25 20:35:00'),
       (12, 220, '2023-01-26 09:50:00'),
       (13, 320, '2023-01-27 11:15:00'),
       (14, 420, '2023-01-28 14:30:00'),
       (15, 520, '2023-01-29 16:45:00'),
       (16, 620, '2023-01-30 18:10:00'),
       (17, 720, '2023-01-31 20:35:00'),
       (18, 820, '2023-02-01 09:00:00'),
       (19, 920, '2023-02-02 11:25:00'),
       (20, 1020, '2023-02-03 13:50:00')
GO

-- 插入 coach 數據 (20筆)
INSERT INTO [coach] ([name], [expertise])
VALUES ('李教練', '重量訓練'),
       ('王教練', '有氧運動'),
       ('張教練', '瑜伽'),
       ('陳教練', '拳擊'),
       ('林教練', '游泳'),
       ('黃教練', '舞蹈'),
       ('吳教練', '功能性訓練'),
       ('劉教練', 'HIIT'),
       ('蔡教練', '普拉提'),
       ('鄭教練', '體能訓練'),
       ('周教練', 'TRX'),
       ('高教練', 'CrossFit'),
       ('謝教練', '拳擊有氧'),
       ('羅教練', '太極'),
       ('葉教練', '街舞'),
       ('許教練', '芭蕾'),
       ('徐教練', '爵士舞'),
       ('蘇教練', '現代舞'),
       ('彭教練', '民族舞'),
       ('曾教練', '肚皮舞')
GO

-- 插入 product 數據 (20筆)
INSERT INTO [product] ([name], [description], [price], [stock_quantity], [image_url])
VALUES ('蛋白粉', '乳清蛋白粉，巧克力口味', 1200.00, 100, 'https://example.com/protein.jpg'),
       ('健身手套', '防滑透氣健身手套', 450.00, 50, 'https://example.com/gloves.jpg'),
       ('瑜伽墊', '加厚防滑瑜伽墊', 800.00, 30, 'https://example.com/mat.jpg'),
       ('啞鈴組', '可調節重量啞鈴組', 2500.00, 20, 'https://example.com/dumbbell.jpg'),
       ('彈力帶', '5種阻力彈力帶組', 600.00, 40, 'https://example.com/band.jpg'),
       ('跳繩', '競速跳繩', 300.00, 60, 'https://example.com/rope.jpg'),
       ('健身腰帶', '舉重腰帶', 900.00, 25, 'https://example.com/belt.jpg'),
       ('運動水壺', '750ml運動水壺', 350.00, 80, 'https://example.com/bottle.jpg'),
       ('健身服套裝', '透氣排汗健身服', 1200.00, 35, 'https://example.com/clothes.jpg'),
       ('運動襪', '防滑運動襪3雙組', 250.00, 90, 'https://example.com/socks.jpg'),
       ('健身背包', '多功能健身背包', 1500.00, 15, 'https://example.com/bag.jpg'),
       ('按摩滾筒', '高密度泡沫滾筒', 700.00, 30, 'https://example.com/roller.jpg'),
       ('運動毛巾', '速乾運動毛巾', 200.00, 70, 'https://example.com/towel.jpg'),
       ('健身日誌', '健身記錄本', 180.00, 50, 'https://example.com/journal.jpg'),
       ('心率錶', '藍牙心率監測錶', 2800.00, 10, 'https://example.com/watch.jpg'),
       ('健身APP會員', '一年期健身APP會員', 1200.00, 999, 'https://example.com/app.jpg'),
       ('運動耳機', '無線運動耳機', 1600.00, 20, 'https://example.com/earphone.jpg'),
       ('健身課程DVD', '全套健身課程DVD', 950.00, 15, 'https://example.com/dvd.jpg'),
       ('健身書籍', '健身營養全書', 550.00, 25, 'https://example.com/book.jpg'),
       ('運動護腕', '支撐型運動護腕', 380.00, 40, 'https://example.com/wristband.jpg')
GO

-- 插入 course 數據 (20筆)
INSERT INTO [course] ([name], [description], [date], [coach_id], [duration], [max_capacity])
VALUES ('初級瑜伽', '適合初學者的瑜伽課程', '2023-03-01', 3, 60, 15),
       ('重量訓練入門', '學習基本重量訓練技巧', '2023-03-02', 1, 90, 10),
       ('有氧舞蹈', '燃脂有氧舞蹈課程', '2023-03-03', 6, 60, 20),
       ('高強度間歇訓練', 'HIIT高強度間歇訓練', '2023-03-04', 8, 45, 12),
       ('普拉提核心訓練', '強化核心肌群的普拉提', '2023-03-05', 9, 60, 15),
       ('拳擊有氧', '結合拳擊的有氧運動', '2023-03-06', 4, 60, 12),
       ('TRX全身訓練', '懸吊訓練系統課程', '2023-03-07', 11, 60, 10),
       ('功能性訓練', '提升日常功能性的訓練', '2023-03-08', 7, 60, 12),
       ('游泳技巧', '提升游泳技巧的課程', '2023-03-09', 5, 90, 8),
       ('舞蹈基礎', '各種舞蹈基礎訓練', '2023-03-10', 6, 60, 15),
       ('進階瑜伽', '適合有經驗者的瑜伽', '2023-03-11', 3, 75, 12),
       ('重量訓練進階', '進階重量訓練技巧', '2023-03-12', 1, 90, 8),
       ('有氧搏擊', '燃脂有氧搏擊課程', '2023-03-13', 13, 60, 15),
       ('CrossFit基礎', 'CrossFit基礎訓練', '2023-03-14', 12, 90, 10),
       ('太極養生', '太極養生課程', '2023-03-15', 14, 60, 15),
       ('街舞入門', '街舞基礎課程', '2023-03-16', 15, 60, 15),
       ('芭蕾塑形', '芭蕾舞塑形課程', '2023-03-17', 16, 60, 12),
       ('爵士舞', '爵士舞課程', '2023-03-18', 17, 60, 15),
       ('現代舞', '現代舞課程', '2023-03-19', 18, 60, 12),
       ('肚皮舞', '肚皮舞課程', '2023-03-20', 20, 60, 15)
GO

-- 插入 order 數據 (20筆)
INSERT INTO [order] ([user_id], [total_amount], [status], [created_at])
VALUES (1, 1200.00, 'completed', '2023-02-01 10:00:00'),
       (2, 1650.00, 'completed', '2023-02-02 11:15:00'),
       (3, 800.00, 'completed', '2023-02-03 14:30:00'),
       (4, 2500.00, 'pending', '2023-02-04 16:45:00'),
       (5, 600.00, 'completed', '2023-02-05 08:10:00'),
       (6, 300.00, 'completed', '2023-02-06 11:30:00'),
       (7, 900.00, 'completed', '2023-02-07 13:15:00'),
       (8, 350.00, 'completed', '2023-02-08 15:40:00'),
       (9, 1200.00, 'completed', '2023-02-09 17:25:00'),
       (10, 250.00, 'completed', '2023-02-10 19:00:00'),
       (11, 1500.00, 'pending', '2023-02-11 20:35:00'),
       (12, 700.00, 'completed', '2023-02-12 09:50:00'),
       (13, 200.00, 'completed', '2023-02-13 11:15:00'),
       (14, 180.00, 'completed', '2023-02-14 14:30:00'),
       (15, 2800.00, 'completed', '2023-02-15 16:45:00'),
       (16, 1200.00, 'completed', '2023-02-16 18:10:00'),
       (17, 1600.00, 'completed', '2023-02-17 20:35:00'),
       (18, 950.00, 'pending', '2023-02-18 09:00:00'),
       (19, 550.00, 'completed', '2023-02-19 11:25:00'),
       (20, 380.00, 'completed', '2023-02-20 13:50:00')
GO

-- 插入 order_item 數據 (20筆)
INSERT INTO [order_item] ([order_id], [product_id], [course_id], [quantity], [subtotal])
VALUES (1, 1, NULL, 1, 1200.00),
       (2, 2, NULL, 1, 450.00),
       (2, 9, NULL, 1, 1200.00),
       (3, 3, NULL, 1, 800.00),
       (4, 4, NULL, 1, 2500.00),
       (5, 5, NULL, 1, 600.00),
       (6, 6, NULL, 1, 300.00),
       (7, 7, NULL, 1, 900.00),
       (8, 8, NULL, 1, 350.00),
       (9, 9, NULL, 1, 1200.00),
       (10, 10, NULL, 1, 250.00),
       (11, 11, NULL, 1, 1500.00),
       (12, 12, NULL, 1, 700.00),
       (13, 13, NULL, 1, 200.00),
       (14, 14, NULL, 1, 180.00),
       (15, 15, NULL, 1, 2800.00),
       (16, 16, NULL, 1, 1200.00),
       (17, 17, NULL, 1, 1600.00),
       (18, 18, NULL, 1, 950.00),
       (19, 19, NULL, 1, 550.00),
       (20, 20, NULL, 1, 380.00)
GO

-- 插入 cart_item 數據 (20筆)
INSERT INTO [cart_item] ([user_id], [product_id], [course_id], [quantity], [added_at])
VALUES (1, 1, NULL, 1, '2023-02-21 10:00:00'),
       (2, NULL, 1, 1, '2023-02-21 11:15:00'),
       (3, 2, NULL, 1, '2023-02-21 14:30:00'),
       (4, NULL, 2, 1, '2023-02-21 16:45:00'),
       (5, 3, NULL, 1, '2023-02-22 08:10:00'),
       (6, NULL, 3, 1, '2023-02-22 11:30:00'),
       (7, 4, NULL, 1, '2023-02-22 13:15:00'),
       (8, NULL, 4, 1, '2023-02-22 15:40:00'),
       (9, 5, NULL, 1, '2023-02-23 17:25:00'),
       (10, NULL, 5, 1, '2023-02-23 19:00:00'),
       (11, 6, NULL, 1, '2023-02-23 20:35:00'),
       (12, NULL, 6, 1, '2023-02-24 09:50:00'),
       (13, 7, NULL, 1, '2023-02-24 11:15:00'),
       (14, NULL, 7, 1, '2023-02-24 14:30:00'),
       (15, 8, NULL, 1, '2023-02-25 16:45:00'),
       (16, NULL, 8, 1, '2023-02-25 18:10:00'),
       (17, 9, NULL, 1, '2023-02-25 20:35:00'),
       (18, NULL, 9, 1, '2023-02-26 09:00:00'),
       (19, 10, NULL, 1, '2023-02-26 11:25:00'),
       (20, NULL, 10, 1, '2023-02-26 13:50:00')
GO

-- 插入 body_metrics 數據 (20筆)
INSERT INTO [body_metrics] ([user_id], [weight], [body_fat], [muscle_mass], [bmi], [date_recorded], [height], [waist_circumference], [hip_circumference])
VALUES
(1, 70.0, 20.0, 30.0, 23.5, '2025-04-09', 175.0, 80.0, 95.0),
(2, 80.0, 25.0, 35.0, 24.0, '2025-04-09', 180.0, 88.0, 100.0),
(3, 75.0, 18.0, 32.0, 22.5, '2025-04-09', 170.0, 78.0, 92.0),
(4, 90.0, 28.0, 40.0, 27.0, '2025-04-09', 185.0, 95.0, 105.0),
(5, 65.0, 22.0, 28.0, 21.0, '2025-04-09', 165.0, 75.0, 90.0),
(6, 85.0, 20.0, 38.0, 26.5, '2025-04-09', 178.0, 86.0, 102.0),
(7, 95.0, 30.0, 45.0, 28.5, '2025-04-09', 182.0, 98.0, 108.0),
(8, 70.0, 23.0, 33.0, 24.5, '2025-04-09', 172.0, 82.0, 96.0),
(9, 80.0, 26.0, 36.0, 25.0, '2025-04-09', 176.0, 89.0, 101.0),
(10, 60.0, 18.0, 30.0, 21.0, '2025-04-09', 168.0, 76.0, 91.0),
(11, 88.0, 27.0, 42.0, 26.0, '2025-04-09', 181.0, 92.0, 103.0),
(12, 78.0, 22.0, 34.0, 24.0, '2025-04-09', 174.0, 84.0, 98.0),
(13, 72.0, 19.0, 31.0, 23.0, '2025-04-09', 171.0, 81.0, 94.0),
(14, 95.0, 29.0, 46.0, 28.0, '2025-04-09', 183.0, 97.0, 107.0),
(15, 82.0, 25.0, 39.0, 25.5, '2025-04-09', 177.0, 87.0, 100.0),
(16, 76.0, 21.0, 34.0, 23.0, '2025-04-09', 173.0, 83.0, 97.0),
(17, 69.0, 22.0, 32.0, 22.5, '2025-04-09', 169.0, 77.0, 93.0),
(18, 84.0, 24.0, 41.0, 26.0, '2025-04-09', 179.0, 90.0, 102.0),
(19, 73.0, 20.0, 33.0, 23.0, '2025-04-09', 170.0, 82.0, 95.0),
(20, 79.0, 23.0, 37.0, 24.5, '2025-04-09', 176.0, 85.0, 99.0);
GO

-- 插入 exercise_type_coefficients 數據 (20筆)
INSERT INTO [exercise_type_coefficients] ([exercise_name], [met])
VALUES
('跑步', 9.8),
('游泳', 7.0),
('騎自行車', 6.0),
('跳繩', 12.0),
('瑜珈', 2.5),
('健身房器械', 5.5),
('徒手健身', 5.0),
('高強度間歇訓練 (HIIT)', 8.5),
('快走', 4.3),
('爬山', 7.5),
('滑雪', 10.0),
('舞蹈', 6.5),
('划船機', 7.2),
('重訓', 6.5),
('橢圓機', 5.8),
('腳踏車競賽', 11.0),
('打籃球', 8.0),
('踢足球', 7.5),
('攀岩', 9.5),
('健走', 4.0);
GO

-- 插入 exercise_records 數據 (20筆)
INSERT INTO [exercise_records] ([user_id], [exercise_type], [exercise_duration], [calories_burned], [exercise_date])
VALUES
(1, '跑步', 30, 300, '2025-04-09'),
(2, '游泳', 45, 350, '2025-04-09'),
(3, '騎自行車', 60, 500, '2025-04-09'),
(4, '跳繩', 20, 250, '2025-04-09'),
(5, '瑜伽', 40, 150, '2025-04-09'),
(6, '健身房器械', 50, 400, '2025-04-09'),
(7, '徒手健身', 30, 200, '2025-04-09'),
(8, '高強度間歇訓練 (HIIT)', 30, 450, '2025-04-09'),
(9, '快走', 40, 180, '2025-04-09'),
(10, '爬山', 60, 700, '2025-04-09'),
(11, '滑雪', 90, 900, '2025-04-09'),
(12, '舞蹈', 60, 400, '2025-04-09'),
(13, '划船機', 30, 300, '2025-04-09'),
(14, '重訓', 60, 500, '2025-04-09'),
(15, '椭圆机', 40, 350, '2025-04-09'),
(16, '腳踏車競賽', 45, 550, '2025-04-09'),
(17, '打籃球', 60, 500, '2025-04-09'),
(18, '打足球', 70, 600, '2025-04-09'),
(19, '攀岩', 50, 450, '2025-04-09'),
(20, '健走', 30, 180, '2025-04-09');
GO

-- 插入 nutrition_records 數據 (20筆)
INSERT INTO [nutrition_records] ([user_id], [food_name], [calories], [protein], [carbs], [fats], [mealtime], [record_date])
VALUES
(1, '雞胸肉', 200, 40, 0, 5, '午餐', '2025-04-09'),
(2, '牛排', 300, 30, 0, 20, '晚餐', '2025-04-09'),
(3, '燕麥片', 150, 5, 27, 3, '早餐', '2025-04-09'),
(4, '全麥吐司', 120, 4, 20, 2, '早餐', '2025-04-09'),
(5, '蘋果', 95, 0, 25, 0, '點心', '2025-04-09'),
(6, '沙拉', 180, 4, 12, 10, '午餐', '2025-04-09'),
(7, '三文魚', 250, 20, 0, 18, '晚餐', '2025-04-09'),
(8, '蛋白質奶昔', 200, 20, 10, 2, '點心', '2025-04-09'),
(9, '雞蛋', 70, 6, 1, 5, '早餐', '2025-04-09'),
(10, '香蕉', 105, 1, 27, 0, '午餐', '2025-04-09'),
(11, '堅果', 150, 5, 6, 12, '點心', '2025-04-09'),
(12, '米飯', 200, 4, 45, 1, '午餐', '2025-04-09'),
(13, '鮮橙', 62, 1, 15, 0, '早餐', '2025-04-09'),
(14, '雞胸肉沙拉', 250, 35, 10, 5, '晚餐', '2025-04-09'),
(15, '火腿', 90, 6, 0, 7, '點心', '2025-04-09'),
(16, '豆腐', 100, 8, 2, 5, '晚餐', '2025-04-09'),
(17, '酸奶', 120, 10, 15, 3, '點心', '2025-04-09'),
(18, '花椰菜', 55, 5, 11, 1, '午餐', '2025-04-09'),
(19, '藍莓', 85, 1, 21, 0, '早餐', '2025-04-09'),
(20, '牛奶', 150, 8, 12, 8, '點心', '2025-04-09');
GO

-- 插入 fitness_goals 數據 (20筆)
INSERT INTO [fitness_goals] ([user_id], [goal_type], [target_value], [current_progress], [unit], [start_date], [end_date], [status])
VALUES
(1, '減重', 5.0, 1.0, '公斤', '2025-04-09', NULL, '進行中'),
(2, '增肌', 3.0, 0.5, '公斤', '2025-04-09', NULL, '進行中'),
(3, '心肺健康', 30.0, 10.0, '分鐘', '2025-04-09', NULL, '進行中'),
(4, '減重', 10.0, 4.0, '公斤', '2025-04-09', NULL, '進行中'),
(5, '增肌', 5.0, 1.0, '公斤', '2025-04-09', NULL, '進行中'),
(6, '心肺健康', 60.0, 15.0, '分鐘', '2025-04-09', NULL, '進行中'),
(7, '減重', 7.0, 2.0, '公斤', '2025-04-09', NULL, '進行中'),
(8, '增肌', 4.0, 1.2, '公斤', '2025-04-09', NULL, '進行中'),
(9, '心肺健康', 45.0, 20.0, '分鐘', '2025-04-09', NULL, '進行中'),
(10, '減重', 8.0, 3.0, '公斤', '2025-04-09', NULL, '進行中'),
(11, '增肌', 6.0, 2.0, '公斤', '2025-04-09', NULL, '進行中'),
(12, '心肺健康', 50.0, 25.0, '分鐘', '2025-04-09', NULL, '進行中'),
(13, '減重', 4.0, 1.5, '公斤', '2025-04-09', NULL, '進行中'),
(14, '增肌', 3.5, 1.0, '公斤', '2025-04-09', NULL, '進行中'),
(15, '心肺健康', 40.0, 18.0, '分鐘', '2025-04-09', NULL, '進行中'),
(16, '減重', 6.0, 2.5, '公斤', '2025-04-09', NULL, '進行中'),
(17, '增肌', 4.5, 1.5, '公斤', '2025-04-09', NULL, '進行中'),
(18, '心肺健康', 55.0, 22.0, '分鐘', '2025-04-09', NULL, '進行中'),
(19, '減重', 9.0, 3.5, '公斤', '2025-04-09', NULL, '進行中'),
(20, '增肌', 5.0, 2.0, '公斤', '2025-04-09', NULL, '進行中');
GO

-- 插入 achievements 數據 (20筆)
INSERT INTO [achievements] ([user_id], [achievement_type], [title], [description], [achieved_date])
VALUES
(1, '目標達成', '減重達成', '成功減少5公斤', '2025-04-09'),
(2, '一般成就', '完成30次瑜伽', '已完成30次瑜伽訓練', '2025-04-09'),
(3, '目標達成', '增肌達成', '成功增肌3公斤', '2025-04-09'),
(4, '一般成就', '跑步50公里', '成功完成50公里跑步挑戰', '2025-04-09'),
(5, '目標達成', '心肺健康達成', '成功提升心肺耐力到30分鐘', '2025-04-09'),
(6, '一般成就', '健身房100次', '完成100次健身房訓練', '2025-04-09'),
(7, '目標達成', '減重達成', '減少7公斤體重', '2025-04-09'),
(8, '一般成就', '游泳20次', '成功游泳20次', '2025-04-09'),
(9, '目標達成', '增肌達成', '成功增肌5公斤', '2025-04-09'),
(10, '一般成就', '步行達10000步', '成功達到10000步目標', '2025-04-09'),
(11, '目標達成', '減重達成', '成功減重8公斤', '2025-04-09'),
(12, '一般成就', '爬山達10次', '成功完成10次爬山挑戰', '2025-04-09'),
(13, '目標達成', '心肺健康達成', '成功提升心肺耐力到40分鐘', '2025-04-09'),
(14, '一般成就', '自行車30公里', '成功完成30公里自行車挑戰', '2025-04-09'),
(15, '目標達成', '增肌達成', '成功增肌4公斤', '2025-04-09'),
(16, '一般成就', '每日健身打卡30天', '連續30天打卡成功', '2025-04-09'),
(17, '目標達成', '減重達成', '減少9公斤體重', '2025-04-09'),
(18, '一般成就', '跳繩3000次', '成功完成3000次跳繩挑戰', '2025-04-09'),
(19, '目標達成', '心肺健康達成', '成功提升心肺耐力到50分鐘', '2025-04-09'),
(20, '一般成就', '步行500公里', '成功步行500公里', '2025-04-09');
GO


-- 插入 social_post 數據 (20筆)
INSERT INTO [social_post] ([category], [title], [content], [user_id], [created_at], [updated_at])
VALUES ('fitness', '我的健身旅程', '分享我從開始健身到現在的心得...', 1, '2023-02-01 10:00:00', '2023-02-01 10:00:00'),
       ('nutrition', '健康飲食建議', '分享一些我認為很有效的健康飲食方法...', 2, '2023-02-02 11:15:00',
        '2023-02-02 11:15:00'),
       ('recipe', '高蛋白早餐食譜', '這是我每天早上都會吃的高蛋白早餐...', 3, '2023-02-03 14:30:00',
        '2023-02-03 14:30:00'),
       ('fitness', '重量訓練技巧', '分享一些重量訓練的基本技巧...', 4, '2023-02-04 16:45:00', '2023-02-04 16:45:00'),
       ('motivation', '堅持運動的秘訣', '如何保持運動習慣不間斷...', 5, '2023-02-05 08:10:00', '2023-02-05 08:10:00'),
       ('nutrition', '增肌飲食計劃', '我的增肌飲食計劃分享...', 6, '2023-02-06 11:30:00', '2023-02-06 11:30:00'),
       ('fitness', '在家健身指南', '沒有時間去健身房？在家也能有效健身...', 7, '2023-02-07 13:15:00',
        '2023-02-07 13:15:00'),
       ('recipe', '減脂餐食譜', '分享我的減脂餐食譜...', 8, '2023-02-08 15:40:00', '2023-02-08 15:40:00'),
       ('fitness', '跑步訓練計劃', '我的半馬訓練計劃分享...', 9, '2023-02-09 17:25:00', '2023-02-09 17:25:00'),
       ('motivation', '克服平台期', '如何克服健身平台期...', 10, '2023-02-10 19:00:00', '2023-02-10 19:00:00'),
       ('nutrition', '運動後補充', '運動後該如何正確補充營養...', 11, '2023-02-11 20:35:00', '2023-02-11 20:35:00'),
       ('fitness', '核心訓練指南', '強化核心肌群的訓練方法...', 12, '2023-02-12 09:50:00', '2023-02-12 09:50:00'),
       ('recipe', '健康點心食譜', '分享幾款健康的點心食譜...', 13, '2023-02-13 11:15:00', '2023-02-13 11:15:00'),
       ('fitness', '彈力帶訓練', '如何用彈力帶進行全身訓練...', 14, '2023-02-14 14:30:00', '2023-02-14 14:30:00'),
       ('motivation', '設定健身目標', '如何設定合理的健身目標...', 15, '2023-02-15 16:45:00', '2023-02-15 16:45:00'),
       ('nutrition', '蛋白質攝取指南', '每天該攝取多少蛋白質...', 16, '2023-02-16 18:10:00', '2023-02-16 18:10:00'),
       ('fitness', '啞鈴訓練計劃', '我的啞鈴全身訓練計劃...', 17, '2023-02-17 20:35:00', '2023-02-17 20:35:00'),
       ('recipe', '增肌餐食譜', '分享我的增肌餐食譜...', 18, '2023-02-18 09:00:00', '2023-02-18 09:00:00'),
       ('fitness', 'HIIT訓練指南', '高強度間歇訓練的注意事項...', 19, '2023-02-19 11:25:00', '2023-02-19 11:25:00'),
       ('motivation', '保持運動熱情', '如何長期保持運動熱情...', 20, '2023-02-20 13:50:00', '2023-02-20 13:50:00')
GO

-- 插入 comment 數據 (20筆)
INSERT INTO [comment] ([post_id], [user_id], [text], [created_at], [updated_at])
VALUES (1, 2, '寫得真好，我也要開始健身了！', '2023-02-01 11:00:00', '2023-02-01 11:00:00'),
       (2, 3, '這些飲食建議很實用，謝謝分享！', '2023-02-02 12:15:00', '2023-02-02 12:15:00'),
       (3, 4, '明天就來試試這個食譜！', '2023-02-03 15:30:00', '2023-02-03 15:30:00'),
       (4, 5, '重量訓練的技巧很專業！', '2023-02-04 17:45:00', '2023-02-04 17:45:00'),
       (5, 6, '堅持運動真的很重要！', '2023-02-05 09:10:00', '2023-02-05 09:10:00'),
       (6, 7, '增肌飲食計劃很詳細！', '2023-02-06 12:30:00', '2023-02-06 12:30:00'),
       (7, 8, '在家健身的指南很實用！', '2023-02-07 14:15:00', '2023-02-07 14:15:00'),
       (8, 9, '減脂餐看起來很好吃！', '2023-02-08 16:40:00', '2023-02-08 16:40:00'),
       (9, 10, '跑步計劃很科學！', '2023-02-09 18:25:00', '2023-02-09 18:25:00'),
       (10, 11, '克服平台期的方法很有幫助！', '2023-02-10 20:00:00', '2023-02-10 20:00:00'),
       (11, 12, '運動後補充的建議很專業！', '2023-02-11 21:35:00', '2023-02-11 21:35:00'),
       (12, 13, '核心訓練的方法很有效！', '2023-02-12 10:50:00', '2023-02-12 10:50:00'),
       (13, 14, '健康點心食譜很適合我！', '2023-02-13 12:15:00', '2023-02-13 12:15:00'),
       (14, 15, '彈力帶訓練很方便！', '2023-02-14 15:30:00', '2023-02-14 15:30:00'),
       (15, 16, '設定目標真的很重要！', '2023-02-15 17:45:00', '2023-02-15 17:45:00'),
       (16, 17, '蛋白質攝取的指南很詳細！', '2023-02-16 19:10:00', '2023-02-16 19:10:00'),
       (17, 18, '啞鈴訓練計劃很全面！', '2023-02-17 21:35:00', '2023-02-17 21:35:00'),
       (18, 19, '增肌餐看起來很美味！', '2023-02-18 10:00:00', '2023-02-18 10:00:00'),
       (19, 20, 'HIIT訓練真的很有效！', '2023-02-19 12:25:00', '2023-02-19 12:25:00'),
       (20, 1, '保持運動熱情的方法很棒！', '2023-02-20 14:50:00', '2023-02-20 14:50:00')
GO