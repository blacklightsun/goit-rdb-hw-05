use mydb;

-- task 1
-- -----------
SELECT
	*, 
    (
		select orders.customer_id 
		from orders 
		where orders.id = order_details.order_id
    ) as customer_id 
FROM order_details;

-- task 2
-- -----------
SELECT * 
FROM order_details 
where order_details.order_id in (
	select orders.id 
    from orders 
    where orders.shipper_id = 3
);

-- task 3
-- -----------
select 
	order_id, 
	avg(quantity) 
from (
	select * 
    from order_details 
    where quantity > 10
) as derived_table 
group by order_id;

-- task 4
-- -----------
with temp as (
	select * 
    from order_details 
    where quantity > 10
)
select 
	order_id, 
	avg(quantity)
from temp
group by order_id;

-- task 5
-- -----------

-- визначаємо функцію
DROP FUNCTION IF EXISTS Divider;
DELIMITER //
CREATE FUNCTION Divider(divisible INT, divider int)
RETURNS INT
DETERMINISTIC 
NO SQL
BEGIN
    DECLARE result INT;
    if divider = 0 then 
		SET result = NULL;
	else 
		SET result = divisible / divider;
    end if;
    RETURN result;
END //
DELIMITER ;

-- використовуємо функцію
set @divider = 2;
SELECT
    *,
    Divider(quantity, @divider) as divided_quantity
FROM order_details;

