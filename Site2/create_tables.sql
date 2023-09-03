SET SERVEROUTPUT ON;
SET VERIFY OFF;
CLEAR SCREEN;

DROP TABLE OwnerInfo2 CASCADE CONSTRAINTS;
DROP TABLE OwnerInfo2;
DROP TABLE VehicleInfo2 CASCADE CONSTRAINTS;
DROP TABLE VehicleInfo2;
DROP TABLE Registration2 CASCADE CONSTRAINTS;
DROP TABLE Registration2;
DROP TABLE RegionMap CASCADE CONSTRAINTS;
DROP TABLE RegionMap;
DROP SEQUENCE SEQ_OID;
DROP SEQUENCE SEQ_RID;

CREATE TABLE OwnerInfo2 (
    OID INTEGER NOT NULL,
    Name VARCHAR2(20),
    Phone VARCHAR2(17),
    Address VARCHAR2(30),
    LicenseID VARCHAR2(16),
    LicenseType VARCHAR2(12),
    CONSTRAINT PK_OWNER_INFO PRIMARY KEY (OID)
);

CREATE TABLE VehicleInfo2 (
    VIN VARCHAR2(17) NOT NULL,
    OID INTEGER NOT NULL,
    BrandName VARCHAR2(20),
    Model VARCHAR2(20),
    YOA INTEGER,
    PurchaseDate DATE,
    VehicleType VARCHAR2(10),
    Description VARCHAR2(100),
    CONSTRAINT PK_VEHICLE_INFO PRIMARY KEY (VIN),
    CONSTRAINT FK_V_OID FOREIGN KEY (OID) REFERENCES OwnerInfo2(OID)
);

CREATE TABLE Registration2(
	RID INTEGER NOT NULL,
	VIN VARCHAR2(17) NOT NULL,
	OID INTEGER NOT NULL,
	PlateID VARCHAR2(20),
	DoR DATE,
	Region VARCHAR2(10),
	Condition VARCHAR2(50),
	CONSTRAINT PK_REGISTRATION PRIMARY KEY (RID),
	CONSTRAINT FK_R_VIN FOREIGN KEY (VIN) REFERENCES VehicleInfo2(VIN),
	CONSTRAINT FK_R_OID FOREIGN KEY (OID) REFERENCES OwnerInfo2(OID)
);

CREATE TABLE RegionMap (
	District VARCHAR2(20),
	Region VARCHAR2(10)
); 

CREATE SEQUENCE SEQ_OID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SEQ_RID START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER TRIG_OID 
BEFORE INSERT ON OwnerInfo2
FOR EACH ROW
BEGIN
    SELECT SEQ_OID.NEXTVAL INTO :new.OID FROM dual;
    DBMS_OUTPUT.PUT_LINE('Inserting info for ID: ' || :new.OID);
END;
/

CREATE OR REPLACE TRIGGER TRIG_RID 
BEFORE INSERT ON Registration2 
FOR EACH ROW
BEGIN
    SELECT SEQ_RID.NEXTVAL INTO :new.RID FROM dual;
    DBMS_OUTPUT.PUT_LINE('Inserting info for ID: ' || :new.RID);
END;
/


insert into regionmap values ('Dhaka','Dhaka');
insert into regionmap values ('Gazipur','Dhaka');
insert into regionmap values ('Narayanganj','Dhaka');

insert into regionmap values ('Chittagong','Chittagong');
insert into regionmap values ('Feni','Chittagong');
insert into regionmap values ('Faridpur','Chittagong');


COMMIT;