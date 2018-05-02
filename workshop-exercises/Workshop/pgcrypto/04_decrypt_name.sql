select * from pilots where employeeid < 5500 limit 5;
select  pgp_sym_decrypt_bytea(name, 'secretkey'), license, employeeid from pilots_encrypted where employeeid < 5500 limit 5;


