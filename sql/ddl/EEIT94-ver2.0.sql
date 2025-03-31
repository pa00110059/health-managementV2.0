/*

	��ƪ��(Table)�R�W�W�h

	���r���^��r��
	���i�[�J�ťաB����r�B���F "_" �~�䥦�Ÿ�
	�����p�g / �����j�g / ���r�j�g
	�Τ@�ĥ� ��� / �Ƽ� �^���r
	�ϥ� �Ҳ� ����

	���(Field) �R�W�W�h

	���r���^��r��
	���i�[�J�ťաB����r�B���F "_" �~�䥦�Ÿ�
	�����p�g / �����j�g / ���r�j�g
	�ϥ� ���W / ²�g
	�ϥ� ������
	���� ��m / �e�m
	�D�� �� ��� �ϥ� �S�w�W��

*/

use health_db

-- �Ы� user ��
CREATE TABLE [user] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] VARCHAR(50) NOT NULL,
  [email] VARCHAR(100) UNIQUE NOT NULL,
  [password_hash] VARCHAR(255) NOT NULL,
  [gender] CHAR(1),
  [bio] TEXT,
  [role] VARCHAR(10) NOT NULL DEFAULT 'user' CHECK ([role] IN ('user', 'admin')),
  [last_login] DATETIME NULL
)
GO

-- �Ы� user_point ��
CREATE TABLE [user_point] (
  [user_id] INT PRIMARY KEY,
  [points] INT DEFAULT (0),
  [last_updated] DATETIME
)
GO

-- �Ы� product ��
CREATE TABLE [product] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] NVARCHAR(255) NOT NULL,
  [description] NVARCHAR(1000),
  [price] DECIMAL(10,2) NOT NULL,
  [stock_quantity] INT NOT NULL DEFAULT (0),
  [image_url] NVARCHAR(500),
  [created_at] DATETIME DEFAULT CURRENT_TIMESTAMP,
  [updated_at] DATETIME DEFAULT CURRENT_TIMESTAMP
)
GO

-- �Ы� coach ��
CREATE TABLE [coach] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] NVARCHAR(255) NOT NULL,
  [expertise] NVARCHAR(255)
)
GO

-- �Ы� course ��
CREATE TABLE [course] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] NVARCHAR(255) NOT NULL,
  [description] NVARCHAR(1000) NOT NULL,
  [date] DATE NOT NULL,
  [coach_id] INT NOT NULL,
  [duration] INT NOT NULL,
  [max_capacity] INT NOT NULL,
  [status] VARCHAR(20) DEFAULT 'open' CHECK ([status] IN ('open', 'full', 'cancelled', 'completed'))
)
GO

-- �Ы� course_registration ��
CREATE TABLE [course_registration] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [user_id] INT NOT NULL,
  [course_id] INT NOT NULL,
  [registration_date] DATETIME DEFAULT CURRENT_TIMESTAMP,
  [status] VARCHAR(20) DEFAULT 'registered' CHECK ([status] IN ('registered', 'cancelled', 'attended', 'missed'))
)
GO

-- �Ы� order ��
CREATE TABLE [order] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [user_id] INT NOT NULL,
  [total_amount] DECIMAL(10,2) NOT NULL,
  [status] NVARCHAR(50) DEFAULT 'pending',
  [created_at] DATETIME DEFAULT CURRENT_TIMESTAMP
)
GO

-- �Ы� order_item ��
CREATE TABLE [order_item] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [order_id] INT NOT NULL,
  [product_id] INT,
  [course_id] INT,
  [quantity] INT NOT NULL DEFAULT (1),
  [subtotal] DECIMAL(10,2) NOT NULL
)
GO

-- �Ы� cart_item ��
CREATE TABLE [cart_item] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [user_id] INT NOT NULL,
  [product_id] INT,
  [course_id] INT,
  [quantity] INT NOT NULL DEFAULT (1),
  [added_at] DATETIME DEFAULT CURRENT_TIMESTAMP
)
GO

-- �Ы� body_metric ��
CREATE TABLE [body_metric] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [user_id] INT NOT NULL,
  [weight] DECIMAL(5,2) NOT NULL,
  [body_fat] DECIMAL(5,2),
  [muscle_mass] DECIMAL(5,2),
  [waist_circumference] DECIMAL(5,2),
  [hip_circumference] DECIMAL(5,2),
  [height] DECIMAL(5,2),
  [bmi] AS (weight / (height / 100) / (height / 100)) PERSISTED,
  [date_recorded] DATETIME DEFAULT GETDATE()
)
GO

-- �Ы� exercise_record ��
CREATE TABLE [exercise_record] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [user_id] INT NOT NULL,
  [exercise_type] NVARCHAR(50) NOT NULL,
  [duration] INT NOT NULL,
  [calories_burned] DECIMAL(10,2) NOT NULL,
  [date] DATE NOT NULL
)
GO

