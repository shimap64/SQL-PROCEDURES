use sql_invoicing;
DROP PROCEDURE IF EXISTS get_clients_by_state;
DELIMITER $$
CREATE PROCEDURE get_clients_by_state(state CHAR(2))
BEGIN
       IF  state IS NULL THEN
	        set state='CA';
       END IF;
   select * from clients c
   WHERE c.state=state;
END $$
DELIMITER ;