use employees;
COMMIT;
#This trigger sets the salarys of new inputs to zeor just incase input is less than zero
# BEFORE INSERT
DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF; 
END $$
DELIMITER ;

SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
# Now to test our trigger let’s insert a new entry for employee 10001, whose salary will be a negative number.
INSERT INTO salaries VALUES ('10001', -92891, '2010-06-22', '9999-01-01'); 
   
#run and check table
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';    