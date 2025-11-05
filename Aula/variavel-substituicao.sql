-- Variável de substituição(você cria ela em tempo de execução)
INSERT INTO departments (department_id, department_name) VALUES (:id_dept, :nome_dept)
 
SELECT * FROM departments WHERE department_id = 900;
 
DESC hr.departments