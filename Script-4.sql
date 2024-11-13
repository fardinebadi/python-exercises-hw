--1
SELECT   
    a.album_id AS Album_ID,  
    COUNT(t.track_id) AS Number_of_Tracks,  
    AVG(t.file_size) AS Average_Track_Size,  
    SUM(t.price) AS Total_Cost  
FROM   
    album a  
LEFT JOIN   
    track t ON a.track_id = t.track_id  
GROUP BY   
    a.album_id  
ORDER BY   
    Total_Cost ASC;
    
   
--2
WITH sales_summary AS (
    SELECT
        t.track_id,
        SUM(o.quantity) AS total_sales
    FROM order_item oi
    JOIN track t ON oi.track_id = t.track_id
    JOIN orders o ON oi.order_id = o.orders_id
    GROUP BY t.track_id
),


max_sales AS (
    SELECT MAX(total_sales) * 0.6 AS sales_threshold
    FROM sales_summary
)

SELECT
    s.track_id,
    s.total_sales
FROM sales_summary s
WHERE s.total_sales >= (SELECT sales_threshold FROM max_sales)
ORDER BY s.total_sales DESC;

--۴
SELECT
    u.name AS customer_name,
    MAX(o.creation_date) AS last_order_date
FROM usersss u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id
ORDER BY last_order_date DESC;

--۵

SELECT 
    al.titel AS album_name
FROM 
    album al
JOIN 
    track t ON al.album_id = t.album_id
JOIN 
    order_item oi ON t.track_id = oi.track_id
GROUP BY 
    al.album_id, al.titel
HAVING 
    COUNT(DISTINCT t.track_id) = 1;

   
   
   
   
   
   
   
   --۶
   
   WITH product_sales AS (
    SELECT 
        t.track_id,
        t.price,
        t.album_id,
        t.name AS track_name,
        SUM(o.quantity) * t.price::numeric AS total_sales  -- تبدیل price به numeric
    FROM 
        track t
    JOIN 
        order_item oi ON t.track_id = oi.track_id
    JOIN 
        orders o ON oi.order_id = o.orders_id
    GROUP BY 
        t.track_id, t.album_id, t.price, t.name
),
genre_sales AS (
    SELECT 
        a.genre,
        SUM(o.quantity * t.price::numeric) AS genre_sales_total  -- تبدیل price به numeric
    FROM 
        album a
    JOIN 
        track t ON a.album_id = t.album_id
    JOIN 
        order_item oi ON t.track_id = oi.track_id
    JOIN 
        orders o ON oi.order_id = o.orders_id
    GROUP BY 
        a.genre
)
UPDATE 
    track t
SET 
    price = t.price * 0.5
FROM 
    product_sales ps
JOIN 
    genre_sales gs ON (SELECT genre FROM album WHERE album_id = ps.album_id) = gs.genre
WHERE 
    t.track_id = ps.track_id
    AND ps.total_sales < (0.002 * gs.genre_sales_total);

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
