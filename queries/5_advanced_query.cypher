MATCH (c:Customer)-->(o:Order)<--(e:Employee)
WITH c, o, e, ["Germany", "France", "Sweden", "Spain", "Ireland", "Portugal", "Denmark", "Belgium", "Austria", "Finland", "Poland", "Italy"] AS euCountries
WHERE c.country IN euCountries
MATCH (o)-[ord:ORDERS]->(p:Product)-->(cat:Category {categoryName:"Seafood"})
WITH o.orderID as order, c.companyName AS company, e.firstName + ' ' + e.lastName AS employee, p.productName as product, ord.unitPrice * ord.quantity as revenue
RETURN order, company, employee, COUNT(product) AS numberOfSeafoodProducts, SUM(revenue) as revenue
ORDER BY revenue desc LIMIT 10