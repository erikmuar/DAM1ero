DROP USER IF EXISTS 
    lsfit_data_loader, 
    lsfit_user, 
    lsfit_backup, 
    lsfit_auditor, 
    lsfit_admin;

CREATE USER lsfit_data_loader IDENTIFIED BY '123456789', 
            lsfit_user IDENTIFIED BY '123456789',
            lsfit_backup IDENTIFIED BY '123456789',
            lsfit_auditor IDENTIFIED BY '123456789',
            lsfit_admin IDENTIFIED BY '1234567890';

GRANT SELECT, INSERT, UPDATE, DELETE ON lsfit.activitats_raw TO lsfit_data_loader;
GRANT FILE ON *.* TO lsfit_data_loader;

GRANT EXECUTE, SELECT, INSERT, UPDATE, DELETE ON lsfit.* TO lsfit_user;
GRANT FILE ON *.* TO lsfit_user;

GRANT SELECT ON lsfit.* TO lsfit_backup;
GRANT ALL ON lsfit_backup.* TO lsfit_backup;

GRANT SELECT ON lsfit.* TO lsfit_auditor;
GRANT SELECT ON lsfit_backup.* TO lsfit_auditor;

GRANT ALL ON lsfit.* TO lsfit_admin;
GRANT ALL ON lsfit_backup.* TO lsfit_admin;
