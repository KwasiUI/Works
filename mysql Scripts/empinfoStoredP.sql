/*Program to return employee id when name is enterd*/
DELIMITER $$

CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)

BEGIN
                SELECT
				e.emp_no
                INTO p_emp_no FROM
                                employees e
                WHERE
					e.first_name = p_first_name
						AND e.last_name = p_last_name;
END$$

DELIMITER ; 


