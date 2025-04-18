/*
    注意：user表格的插入數據是程式自動生成，user表要有數據才能執行part2! 不然就會報錯!
    如果不想插入測試數據可以先不執行part2!
*/

USE HealthManagement;
GO

-- 創建 users 表
CREATE TABLE [users]
(
    [user_id]       INT PRIMARY KEY IDENTITY (1, 1),                 -- 自動遞增主鍵
    [name]          NVARCHAR(50)  NOT NULL,                          -- 使用者名稱
    [email]         NVARCHAR(100) NOT NULL,                          -- 電子郵件
    [password_hash] VARCHAR(255)  NOT NULL,                          -- 密碼哈希
    [gender]        CHAR(1),                                         -- 性別，例如 'M' 或 'F'
    [bio]           NVARCHAR(MAX),                                   -- 個人簡介
    [role]          VARCHAR(10) CHECK (role IN ('user', 'admin')),   -- 角色
    [user_points]   INT           NOT NULL DEFAULT 0,                -- 使用者點數
    [last_login]    DATETIME               DEFAULT CURRENT_TIMESTAMP -- 最後登入時間
);
GO

-- 創建 user_point 表
CREATE TABLE [user_point]
(
    [user_id]      INT PRIMARY KEY,
    [points]       INT DEFAULT (0),
    [last_updated] DATETIME
);
GO

-- 創建 product 表
CREATE TABLE [product]
(
    [id]             INT PRIMARY KEY IDENTITY (1, 1),
    [name]           NVARCHAR(255)  NOT NULL,
    [description]    NVARCHAR(1000),
    [price]          DECIMAL(10, 2) NOT NULL,
    [stock_quantity] INT            NOT NULL DEFAULT (0),
    [category]       NVARCHAR(100), -- 添加 category 欄位
    [image_url]      NVARCHAR(MAX), -- 修改為NVARCHAR(MAX)以支持更長的URL
    [created_at]     DATETIME                DEFAULT CURRENT_TIMESTAMP,
    [updated_at]     DATETIME                DEFAULT CURRENT_TIMESTAMP
);
GO

-- 創建 coach 表
CREATE TABLE [coach]
(
    [id]        INT PRIMARY KEY IDENTITY (1, 1),
    [name]      NVARCHAR(255) NOT NULL,
    [expertise] NVARCHAR(255)
);
GO

-- 創建 course 表
CREATE TABLE [course]
(
    [id]           INT PRIMARY KEY IDENTITY (1, 1),
    [name]         NVARCHAR(255)  NOT NULL,
    [description]  NVARCHAR(1000) NOT NULL,
    [date]         DATE           NOT NULL,
    [coach_id]     INT            NOT NULL,
    [duration]     INT            NOT NULL,
    [max_capacity] INT            NOT NULL
);
GO

-- 創建 order 表
CREATE TABLE [order]
(
    [id]           INT PRIMARY KEY IDENTITY (1, 1),
    [user_id]      INT            NOT NULL,
    [total_amount] DECIMAL(10, 2) NOT NULL,
    [status]       NVARCHAR(50) DEFAULT 'pending',
    [created_at]   DATETIME     DEFAULT CURRENT_TIMESTAMP
);
GO

-- 創建 order_item 表
CREATE TABLE [order_item]
(
    [id]         INT PRIMARY KEY IDENTITY (1, 1),
    [order_id]   INT            NOT NULL,
    [product_id] INT,
    [quantity]   INT            NOT NULL DEFAULT (1),
    [subtotal]   DECIMAL(10, 2) NOT NULL
);
GO

-- 創建 cart_item 表
CREATE TABLE [cart_item]
(
    [id]         INT PRIMARY KEY IDENTITY (1, 1),
    [user_id]    INT NOT NULL,
    [product_id] INT,
    [quantity]   INT NOT NULL DEFAULT (1),
    [added_at]   DATETIME     DEFAULT CURRENT_TIMESTAMP
);
GO

-- 創建 payment 表
CREATE TABLE [payment]
(
    [id]            NVARCHAR(36) PRIMARY KEY, -- UUID格式
    [order_id]      INT            NOT NULL,
    [amount]        DECIMAL(10, 2) NOT NULL,
    [currency]      NVARCHAR(10) DEFAULT 'TWD',
    [method]        NVARCHAR(50)   NOT NULL,
    [status]        NVARCHAR(50) DEFAULT 'PENDING',
    [created_at]    DATETIME     DEFAULT CURRENT_TIMESTAMP,
    [paid_at]       DATETIME       NULL,
    [error_message] NVARCHAR(500)  NULL
);
GO

-- 創建 exercise_type_coefficients 表
CREATE TABLE [exercise_type_coefficients]
(
    [exercise_type_id] INT PRIMARY KEY IDENTITY (1, 1),
    [exercise_name]    NVARCHAR(50) NOT NULL,
    [met]              FLOAT        NOT NULL
);
GO

-- 創建 body_metrics 表
CREATE TABLE [body_metrics]
(
    [id]                  INT PRIMARY KEY IDENTITY (1, 1),
    [user_id]             INT   NOT NULL FOREIGN KEY REFERENCES [users] ([user_id]) ON DELETE CASCADE,
    [weight]              FLOAT NOT NULL,
    [body_fat]            FLOAT,
    [muscle_mass]         FLOAT,
    [waist_circumference] FLOAT,
    [hip_circumference]   FLOAT,
    [height]              FLOAT,
    [bmi]                 FLOAT,
    [date_recorded]       DATE DEFAULT GETDATE()
);
GO