-- �Ы� nutrition_record ��
CREATE TABLE [nutrition_record] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [user_id] INT NOT NULL,
  [food_name] NVARCHAR(255) NOT NULL,
  [calories] INT NOT NULL,
  [protein] FLOAT NOT NULL,
  [carbs] FLOAT NOT NULL,
  [fats] FLOAT NOT NULL,
  [mealtime] NVARCHAR(50) CHECK ([mealtime] IN ('breakfast', 'lunch', 'dinner', 'snack')),
  [date_recorded] DATETIME DEFAULT GETDATE()
)
GO

-- �Ы� fitness_goal ��
CREATE TABLE [fitness_goal] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [user_id] INT NOT NULL,
  [type] NVARCHAR(50) CHECK ([type] IN ('weight_loss', 'muscle_gain', 'cardio', 'other')),
  [target_value] FLOAT NOT NULL,
  [current_progress] FLOAT DEFAULT 0,
  [unit] NVARCHAR(20) CHECK ([unit] IN ('kg', '%', 'min', 'cal')),
  [start_date] DATETIME DEFAULT GETDATE(),
  [end_date] DATETIME NULL,
  [status] NVARCHAR(20) CHECK ([status] IN ('in_progress', 'completed', 'failed')) DEFAULT 'in_progress',
  [frequency_goal] INT NULL,
  [frequency_duration] INT NULL,
  [reference_table] NVARCHAR(50) CHECK ([reference_table] IN ('exercise_record', 'body_metric')),
  CONSTRAINT [CK_end_date] CHECK (end_date IS NULL OR end_date >= start_date)
)
GO

-- �Ы� achievement ��
CREATE TABLE [achievement] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [user_id] INT NOT NULL,
  [type] NVARCHAR(50) CHECK ([type] IN ('goal_completed', 'general_reward')),
  [title] NVARCHAR(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [description] NVARCHAR(500),
  [date_achieved] DATETIME DEFAULT GETDATE(),
  CONSTRAINT [UC_unique_achievement] UNIQUE ([user_id], [title])
)
GO

-- �Ы� exercise_type_coefficient ��
CREATE TABLE [exercise_type_coefficient] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [name] NVARCHAR(50) NOT NULL,
  [met] DECIMAL(5,2) NOT NULL
)
GO

-- �Ы� social_post ��
CREATE TABLE [social_post] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [category] NVARCHAR(10) NOT NULL,
  [title] NVARCHAR(255) NOT NULL,
  [content] NVARCHAR(2000) NOT NULL,
  [user_id] INT NOT NULL,
  [created_at] DATETIME DEFAULT CURRENT_TIMESTAMP,
  [updated_at] DATETIME DEFAULT CURRENT_TIMESTAMP
)
GO

-- �Ы� comment ��
CREATE TABLE [comment] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [post_id] INT NOT NULL,
  [user_id] INT NOT NULL,
  [text] NVARCHAR(1000) NOT NULL,
  [created_at] DATETIME DEFAULT CURRENT_TIMESTAMP,
  [updated_at] DATETIME DEFAULT CURRENT_TIMESTAMP
)
GO

