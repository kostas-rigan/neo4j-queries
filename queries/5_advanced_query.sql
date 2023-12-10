SELECT ord.orderID as orderID, c.companyName as company, concat(emp.firstName, " ", emp.lastName) as employee, 
    count(ord.orderID) as numberOfSeafoods, sum(ord.revenue) as revenue
FROM employee as emp, sold as s, customer as c, purchased as p, (
	SELECT o.orderID as orderID, od.unitPrice * od.quantity * (1-od.discount) as revenue
	FROM orders as o, order_details as od
	WHERE o.orderID = od.orderID && od.productID IN (
		SELECT p.productID
		FROM category as c, product as p
		WHERE c.categoryName = "Seafood" && c.categoryID = p.categoryID
	)) as ord
WHERE emp.employeeID = s.employeeID && s.orderID = ord.orderID && 
c.country IN ("Germany", "France", "Sweden", "Spain", "Ireland", "Portugal", "Denmark", "Belgium", "Austria", "Finland", "Poland", "Italy")
&& c.customerID = p.customerID && p.orderID = ord.orderID
GROUP BY ord.orderID
ORDER BY revenue desc LIMIT 10;