-- 創建 exercise_records 表
CREATE TABLE [exercise_records]
(
    [record_id]         INT PRIMARY KEY IDENTITY (1, 1),
    [user_id]           INT          NOT NULL FOREIGN KEY REFERENCES [users] ([user_id]) ON DELETE CASCADE,
    [exercise_type]     NVARCHAR(50) NOT NULL,
    [exercise_duration] INT          NOT NULL,
    [calories_burned]   FLOAT        NOT NULL,
    [exercise_date]     DATE         NOT NULL
);
GO

-- 創建 nutrition_records 表
CREATE TABLE [nutrition_records]
(
    [record_id]   INT PRIMARY KEY IDENTITY (1, 1),
    [user_id]     INT FOREIGN KEY REFERENCES [users] ([user_id]) ON DELETE CASCADE,
    [food_name]   NVARCHAR(255) NOT NULL,
    [calories]    INT           NOT NULL,
    [protein]     FLOAT         NOT NULL,
    [carbs]       FLOAT         NOT NULL,
    [fats]        FLOAT         NOT NULL,
    [mealtime]    NVARCHAR(50) CHECK (mealtime IN ('早餐', '午餐', '晚餐', '點心')),
    [record_date] DATETIME2 DEFAULT GETDATE()
);
GO

-- 創建 fitness_goals 表
CREATE TABLE [fitness_goals]
(
    [goal_id]          INT PRIMARY KEY IDENTITY (1, 1),
    [user_id]          INT          NOT NULL FOREIGN KEY REFERENCES [users] ([user_id]) ON DELETE CASCADE,
    [goal_type]        NVARCHAR(50) NOT NULL CHECK (goal_type IN ('減重', '增肌', '心肺健康', '其他')),
    [target_value]     FLOAT        NOT NULL,
    [current_progress] FLOAT                                                         DEFAULT 0,
    [unit]             NVARCHAR(20) CHECK (unit IN ('公斤', '百分比', '分鐘', '卡路里')),
    [start_date]       DATE                                                          DEFAULT GETDATE(),
    [end_date]         DATETIME2    NULL,
    [status]           NVARCHAR(20) CHECK (status IN ('進行中', '已完成', '未達成')) DEFAULT '進行中',
    CONSTRAINT [CK_EndDate] CHECK ([end_date] IS NULL OR [end_date] >= [start_date])
);
GO

-- 創建 achievements 表
CREATE TABLE [achievements]
(
    [achievement_id]   INT PRIMARY KEY IDENTITY (1, 1),
    [user_id]          INT                                                NOT NULL FOREIGN KEY REFERENCES [users] ([user_id]) ON DELETE CASCADE,
    [achievement_type] NVARCHAR(50) CHECK (achievement_type IN ('目標達成', '一般成就')),
    [title]            NVARCHAR(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [description]      NVARCHAR(500),
    [achieved_date]    DATE DEFAULT GETDATE(),
    CONSTRAINT [UC_UniqueAchievement] UNIQUE ([user_id], [title])
);
GO

-- 創建 social_post 表
CREATE TABLE [social_post]
(
    [id]         INT PRIMARY KEY IDENTITY (1, 1),
    [category]   NVARCHAR(10)   NOT NULL,
    [title]      NVARCHAR(255)  NOT NULL,
    [content]    NVARCHAR(2000) NOT NULL,
    [user_id]    INT            NOT NULL,
    [created_at] DATETIME DEFAULT CURRENT_TIMESTAMP,
    [updated_at] DATETIME DEFAULT CURRENT_TIMESTAMP
);
GO

-- 創建 comment 表
CREATE TABLE [comment]
(
    [id]         INT PRIMARY KEY IDENTITY (1, 1),
    [post_id]    INT            NOT NULL,
    [user_id]    INT            NOT NULL,
    [text]       NVARCHAR(1000) NOT NULL,
    [created_at] DATETIME DEFAULT CURRENT_TIMESTAMP,
    [updated_at] DATETIME DEFAULT CURRENT_TIMESTAMP
);
GO

-- 外鍵約束設定
ALTER TABLE [user_point]
    ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id]);
ALTER TABLE [order]
    ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id]);
ALTER TABLE [order_item]
    ADD FOREIGN KEY ([order_id]) REFERENCES [order] ([id]);
ALTER TABLE [order_item]
    ADD FOREIGN KEY ([product_id]) REFERENCES [product] ([id]);
ALTER TABLE [course]
    ADD FOREIGN KEY ([coach_id]) REFERENCES [coach] ([id]);
ALTER TABLE [cart_item]
    ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id]);
ALTER TABLE [cart_item]
    ADD FOREIGN KEY ([product_id]) REFERENCES [product] ([id]);
ALTER TABLE [social_post]
    ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id]);
ALTER TABLE [comment]
    ADD FOREIGN KEY ([post_id]) REFERENCES [social_post] ([id]);
ALTER TABLE [comment]
    ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id]);
ALTER TABLE [payment]
    ADD FOREIGN KEY ([order_id]) REFERENCES [order] ([id]);
GO

-- 儀表板視圖
CREATE OR ALTER VIEW dashboard_stat AS
SELECT (SELECT COUNT(*) FROM [users] WHERE role = 'user')                             AS total_users,
       (SELECT COUNT(*) FROM [exercise_records])                                      AS total_workouts,
       (SELECT SUM([exercise_duration]) FROM [exercise_records])                      AS total_workout_minutes,
       (SELECT SUM([calories_burned]) FROM [exercise_records])                        AS total_calories_burned,
       (SELECT COUNT(*) FROM [users] WHERE DATEDIFF(DAY, last_login, GETDATE()) <= 7) AS active_users_this_week;
GO