-- �K�[�~�����
ALTER TABLE [user_point] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([id])
GO

ALTER TABLE [order] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([id])
GO

ALTER TABLE [order_item] ADD FOREIGN KEY ([order_id]) REFERENCES [order] ([id])
GO

ALTER TABLE [order_item] ADD FOREIGN KEY ([product_id]) REFERENCES [product] ([id])
GO

ALTER TABLE [order_item] ADD FOREIGN KEY ([course_id]) REFERENCES [course] ([id])
GO

ALTER TABLE [cart_item] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([id])
GO

ALTER TABLE [cart_item] ADD FOREIGN KEY ([product_id]) REFERENCES [product] ([id])
GO

ALTER TABLE [cart_item] ADD FOREIGN KEY ([course_id]) REFERENCES [course] ([id])
GO

ALTER TABLE [exercise_record] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([id])
GO

ALTER TABLE [social_post] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([id])
GO

ALTER TABLE [comment] ADD FOREIGN KEY ([post_id]) REFERENCES [social_post] ([id])
GO

ALTER TABLE [comment] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([id])
GO

ALTER TABLE [body_metric] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([id]) ON DELETE CASCADE
GO

ALTER TABLE [nutrition_record] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([id]) ON DELETE CASCADE
GO

ALTER TABLE [fitness_goal] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([id]) ON DELETE CASCADE
GO

ALTER TABLE [achievement] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([id]) ON DELETE CASCADE
GO

ALTER TABLE [course] ADD FOREIGN KEY ([coach_id]) REFERENCES [coach] ([id]) ON DELETE CASCADE
GO

ALTER TABLE [course_registration] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([id]) ON DELETE CASCADE
GO

ALTER TABLE [course_registration] ADD FOREIGN KEY ([course_id]) REFERENCES [course] ([id]) ON DELETE CASCADE
GO

-- �Ыص���
CREATE VIEW dashboard_stat AS
SELECT 
    (SELECT COUNT(*) FROM [user] WHERE role = 'user') AS total_users,
    (SELECT COUNT(*) FROM exercise_record) AS total_workouts,
    (SELECT SUM(duration) FROM exercise_record) AS total_workout_minutes,
    (SELECT SUM(calories_burned) FROM exercise_record) AS total_calories_burned,
    (SELECT COUNT(*) FROM [user] WHERE DATEDIFF(DAY, last_login, GETDATE()) <= 7) AS active_users_this_week;
GO

-- ���J���ռƾ�
-- ���J user �ƾ� (20��)
INSERT INTO [user] ([name], [email], [password_hash], [gender], [bio], [role], [last_login])
VALUES
('�i�T', 'zhangsan@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'M', '���R�������W�Z��', 'user', '2023-01-15 09:30:00'),
('���|', 'lisi@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'M', '�����нm', 'admin', '2023-01-16 10:15:00'),
('����', 'wangwu@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'F', '����R�n��', 'user', '2023-01-17 14:20:00'),
('����', 'zhaoliu@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'F', '��i�v', 'user', '2023-01-18 16:45:00'),
('���C', 'qianqi@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'M', '���ԪQ�]��', 'user', '2023-01-19 08:10:00'),
('�]�K', 'sunba@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'F', '�����s��', 'user', '2023-01-20 11:30:00'),
('�P�E', 'zhoujiu@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'M', '���q�V�m�R�n��', 'user', '2023-01-21 13:15:00'),
('�d�Q', 'wushi@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'F', '�R�ЦѮv', 'user', '2023-01-22 15:40:00'),
('�G�Q�@', 'zhengshiyi@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'M', '��a���N', 'user', '2023-01-23 17:25:00'),
('���Q�G', 'wangshier@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'F', '��������', 'user', '2023-01-24 19:00:00'),
('�L�Q�T', 'linshisan@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'M', '���������M�a', 'user', '2023-01-25 20:35:00'),
('���Q�|', 'chenshisi@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'F', '��i�ǳդh', 'user', '2023-01-26 09:50:00'),
('���Q��', 'huangshiwu@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'M', '�����нm', 'admin', '2023-01-27 11:15:00'),
('�B�Q��', 'liushiliu@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'F', '����ɮv', 'user', '2023-01-28 14:30:00'),
('���Q�C', 'gaoshiqi@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'M', '��������������', 'user', '2023-01-29 16:45:00'),
('�¤Q�K', 'xieshiba@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'F', '������i�U��', 'user', '2023-01-30 18:10:00'),
('ù�Q�E', 'luoshijiu@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'M', '����������', 'user', '2023-01-31 20:35:00'),
('���G�Q', 'caiershi@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'F', '�����үS��', 'user', '2023-02-01 09:00:00'),
('���ܤ@', 'yenianyi@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'M', '����������o', 'user', '2023-02-02 11:25:00'),
('�\�ܤG', 'xunianer@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'F', '������i�~�P��', 'user', '2023-02-03 13:50:00')
GO

-- ���J user_point �ƾ� (20��)
INSERT INTO [user_point] ([user_id], [points], [last_updated])
VALUES
(1, 100, '2023-01-15 09:30:00'),
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

-- ���J coach �ƾ� (20��)
INSERT INTO [coach] ([name], [expertise])
VALUES
('���нm', '���q�V�m'),
('���нm', '����B��'),
('�i�нm', '���'),
('���нm', '����'),
('�L�нm', '��a'),
('���нm', '�R��'),
('�d�нm', '�\��ʰV�m'),
('�B�нm', 'HIIT'),
('���нm', '���Դ�'),
('�G�нm', '���V�m'),
('�P�нm', 'TRX'),
('���нm', 'CrossFit'),
('�±нm', '��������'),
('ù�нm', '�ӷ�'),
('���нm', '��R'),
('�\�нm', '����'),
('�}�нm', '��h�R'),
('Ĭ�нm', '�{�N�R'),
('�^�нm', '���ڻR'),
('���нm', '�{�ֻR')
GO

-- ���J product �ƾ� (20��)
INSERT INTO [product] ([name], [description], [price], [stock_quantity], [image_url])
VALUES
('�J�կ�', '�ŲM�J�կ��A���J�O�f��', 1200.00, 100, 'https://example.com/protein.jpg'),
('������M', '���Ƴz�𰷨���M', 450.00, 50, 'https://example.com/gloves.jpg'),
('�����', '�[�p���Ʒ����', 800.00, 30, 'https://example.com/mat.jpg'),
('�׹a��', '�i�ո`���q�׹a��', 2500.00, 20, 'https://example.com/dumbbell.jpg'),
('�u�O�a', '5�ت��O�u�O�a��', 600.00, 40, 'https://example.com/band.jpg'),
('��÷', '�v�t��÷', 300.00, 60, 'https://example.com/rope.jpg'),
('�����y�a', '�|���y�a', 900.00, 25, 'https://example.com/belt.jpg'),
('�B�ʤ���', '750ml�B�ʤ���', 350.00, 80, 'https://example.com/bottle.jpg'),
('�����A�M��', '�z��Ʀ������A', 1200.00, 35, 'https://example.com/clothes.jpg'),
('�B����', '���ƹB����3����', 250.00, 90, 'https://example.com/socks.jpg'),
('�����I�]', '�h�\�ష���I�]', 1500.00, 15, 'https://example.com/bag.jpg'),
('�����u��', '���K�תw�j�u��', 700.00, 30, 'https://example.com/roller.jpg'),
('�B�ʤ�y', '�t���B�ʤ�y', 200.00, 70, 'https://example.com/towel.jpg'),
('������x', '�����O����', 180.00, 50, 'https://example.com/journal.jpg'),
('�߲v��', '�Ť��߲v�ʴ���', 2800.00, 10, 'https://example.com/watch.jpg'),
('����APP�|��', '�@�~������APP�|��', 1200.00, 999, 'https://example.com/app.jpg'),
('�B�ʦվ�', '�L�u�B�ʦվ�', 1600.00, 20, 'https://example.com/earphone.jpg'),
('�����ҵ{DVD', '���M�����ҵ{DVD', 950.00, 15, 'https://example.com/dvd.jpg'),
('�������y', '������i����', 550.00, 25, 'https://example.com/book.jpg'),
('�B���@��', '�伵���B���@��', 380.00, 40, 'https://example.com/wristband.jpg')
GO

-- ���J course �ƾ� (20��)
INSERT INTO [course] ([name], [description], [date], [coach_id], [duration], [max_capacity])
VALUES
('��ŷ��', '�A�X��Ǫ̪�����ҵ{', '2023-03-01', 3, 60, 15),
('���q�V�m�J��', '�ǲ߰򥻭��q�V�m�ޥ�', '2023-03-02', 1, 90, 10),
('����R��', '�U�צ���R�нҵ{', '2023-03-03', 6, 60, 20),
('���j�׶����V�m', 'HIIT���j�׶����V�m', '2023-03-04', 8, 45, 12),
('���Դ��֤߰V�m', '�j�Ʈ֤ߦٸs�����Դ�', '2023-03-05', 9, 60, 15),
('��������', '���X����������B��', '2023-03-06', 4, 60, 12),
('TRX�����V�m', '�a�Q�V�m�t�νҵ{', '2023-03-07', 11, 60, 10),
('�\��ʰV�m', '���ɤ�`�\��ʪ��V�m', '2023-03-08', 7, 60, 12),
('��a�ޥ�', '���ɴ�a�ޥ����ҵ{', '2023-03-09', 5, 90, 8),
('�R�а�¦', '�U�ػR�а�¦�V�m', '2023-03-10', 6, 60, 15),
('�i�����', '�A�X���g��̪����', '2023-03-11', 3, 75, 12),
('���q�V�m�i��', '�i�����q�V�m�ޥ�', '2023-03-12', 1, 90, 8),
('����i��', '�U�צ���i���ҵ{', '2023-03-13', 13, 60, 15),
('CrossFit��¦', 'CrossFit��¦�V�m', '2023-03-14', 12, 90, 10),
('�ӷ��i��', '�ӷ��i�ͽҵ{', '2023-03-15', 14, 60, 15),
('��R�J��', '��R��¦�ҵ{', '2023-03-16', 15, 60, 15),
('�������', '�����R��νҵ{', '2023-03-17', 16, 60, 12),
('��h�R', '��h�R�ҵ{', '2023-03-18', 17, 60, 15),
('�{�N�R', '�{�N�R�ҵ{', '2023-03-19', 18, 60, 12),
('�{�ֻR', '�{�ֻR�ҵ{', '2023-03-20', 20, 60, 15)
GO

-- ���J order �ƾ� (20��)
INSERT INTO [order] ([user_id], [total_amount], [status], [created_at])
VALUES
(1, 1200.00, 'completed', '2023-02-01 10:00:00'),
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

-- ���J order_item �ƾ� (20��)
INSERT INTO [order_item] ([order_id], [product_id], [course_id], [quantity], [subtotal])
VALUES
(1, 1, NULL, 1, 1200.00),
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

-- ���J cart_item �ƾ� (20��)
INSERT INTO [cart_item] ([user_id], [product_id], [course_id], [quantity], [added_at])
VALUES
(1, 1, NULL, 1, '2023-02-21 10:00:00'),
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

-- ���J body_metric �ƾ� (20��)
INSERT INTO [body_metric] ([user_id], [weight], [body_fat], [muscle_mass], [waist_circumference], [hip_circumference], [height], [date_recorded])
VALUES
(1, 70.5, 15.0, 30.5, 80.0, 95.0, 175.0, '2023-02-01 10:00:00'),
(2, 65.2, 18.2, 29.3, 78.0, 92.5, 168.0, '2023-02-02 11:15:00'),
(3, 80.3, 22.5, 32.0, 85.0, 100.0, 180.0, '2023-02-03 14:30:00'),
(4, 55.0, 12.5, 24.5, 70.0, 88.0, 160.0, '2023-02-04 16:45:00'),
(5, 90.0, 25.0, 40.0, 90.0, 105.0, 185.0, '2023-02-05 08:10:00'),
(6, 68.0, 16.0, 28.0, 77.0, 93.0, 172.0, '2023-02-06 11:30:00'),
(7, 72.3, 19.0, 31.0, 82.0, 96.0, 178.0, '2023-02-07 13:15:00'),
(8, 58.5, 14.0, 26.5, 75.0, 90.0, 165.0, '2023-02-08 15:40:00'),
(9, 77.0, 21.5, 35.0, 84.0, 98.0, 182.0, '2023-02-09 17:25:00'),
(10, 64.5, 17.5, 27.0, 76.5, 91.5, 170.0, '2023-02-10 19:00:00'),
(11, 71.0, 15.5, 30.0, 81.0, 96.0, 176.0, '2023-02-11 20:35:00'),
(12, 66.0, 17.0, 28.5, 79.0, 94.0, 173.0, '2023-02-12 09:50:00'),
(13, 83.0, 23.0, 33.0, 86.0, 101.0, 181.0, '2023-02-13 11:15:00'),
(14, 56.0, 13.0, 25.0, 71.0, 89.0, 161.0, '2023-02-14 14:30:00'),
(15, 89.0, 24.5, 39.0, 89.0, 104.0, 184.0, '2023-02-15 16:45:00'),
(16, 67.0, 15.5, 27.5, 78.0, 94.0, 173.0, '2023-02-16 18:10:00'),
(17, 73.0, 19.5, 31.5, 83.0, 97.0, 179.0, '2023-02-17 20:35:00'),
(18, 59.0, 14.5, 27.0, 76.0, 91.0, 166.0, '2023-02-18 09:00:00'),
(19, 78.0, 22.0, 36.0, 85.0, 99.0, 183.0, '2023-02-19 11:25:00'),
(20, 65.0, 18.0, 28.0, 77.0, 92.0, 171.0, '2023-02-20 13:50:00')
GO

-- ���J exercise_record �ƾ� (20��)
INSERT INTO [exercise_record] ([user_id], [exercise_type], [duration], [calories_burned], [date])
VALUES
(1, 'weight_training', 60, 300.00, '2023-02-01'),
(2, 'yoga', 45, 200.00, '2023-02-02'),
(3, 'running', 30, 250.00, '2023-02-03'),
(4, 'swimming', 60, 400.00, '2023-02-04'),
(5, 'cycling', 45, 350.00, '2023-02-05'),
(6, 'hiit', 30, 300.00, '2023-02-06'),
(7, 'weight_training', 60, 320.00, '2023-02-07'),
(8, 'yoga', 45, 210.00, '2023-02-08'),
(9, 'running', 30, 260.00, '2023-02-09'),
(10, 'swimming', 60, 410.00, '2023-02-10'),
(11, 'cycling', 45, 360.00, '2023-02-11'),
(12, 'hiit', 30, 310.00, '2023-02-12'),
(13, 'weight_training', 60, 330.00, '2023-02-13'),
(14, 'yoga', 45, 220.00, '2023-02-14'),
(15, 'running', 30, 270.00, '2023-02-15'),
(16, 'swimming', 60, 420.00, '2023-02-16'),
(17, 'cycling', 45, 370.00, '2023-02-17'),
(18, 'hiit', 30, 320.00, '2023-02-18'),
(19, 'weight_training', 60, 340.00, '2023-02-19'),
(20, 'yoga', 45, 230.00, '2023-02-20')
GO

-- ���J nutrition_record �ƾ� (20��)
INSERT INTO [nutrition_record] ([user_id], [food_name], [calories], [protein], [carbs], [fats], [mealtime], [date_recorded])
VALUES
(1, '���ݦ�', 200, 40.0, 0.0, 5.0, 'lunch', '2023-02-01 12:00:00'),
(2, '�W�̶�', 150, 3.0, 30.0, 1.0, 'dinner', '2023-02-02 18:30:00'),
(3, '���N�J', 70, 6.0, 0.6, 5.0, 'breakfast', '2023-02-03 08:00:00'),
(4, '����F��', 100, 2.0, 10.0, 5.0, 'lunch', '2023-02-04 12:30:00'),
(5, '�D��', 250, 25.0, 0.0, 15.0, 'dinner', '2023-02-05 19:00:00'),
(6, '�����R�q', 120, 4.0, 20.0, 2.0, 'breakfast', '2023-02-06 08:30:00'),
(7, '����', 300, 35.0, 0.0, 18.0, 'lunch', '2023-02-07 13:00:00'),
(8, '�a��', 130, 2.0, 30.0, 0.2, 'dinner', '2023-02-08 18:00:00'),
(9, '��þ�u��', 150, 15.0, 8.0, 5.0, 'breakfast', '2023-02-09 09:00:00'),
(10, '���רF�ԤT���v', 350, 25.0, 30.0, 12.0, 'lunch', '2023-02-10 12:15:00'),
(11, '�q�j�Q��', 400, 15.0, 60.0, 10.0, 'dinner', '2023-02-11 19:30:00'),
(12, '�P����', 180, 6.0, 30.0, 3.0, 'breakfast', '2023-02-12 08:45:00'),
(13, '����', 450, 40.0, 0.0, 30.0, 'lunch', '2023-02-13 13:30:00'),
(14, '�N����', 120, 3.0, 15.0, 5.0, 'dinner', '2023-02-14 18:15:00'),
(15, '���G�F��', 150, 1.0, 35.0, 0.5, 'breakfast', '2023-02-15 09:30:00'),
(16, '���ת���', 400, 25.0, 45.0, 12.0, 'lunch', '2023-02-16 12:45:00'),
(17, '�N�D��', 300, 30.0, 0.0, 18.0, 'dinner', '2023-02-17 19:45:00'),
(18, '�J�շλ�', 200, 20.0, 15.0, 5.0, 'breakfast', '2023-02-18 09:15:00'),
(19, '���׺~��', 500, 30.0, 40.0, 25.0, 'lunch', '2023-02-19 13:15:00'),
(20, '�����', 150, 5.0, 20.0, 5.0, 'dinner', '2023-02-20 18:30:00')
GO

-- ���J fitness_goal �ƾ� (20��)
INSERT INTO [fitness_goal] ([user_id], [type], [target_value], [current_progress], [unit], [start_date], [end_date], [status], [frequency_goal], [frequency_duration], [reference_table])
VALUES
(1, 'weight_loss', 5.0, 2.5, 'kg', '2023-01-01', '2023-04-01', 'in_progress', 3, 12, 'body_metric'),
(2, 'muscle_gain', 3.0, 1.5, 'kg', '2023-01-15', '2023-04-15', 'in_progress', 4, 12, 'body_metric'),
(3, 'cardio', 30.0, 15.0, 'min', '2023-02-01', '2023-05-01', 'in_progress', 5, 12, 'exercise_record'),
(4, 'weight_loss', 4.0, 1.0, 'kg', '2023-01-20', '2023-04-20', 'in_progress', 3, 12, 'body_metric'),
(5, 'muscle_gain', 5.0, 2.0, 'kg', '2023-02-01', '2023-05-01', 'in_progress', 4, 12, 'body_metric'),
(6, 'cardio', 20.0, 10.0, 'min', '2023-02-05', '2023-05-05', 'in_progress', 3, 12, 'exercise_record'),
(7, 'weight_loss', 3.0, 1.5, 'kg', '2023-01-10', '2023-04-10', 'in_progress', 4, 12, 'body_metric'),
(8, 'muscle_gain', 2.0, 0.5, 'kg', '2023-01-25', '2023-04-25', 'in_progress', 3, 12, 'body_metric'),
(9, 'cardio', 25.0, 12.5, 'min', '2023-02-10', '2023-05-10', 'in_progress', 4, 12, 'exercise_record'),
(10, 'weight_loss', 6.0, 3.0, 'kg', '2023-01-05', '2023-04-05', 'in_progress', 5, 12, 'body_metric'),
(11, 'muscle_gain', 4.0, 2.0, 'kg', '2023-02-15', '2023-05-15', 'in_progress', 3, 12, 'body_metric'),
(12, 'cardio', 15.0, 7.5, 'min', '2023-02-20', '2023-05-20', 'in_progress', 4, 12, 'exercise_record'),
(13, 'weight_loss', 5.0, 2.0, 'kg', '2023-01-15', '2023-04-15', 'in_progress', 3, 12, 'body_metric'),
(14, 'muscle_gain', 3.0, 1.0, 'kg', '2023-02-01', '2023-05-01', 'in_progress', 4, 12, 'body_metric'),
(15, 'cardio', 30.0, 15.0, 'min', '2023-02-05', '2023-05-05', 'in_progress', 5, 12, 'exercise_record'),
(16, 'weight_loss', 4.0, 2.0, 'kg', '2023-01-20', '2023-04-20', 'in_progress', 3, 12, 'body_metric'),
(17, 'muscle_gain', 5.0, 2.5, 'kg', '2023-02-10', '2023-05-10', 'in_progress', 4, 12, 'body_metric'),
(18, 'cardio', 20.0, 10.0, 'min', '2023-02-15', '2023-05-15', 'in_progress', 3, 12, 'exercise_record'),
(19, 'weight_loss', 3.0, 1.5, 'kg', '2023-01-25', '2023-04-25', 'in_progress', 4, 12, 'body_metric'),
(20, 'muscle_gain', 4.0, 2.0, 'kg', '2023-02-20', '2023-05-20', 'in_progress', 3, 12, 'body_metric')
GO

-- ���J achievement �ƾ� (20��)
INSERT INTO [achievement] ([user_id], [type], [title], [description], [date_achieved])
VALUES
(1, 'goal_completed', '�5����F��', '���\�F����ؼ�', '2023-01-15 10:00:00'),
(2, 'general_reward', '�s�򥴥d7��', '�s��7�ѧ����B�ʥ��d', '2023-01-16 11:15:00'),
(3, 'goal_completed', '�]�B30�����F��', '���\�F���]�B�ؼ�', '2023-01-17 14:30:00'),
(4, 'general_reward', '�ʶR�Ĥ@��ҵ{', '�����ʶR�����ҵ{', '2023-01-18 16:45:00'),
(5, 'goal_completed', '�W��3����F��', '���\�F���W�٥ؼ�', '2023-01-19 08:10:00'),
(6, 'general_reward', '�s�򥴥d14��', '�s��14�ѧ����B�ʥ��d', '2023-01-20 11:30:00'),
(7, 'goal_completed', '��׭���15%', '���\�F����ץؼ�', '2023-01-21 13:15:00'),
(8, 'general_reward', '����10���V�m', '����10�������V�m', '2023-01-22 15:40:00'),
(9, 'goal_completed', '��a1�����F��', '���\�F����a�ؼ�', '2023-01-23 17:25:00'),
(10, 'general_reward', '�ʶR�Ĥ@��ӫ~', '�����ʶR�����ӫ~', '2023-01-24 19:00:00'),
(11, 'goal_completed', '�`��100����', '���\�F���`�ۥؼ�', '2023-01-25 20:35:00'),
(12, 'general_reward', '�s�򥴥d21��', '�s��21�ѧ����B�ʥ��d', '2023-01-26 09:50:00'),
(13, 'goal_completed', '�ױ�80����', '���\�F���ױ��ؼ�', '2023-01-27 11:15:00'),
(14, 'general_reward', '����20���V�m', '����20�������V�m', '2023-01-28 14:30:00'),
(15, 'goal_completed', '�w�|120����', '���\�F���w�|�ؼ�', '2023-01-29 16:45:00'),
(16, 'general_reward', '�s�򥴥d30��', '�s��30�ѧ����B�ʥ��d', '2023-01-30 18:10:00'),
(17, 'goal_completed', '��׭���12%', '���\�F����ץؼ�', '2023-01-31 20:35:00'),
(18, 'general_reward', '����30���V�m', '����30�������V�m', '2023-02-01 09:00:00'),
(19, 'goal_completed', '�W��5����F��', '���\�F���W�٥ؼ�', '2023-02-02 11:25:00'),
(20, 'general_reward', '�ʶR5��ӫ~', '�֭p�ʶR5�󰷨��ӫ~', '2023-02-03 13:50:00')
GO

-- ���J exercise_type_coefficient �ƾ� (20��)
INSERT INTO [exercise_type_coefficient] ([name], [met])
VALUES
('weight_training', 6.0),
('yoga', 2.5),
('running', 7.0),
('swimming', 8.0),
('cycling', 6.5),
('hiit', 9.0),
('walking', 3.0),
('dancing', 5.0),
('boxing', 8.5),
('pilates', 3.5),
('crossfit', 9.5),
('jumping_rope', 8.0),
('rowing', 7.5),
('stair_climbing', 6.0),
('elliptical', 5.5),
('kickboxing', 8.0),
('zumba', 5.0),
('tai_chi', 2.0),
('circuit_training', 7.0),
('functional_training', 6.5)
GO

-- ���J social_post �ƾ� (20��)
INSERT INTO [social_post] ([category], [title], [content], [user_id], [created_at], [updated_at])
VALUES
('fitness', '�ڪ������ȵ{', '���ɧڱq�}�l������{�b���߱o...', 1, '2023-02-01 10:00:00', '2023-02-01 10:00:00'),
('nutrition', '���d������ĳ', '���ɤ@�ǧڻ{���ܦ��Ī����d������k...', 2, '2023-02-02 11:15:00', '2023-02-02 11:15:00'),
('recipe', '���J�զ��\����', '�o�O�ڨC�Ѧ��W���|�Y�����J�զ��\...', 3, '2023-02-03 14:30:00', '2023-02-03 14:30:00'),
('fitness', '���q�V�m�ޥ�', '���ɤ@�ǭ��q�V�m���򥻧ޥ�...', 4, '2023-02-04 16:45:00', '2023-02-04 16:45:00'),
('motivation', '����B�ʪ����Z', '�p��O���B�ʲߺD�����_...', 5, '2023-02-05 08:10:00', '2023-02-05 08:10:00'),
('nutrition', '�W�ٶ����p��', '�ڪ��W�ٶ����p������...', 6, '2023-02-06 11:30:00', '2023-02-06 11:30:00'),
('fitness', '�b�a�������n', '�S���ɶ��h�����СH�b�a�]�঳�İ���...', 7, '2023-02-07 13:15:00', '2023-02-07 13:15:00'),
('recipe', '����\����', '���ɧڪ�����\����...', 8, '2023-02-08 15:40:00', '2023-02-08 15:40:00'),
('fitness', '�]�B�V�m�p��', '�ڪ��b���V�m�p������...', 9, '2023-02-09 17:25:00', '2023-02-09 17:25:00'),
('motivation', '�J�A���x��', '�p��J�A�������x��...', 10, '2023-02-10 19:00:00', '2023-02-10 19:00:00'),
('nutrition', '�B�ʫ�ɥR', '�B�ʫ�Ӧp�󥿽T�ɥR��i...', 11, '2023-02-11 20:35:00', '2023-02-11 20:35:00'),
('fitness', '�֤߰V�m���n', '�j�Ʈ֤ߦٸs���V�m��k...', 12, '2023-02-12 09:50:00', '2023-02-12 09:50:00'),
('recipe', '���d�I�߭���', '���ɴX�ڰ��d���I�߭���...', 13, '2023-02-13 11:15:00', '2023-02-13 11:15:00'),
('fitness', '�u�O�a�V�m', '�p��μu�O�a�i������V�m...', 14, '2023-02-14 14:30:00', '2023-02-14 14:30:00'),
('motivation', '�]�w�����ؼ�', '�p��]�w�X�z�������ؼ�...', 15, '2023-02-15 16:45:00', '2023-02-15 16:45:00'),
('nutrition', '�J�ս�������n', '�C�Ѹ�����h�ֳJ�ս�...', 16, '2023-02-16 18:10:00', '2023-02-16 18:10:00'),
('fitness', '�׹a�V�m�p��', '�ڪ��׹a�����V�m�p��...', 17, '2023-02-17 20:35:00', '2023-02-17 20:35:00'),
('recipe', '�W���\����', '���ɧڪ��W���\����...', 18, '2023-02-18 09:00:00', '2023-02-18 09:00:00'),
('fitness', 'HIIT�V�m���n', '���j�׶����V�m���`�N�ƶ�...', 19, '2023-02-19 11:25:00', '2023-02-19 11:25:00'),
('motivation', '�O���B�ʼ���', '�p������O���B�ʼ���...', 20, '2023-02-20 13:50:00', '2023-02-20 13:50:00')
GO

-- ���J comment �ƾ� (20��)
INSERT INTO [comment] ([post_id], [user_id], [text], [created_at], [updated_at])
VALUES
(1, 2, '�g�o�u�n�A�ڤ]�n�}�l�����F�I', '2023-02-01 11:00:00', '2023-02-01 11:00:00'),
(2, 3, '�o�Ƕ�����ĳ�ܹ�ΡA���¤��ɡI', '2023-02-02 12:15:00', '2023-02-02 12:15:00'),
(3, 4, '���ѴN�Ӹոճo�ӭ��СI', '2023-02-03 15:30:00', '2023-02-03 15:30:00'),
(4, 5, '���q�V�m���ޥ��ܱM�~�I', '2023-02-04 17:45:00', '2023-02-04 17:45:00'),
(5, 6, '����B�ʯu���ܭ��n�I', '2023-02-05 09:10:00', '2023-02-05 09:10:00'),
(6, 7, '�W�ٶ����p���ܸԲӡI', '2023-02-06 12:30:00', '2023-02-06 12:30:00'),
(7, 8, '�b�a���������n�ܹ�ΡI', '2023-02-07 14:15:00', '2023-02-07 14:15:00'),
(8, 9, '����\�ݰ_�ӫܦn�Y�I', '2023-02-08 16:40:00', '2023-02-08 16:40:00'),
(9, 10, '�]�B�p���ܬ�ǡI', '2023-02-09 18:25:00', '2023-02-09 18:25:00'),
(10, 11, '�J�A���x������k�ܦ����U�I', '2023-02-10 20:00:00', '2023-02-10 20:00:00'),
(11, 12, '�B�ʫ�ɥR����ĳ�ܱM�~�I', '2023-02-11 21:35:00', '2023-02-11 21:35:00'),
(12, 13, '�֤߰V�m����k�ܦ��ġI', '2023-02-12 10:50:00', '2023-02-12 10:50:00'),
(13, 14, '���d�I�߭��ЫܾA�X�ڡI', '2023-02-13 12:15:00', '2023-02-13 12:15:00'),
(14, 15, '�u�O�a�V�m�ܤ�K�I', '2023-02-14 15:30:00', '2023-02-14 15:30:00'),
(15, 16, '�]�w�ؼЯu���ܭ��n�I', '2023-02-15 17:45:00', '2023-02-15 17:45:00'),
(16, 17, '�J�ս���������n�ܸԲӡI', '2023-02-16 19:10:00', '2023-02-16 19:10:00'),
(17, 18, '�׹a�V�m�p���ܥ����I', '2023-02-17 21:35:00', '2023-02-17 21:35:00'),
(18, 19, '�W���\�ݰ_�ӫܬ����I', '2023-02-18 10:00:00', '2023-02-18 10:00:00'),
(19, 20, 'HIIT�V�m�u���ܦ��ġI', '2023-02-19 12:25:00', '2023-02-19 12:25:00'),
(20, 1, '�O���B�ʼ�������k�ܴΡI', '2023-02-20 14:50:00', '2023-02-20 14:50:00')
GO