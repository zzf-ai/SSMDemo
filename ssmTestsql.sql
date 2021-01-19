CREATE TABLE `mybatis`.`tbl_emp` (
  `emp_id` INT NOT NULL AUTO_INCREMENT,
  `emp_name` VARCHAR(255) NOT NULL,
  `gender` CHAR(1) NULL,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`emp_id`));

CREATE TABLE `mybatis`.`tbl_dept` (
  `dept_id` INT NOT NULL AUTO_INCREMENT,
  `dept_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`dept_id`));

ALTER TABLE `mybatis`.`tbl_emp` 
ADD COLUMN `d_id` INT NULL AFTER `email`,
ADD INDEX `fk_emp_dept_idx` (`d_id` ASC) VISIBLE;
;
ALTER TABLE `mybatis`.`tbl_emp` 
ADD CONSTRAINT `fk_emp_dept`
  FOREIGN KEY (`d_id`)
  REFERENCES `mybatis`.`tbl_dept` (`dept_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;