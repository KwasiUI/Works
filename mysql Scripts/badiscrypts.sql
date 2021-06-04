update
SELECT tbldistrict.DistrictID,tblfinancialyear.FYID,tblfyearsector.FYSectorID,
tblsector.SectorID,tbldistrict.DistrictName,tblfinancialyear.Description,
tblsector.Sector
FROM tbldistrict INNER JOIN tblfinancialyear ON tbldistrict.DistrictID = tblfinancialyear.DistrictID INNER JOIN tblfyearsector ON tblfinancialyear.FYID = tblfyearsector.FYID INNER JOIN tblsector ON tblsector.SectorID = tblfyearsector.SectorID;


SELECT tblrevenuetype.RevenueTypeID,tblrevenue.Reference
from tblrevenuetype INNER join tblrevenue on tblrevenuetype.RevenueTypeID=tblrevenue.RevenueTypeID

UPDATE tblbudget
set tblbudget.DSIPActualAmount

=tblrevenuedetail.ProjectAmount,
tblbudget.GoPNGActualAmount=



SELECT tblrevenuetype.RevenueType as ID
from tblrevenuetype INNER join tblrevenue on tblrevenuetype.RevenueTypeID=tblrevenue.RevenueTypeID

UPDATE tblbudget
set tblbudget.DSIPActualAmount 
CASE WHEN ID="DSIP" then tblrevenuedetail.ProjectAmount,
case when ID"GoPNG" THEN tblbudget.GoPNGActualAmount


SELECT tblrevenuetype.RevenueTypeID as ID
from tblrevenuetype INNER join tblrevenue on tblrevenuetype.RevenueTypeID=tblrevenue.RevenueTypeID

UPDATE tblbudget
if ID=1 and tblbudget.BudgetID=tblrevenuedetail.BudgetID then set tblbudget.DSIPActualAmount=new.ProjectAmount
if ID=2 and tblbudget.BudgetID=tblrevenuedetail.BudgetID then set tblbudget.GoPNGActualAmount=new.ProjectAmount


SELECT tblrevenuetype.RevenueTypeID as ID
from tblrevenuetype INNER join tblrevenue on tblrevenuetype.RevenueTypeID=tblrevenue.RevenueTypeID

UPDATE tblbudget
if ID=1 and tblbudget.BudgetID=tblrevenuedetail.BudgetID then set tblbudget.DSIPActualAmount=new.ProjectAmount
if ID=2 and tblbudget.BudgetID=tblrevenuedetail.BudgetID then set tblbudget.GoPNGActualAmount=new.ProjectAmount


SELECT tblrevenuetype.RevenueTypeID as ID
from tblrevenuetype INNER join tblrevenue on tblrevenuetype.RevenueTypeID=tblrevenue.RevenueTypeID

if ID =1 THEN
UPDATE tblbudget
set tblbudget.DSIPActualAmount=new.ProjectAmount,
tblbudget.DSIPActualBalance=new.ProjectAmount
where tblbudget.BudgetID=new.BudgetID;
if ID =2 THEN
UPDATE tblbudget
set tblbudget.GoPNGActualBalance=new.ProjectAmount,
tblbudget.GoPNGActualAmount=new.ProjectAmount
where tblbudget.BudgetID=new.BudgetID;


@id INT;
@id = SELECT tblrevenue.RevenueTypeID from tblrevenue INNER join tblrevenuedetail on tblrevenue.RevenueID=tblrevenuedetail.RevenueID WHERE tblrevenuedetail.RevenueID=new.RevenueID;

if @id =1 THEN
UPDATE tblbudget
set tblbudget.DSIPActualAmount=new.ProjectAmount,tblbudget.DSIPActualBalance=new.ProjectAmount where tblbudget.BudgetID=new.BudgetID;
if @id =2 THEN
UPDATE tblbudget
set tblbudget.GoPNGActualBalance=new.ProjectAmount,tblbudget.GoPNGActualAmount=new.ProjectAmount where tblbudget.BudgetID=new.BudgetID;

BEGIN
       DECLARE id_exists Boolean;
       DECLARE rtid INT(11);

       
       SELECT 1
       INTO @id_exists
       FROM tblrevenuedetail
       WHERE tblrevenuedetail.RevenueDetailID = NEW.RevenueDetailID;
       
       SET rtid = (SELECT tblrevenuetype.RevenueTypeID as ID
from tblrevenuetype INNER join tblrevenue on tblrevenuetype.RevenueTypeID=tblrevenue.RevenueTypeID WHERE tblrevenuedetail.RevenueID=new.RevenueID);

       IF (@id_exists = 1 AND @rtid=1)
       THEN
       			UPDATE tblbudget
set tblbudget.DSIPActualAmount=new.ProjectAmount,
tblbudget.DSIPActualBalance=new.ProjectAmount
where tblbudget.BudgetID=new.BudgetID;
              
        END IF;
               IF (@id_exists = 1 AND @rtid=2)
       THEN
       			UPDATE tblbudget 
                set tblbudget.GoPNGActualBalance=new.ProjectAmount, tblbudget.GoPNGActualAmount=new.ProjectAmount where tblbudget.BudgetID=new.BudgetID;
              
        END IF;
END

new trial Works
CREATE TRIGGER revtobud
AFTER INSERT ON tblrevenuedetail
FOR EACH ROW
  UPDATE tblbudget
     set tblbudget.DSIPActualAmount=New.ProjectAmount,
     tblbudget.GoPNGActualAmount=New.ProjectAmount
     where tblbudget.BudgetID=1
	 
	 
new trials 2
UPDATE tblbudget
     set tblbudget.DSIPActualAmount=40,
     tblbudget.DSIPActualBalance=50
     where tblbudget.BudgetID=1 and (SELECT tblrevenue.RevenueTypeID from tblrevenue INNER join tblrevenuedetail on 	tblrevenue.RevenueID=tblrevenuedetail.RevenueID WHERE tblrevenuedetail.RevenueID=1)
     
UPDATE tblbudget
     set tblbudget.DSIPActualAmount=40,
     tblbudget.DSIPActualBalance=50
     where tblbudget.BudgetID=1 and (SELECT tblrevenue.RevenueTypeID from tblrevenue INNER join tblrevenuedetail on 	tblrevenue.RevenueID=tblrevenuedetail.RevenueID WHERE tblrevenuedetail.RevenueID=2)
	
	
new trial 3 not working
DELIMITER //
CREATE or REPLACE TRIGGER revtobud
AFTER INSERT ON tblrevenuedetail
FOR EACH ROW
BEGIN
	DECLARE ID int(11);
	ID = (SELECT tblrevenue.RevenueTypeID from tblrevenue INNER join tblrevenuedetail on 	tblrevenue.RevenueID=tblrevenuedetail.RevenueID WHERE tblrevenuedetail.RevenueID=1)
if ID=1 THEN
  UPDATE tblbudget
     set tblbudget.DSIPActualAmount=New.ProjectAmount,
     tblbudget.GoPNGActualAmount=New.ProjectAmount
     where tblbudget.BudgetID=1;
 END //
DELIMITER ;


New trail 4 working
CREATE or REPLACE TRIGGER revtobud
AFTER INSERT ON tblrevenuedetail
FOR EACH ROW
  UPDATE tblbudget
     set tblbudget.DSIPActualAmount=tblbudget.DSIPActualAmount+New.ProjectAmount,
     tblbudget.DSIPActualBalance=tblbudget.DSIPActualBalance+New.ProjectAmount
     where tblbudget.BudgetID=1 and (SELECT tblrevenue.RevenueTypeID from tblrevenue INNER join tblrevenuedetail on tblrevenue.RevenueID=tblrevenuedetail.RevenueID WHERE tblrevenue.RevenueID=new.RevenueID)
	 
CREATE or REPLACE TRIGGER revtobudnext
AFTER INSERT ON tblrevenuedetail
FOR EACH ROW
  UPDATE tblbudget
     set tblbudget.GoPNGActualAmount=tblbudget.GoPNGActualAmount+New.ProjectAmount,
     tblbudget.GoPNGActualBalance=tblbudget.GoPNGActualBalance+New.ProjectAmount
     where tblbudget.BudgetID=1 and (SELECT tblrevenue.RevenueTypeID from tblrevenue INNER join tblrevenuedetail on tblrevenue.RevenueID=tblrevenuedetail.RevenueID WHERE tblrevenue.RevenueID=new.RevenueID)

	 
new trail4 working
(DSIP)
CREATE or REPLACE TRIGGER revtobud
AFTER INSERT ON tblrevenuedetail
FOR EACH ROW
  UPDATE tblbudget
     set tblbudget.DSIPActualAmount=tblbudget.DSIPActualAmount+New.ProjectAmount,
     tblbudget.DSIPActualBalance=tblbudget.DSIPActualBalance+New.ProjectAmount
     where tblbudget.BudgetID=1 and (SELECT tblrevenue.RevenueTypeID from tblrevenue inner join tblrevenuetype on tblrevenue.RevenueTypeID=tblrevenuetype.RevenueTypeID WHERE tblrevenuetype.RevenueTypeID=1 and tblrevenue.RevenueID=new.RevenueID )
(Gopng)
CREATE or REPLACE TRIGGER revtobudnext
AFTER INSERT ON tblrevenuedetail
FOR EACH ROW
  UPDATE tblbudget
     set tblbudget.GoPNGActualAmount=tblbudget.GoPNGActualAmount+New.ProjectAmount,
     tblbudget.GoPNGActualBalance=tblbudget.GoPNGActualBalance+New.ProjectAmount
     where tblbudget.BudgetID=1 and (SELECT tblrevenue.RevenueTypeID from tblrevenue INNER join tblrevenuedetail on tblrevenue.RevenueID=tblrevenuedetail.RevenueID inner join tblrevenuetype on tblrevenue.RevenueTypeID=tblrevenuetype.RevenueTypeID  WHERE   tblrevenuetype.RevenueTypeID=2 and tblrevenue.RevenueID=new.RevenueID)


trail view Budrequ
SELECT tbldistrict.DistrictID,tblfyearsector.FYSectorID,tblfinancialyear.FYID,tblsector.SectorID 

from tbldistrict inner join tblfinancialyear
on tbldistrict.DistrictID=tblfinancialyear.DistrictID

inner join tblfyearsector on tblfinancialyear.FYID=tblfyearsector.FYID

inner join tblsector on tblfyearsector.SectorID=tblsector.SectorID



SELECT tbldistrict.DistrictID,tblfyearsector.FYSectorID,tblfinancialyear.FYID,tblsector.SectorID,tblbudget.BudgetID 

from tblbudget inner join tbldistrict ON
tblbudget.DistrictID=tbldistrict.DistrictID
inner join tblfinancialyear
on tbldistrict.DistrictID=tblfinancialyear.DistrictID

inner join tblfyearsector on tblfinancialyear.FYID=tblfyearsector.FYID

inner join tblsector on tblfyearsector.SectorID=tblsector.SectorID


new trials
SELECT tbldistrict.DistrictID,tblfyearsector.FYSectorID,tblfinancialyear.FYID,tblsector.SectorID,tblbudget.BudgetID 

from tblbudget inner join tblfyearsector ON
tblbudget.FYSectorID=tblfyearsector.FYSectorID
inner join tblfinancialyear on tblfyearsector.FYID=tblfinancialyear.FYID 

inner join tbldistrict on tblfinancialyear.DistrictID=tbldistrict.DistrictID

inner join tblsector on tblfyearsector.SectorID=tblsector.SectorID


SELECT tbldistrict.DistrictID,tblfyearsector.FYSectorID,tblfinancialyear.FYID,tblsector.SectorID,tblbudget.BudgetID 

from tblbudget inner join tblfyearsector ON
tblbudget.FYSectorID=tblfyearsector.FYSectorID
inner join tblfinancialyear on tblfyearsector.FYID=tblfinancialyear.FYID 

inner join tbldistrict on tblfinancialyear.DistrictID=tbldistrict.DistrictID

inner join tblsector on tblfyearsector.SectorID=tblsector.SectorID

update trial
	SELECT tbldistrict.DistrictID,tblfyearsector.FYSectorID,tblfinancialyear.FYID,tblsector.SectorID,tblbudget.BudgetID,
concat(tblfinancialyear.Description,"_",tbldistrict.DistrictName,"_",tblsector.Sector,tblproject.Project)

from tblbudget inner join tblfyearsector ON
tblbudget.FYSectorID=tblfyearsector.FYSectorID
inner join tblfinancialyear on tblfyearsector.FYID=tblfinancialyear.FYID 

inner join tbldistrict on tblfinancialyear.DistrictID=tbldistrict.DistrictID

inner join tblsector on tblfyearsector.SectorID=tblsector.SectorID

inner join tblproject on tblbudget.ProjectID=tblproject.ProjectID

SELECT tbldistrict.DistrictID,tblfyearsector.FYSectorID,tblfinancialyear.FYID,tblsector.SectorID,tblbudget.BudgetID,tblrequisition.Description,tblclient.ClientName,tblrequisition.RevenueTypeID,
concat(tblfinancialyear.Description,"_",tbldistrict.DistrictName,"_",tblsector.Sector,tblproject.Project)

from tblrequisition inner join tblclient on tblrequisition.ClientID=tblclient.ClientID
inner join tblbudget on tblrequisition.BudgetID = tblbudget.BudgetID
inner join tblfyearsector ON
tblbudget.FYSectorID=tblfyearsector.FYSectorID
inner join tblfinancialyear on tblfyearsector.FYID=tblfinancialyear.FYID 

inner join tbldistrict on tblfinancialyear.DistrictID=tbldistrict.DistrictID


inner join tblsector on tblfyearsector.SectorID=tblsector.SectorID

inner join tblproject on tblbudget.ProjectID=tblproject.ProjectID


final trial
SELECT tbldistrict.DistrictID,tblfyearsector.FYSectorID,tblfinancialyear.FYID,tblsector.SectorID,tblbudget.BudgetID,tblrequisition.Description,tblclient.ClientName,tblrequisition.RevenueTypeID,
concat(tblrequisition.Description,"_",tblclient.ClientName,"_", tblfinancialyear.Description,"_",tbldistrict.DistrictName,"_",tblsector.Sector,tblproject.Project)

from tblrequisition inner join tblclient on tblrequisition.ClientID=tblclient.ClientID
inner join tblbudget on tblrequisition.BudgetID = tblbudget.BudgetID
inner join tblfyearsector ON
tblbudget.FYSectorID=tblfyearsector.FYSectorID
inner join tblfinancialyear on tblfyearsector.FYID=tblfinancialyear.FYID 

inner join tbldistrict on tblfinancialyear.DistrictID=tbldistrict.DistrictID


inner join tblsector on tblfyearsector.SectorID=tblsector.SectorID

inner join tblproject on tblbudget.ProjectID=tblproject.ProjectID

CREATE or REPLACE TRIGGER revtobud
AFTER INSERT ON tblrevenuedetail
FOR EACH ROW
BEGIN
	DECLARE a int(11);
	set a = (SELECT tblrevenue.RevenueTypeID from tblrevenue INNER join tblrevenuedetail on 	tblrevenue.RevenueID=tblrevenuedetail.RevenueID WHERE tblrevenuedetail.RevenueID=1);
if (a=1) THEN
  UPDATE tblbudget set tblbudget.DSIPActualAmount=20 where tblbudget.BudgetID=1;
  END IF;
 END

 latest trial
 CREATE or REPLACE TRIGGER requisition_budget
AFTER INSERT ON tblrequisitionapproval 
FOR EACH ROW
BEGIN
	DECLARE bid int(11);
	set bid = (SELECT tblrequisition.BudgetID from tblbudget INNER join tblbudget.BudgetID on 	tblbudget.BudgetID=tblrequisition.RequisitionID INNER join tblrequisitionapproval on tblrequisition.RequisitionID=tblrequisitionapproval.RequisitionID WHERE tblrequisitionapproval.RequisitionID=new.RequisitionID);
if (a=1) THEN
  UPDATE tblbudget set tblbudget.DSIPActualAmount=20 where tblbudget.BudgetID=1;
  END IF;
 END

 trials non
 CREATE or REPLACE TRIGGER requisition_budget
AFTER INSERT ON tblrequisitionapproval 
FOR EACH ROW
BEGIN
	DECLARE bid int(11);
    DECLARE rtid int(11);
	set bid = (SELECT tblrequisition.BudgetID from tblbudget INNER join tblrequisition on tblbudget.BudgetID=tblrequisition.RequisitionID INNER join tblrequisitionapproval on tblrequisition.RequisitionID=tblrequisitionapproval.RequisitionID WHERE tblrequisitionapproval.RequisitionID=new.RequisitionID);
    
    set rtid=(SELECT tblrequisition.RevenueTypeID from tblrequisition inner join tblrevenuetype.RevenueTypeID on tblrequisition.RevenueTypeID=tblrevenuetype.RevenueTypeID INNER join tblrequisitionapproval ON tblrequisitionapproval.RequisitionID = tblrequisition.RequisitionID where tblrequisitionapproval.RequisitionID=new.RequisitionID);
    
if (rtid=1) THEN
  UPDATE tblbudget set set tblbudget.DSIPActualAmount=tblbudget.DSIPActualAmount-New.ProjectAmount,
     tblbudget.DSIPActualBalance=tblbudget.DSIPActualBalance-New.ProjectAmount
     where tblbudget.BudgetID=bid;
  END IF;
 END

 working TRIGGER
 BEGIN
DECLARE bid INT(11);
DECLARE rtid INT(11);
DECLARE amount DECIMAL(10,2);
SET bid = (SELECT tblrequisition.BudgetID from tblbudget INNER join tblrequisition on tblbudget.BudgetID=tblrequisition.RequisitionID INNER join tblrequisitionapproval on tblrequisition.RequisitionID=tblrequisitionapproval.RequisitionID WHERE tblrequisitionapproval.RequisitionID=new.RequisitionID);
SELECT tblrequisition.RevenueTypeID,tblrequisition.Amount INTO rtid,amount from tblrequisition inner join tblrevenuetype on tblrequisition.RevenueTypeID=tblrevenuetype.RevenueTypeID INNER join tblrequisitionapproval ON tblrequisitionapproval.RequisitionID = tblrequisition.RequisitionID where tblrequisitionapproval.RequisitionID=new.RequisitionID;

IF rtid = 1 THEN
UPDATE tblbudget
SET tblbudget.DSIPActualAmount = tblbudget.DSIPActualAmount-amount,tblbudget.DSIPActualBalance = tblbudget.DSIPActualBalance-amount
WHERE tblbudget.BudgetID =  bid;
END IF;
IF rtid = 2 THEN
UPDATE tblbudget
SET tblbudget.GoPNGActualAmount = tblbudget.GoPNGActualAmount-amount,tblbudget.GoPNGActualBalance = tblbudget.GoPNGActualBalance-amount
WHERE tblbudget.BudgetID =  bid;
END IF;

END

update working TRIGGER
BEGIN
DECLARE id_exists Boolean;
DECLARE bid INT(11);
DECLARE rtid INT(11);
DECLARE amount DECIMAL(10,2);
SELECT 1
       INTO @id_exists
       FROM tblrequisition
       WHERE tblrequisition.RequisitionID = NEW.RequisitionID;

SET @bid = (SELECT tblrequisition.BudgetID from tblbudget INNER join tblrequisition on tblbudget.BudgetID=tblrequisition.BudgetID WHERE tblrequisition.RequisitionID=NEW.RequisitionID);
SET @rtid = (SELECT tblrequisition.RevenueTypeID from tblrequisition inner join tblrevenuetype on tblrequisition.RevenueTypeID=tblrevenuetype.RevenueTypeID where tblrequisition.RequisitionID=NEW.RequisitionID);
SET @amount = (SELECT tblrequisition.Amount from tblrequisition inner join tblrevenuetype on tblrequisition.RevenueTypeID=tblrevenuetype.RevenueTypeID where tblrequisition.RequisitionID=NEW.RequisitionID);
IF (@id_exists = 1) THEN
IF (@rtid = 1) THEN
UPDATE tblbudget
SET tblbudget.DSIPActualBalance = tblbudget.DSIPActualBalance-@amount
WHERE tblbudget.BudgetID =  @bid;
END IF;
IF (@rtid = 2) THEN
UPDATE tblbudget
SET tblbudget.GoPNGActualBalance = tblbudget.GoPNGActualBalance-@amount
WHERE tblbudget.BudgetID =  @bid;
END IF;
END IF;

END

Submission TRIGGER
BEGIN
DECLARE id_exists Boolean;
DECLARE bid INT(11);
DECLARE rtid INT(11);
DECLARE amount DECIMAL(10,2);
SELECT 1
       INTO @id_exists
       FROM tblsubmission
       WHERE tblsubmission.SubmissionID = NEW.SubmissionID;

SET @bid = (SELECT tblsubmission.BudgetID from tblbudget INNER join tblsubmission on tblbudget.BudgetID=tblsubmission.BudgetID WHERE tblsubmission.SubmissionID=NEW.SubmissionID);
SET @rtid = (SELECT tblsubmission.RevenueTypeID from tblsubmission inner join tblrevenuetype on tblsubmission.RevenueTypeID=tblrevenuetype.RevenueTypeID where tblsubmission.SubmissionID=NEW.SubmissionID);
SET @amount = (SELECT tblsubmission.Amount from tblsubmission inner join tblrevenuetype on tblsubmission.RevenueTypeID=tblrevenuetype.RevenueTypeID where tblsubmission.SubmissionID=NEW.SubmissionID);
IF (@id_exists = 1) THEN
IF (@rtid = 1) THEN
UPDATE tblbudget
SET tblbudget.DSIPActualBalance = tblbudget.DSIPActualBalance-@amount
WHERE tblbudget.BudgetID =  @bid;
END IF;
IF (@rtid = 2) THEN
UPDATE tblbudget
SET tblbudget.GoPNGActualBalance = tblbudget.GoPNGActualBalance-@amount
WHERE tblbudget.BudgetID =  @bid;
END IF;
END IF;

END


view reddetail
SSELECT tblrevenue.Reference,tblfinancialyear.FinancialYear,tbldistrict.DistrictName,tblsector.Sector,tblrevenuedetail.ProjectAmount,tblrevenuedetail.TimeStamp,tblproject.Project,tbldistrict.DistrictID,tblfyearsector.FYSectorID,tblfinancialyear.FYID,tblsector.SectorID,tblbudget.BudgetID 

from tblrevenuedetail inner join tblbudget on tblbudget.BudgetID=tblrevenuedetail.BudgetID

inner join tblfyearsector ON
tblbudget.FYSectorID=tblfyearsector.FYSectorID
inner join tblfinancialyear on tblfyearsector.FYID=tblfinancialyear.FYID 

inner join tbldistrict on tblfinancialyear.DistrictID=tbldistrict.DistrictID

inner join tblsector on tblfyearsector.SectorID=tblsector.SectorID
inner join tblproject on tblproject.ProjectID=tblbudget.ProjectID
inner join tblrevenue on tblrevenuedetail.RevenueID=tblrevenue.RevenueID
where tblrevenue.RevenueTypeID=2


UNION
SELECT tblrevenue.Reference,tblfinancialyear.FinancialYear,tbldistrict.DistrictName,tblsector.Sector,tblrevenuedetail.ProjectAmount,tblrevenuedetail.TimeStamp,tblproject.Project,tbldistrict.DistrictID,tblfyearsector.FYSectorID,tblfinancialyear.FYID,tblsector.SectorID,tblbudget.BudgetID 

from tblrevenuedetail inner join tblbudget on tblbudget.BudgetID=tblrevenuedetail.BudgetID

inner join tblfyearsector ON
tblbudget.FYSectorID=tblfyearsector.FYSectorID
inner join tblfinancialyear on tblfyearsector.FYID=tblfinancialyear.FYID 

inner join tbldistrict on tblfinancialyear.DistrictID=tbldistrict.DistrictID

inner join tblsector on tblfyearsector.SectorID=tblsector.SectorID
inner join tblproject on tblproject.ProjectID=tblbudget.ProjectID
inner join tblrevenue on tblrevenuedetail.RevenueID=tblrevenue.RevenueID
where tblrevenue.RevenueTypeID=1

CREATE or REPLACE view vwRevenue_breakdown_report as 
SELECT tblrevenue.Reference,tblfinancialyear.FinancialYear,tbldistrict.DistrictName,tblsector.Sector,tblrevenuedetail.ProjectAmount,tblrevenuedetail.TimeStamp,tblproject.Project,tbldistrict.DistrictID,tblfyearsector.FYSectorID,tblfinancialyear.FYID,tblsector.SectorID,tblbudget.BudgetID 

from tblrevenuedetail inner join tblbudget on tblbudget.BudgetID=tblrevenuedetail.BudgetID

inner join tblfyearsector ON
tblbudget.FYSectorID=tblfyearsector.FYSectorID
inner join tblfinancialyear on tblfyearsector.FYID=tblfinancialyear.FYID 

inner join tbldistrict on tblfinancialyear.DistrictID=tbldistrict.DistrictID

inner join tblsector on tblfyearsector.SectorID=tblsector.SectorID
inner join tblproject on tblproject.ProjectID=tblbudget.ProjectID
inner join tblrevenue on tblrevenuedetail.RevenueID=tblrevenue.RevenueID
INNER join tblrevenuetype on tblrevenuetype.RevenueTypeID=tblrevenue.RevenueTypeID

budget report
select tblproject.ProjectCode,tblproject.Project,tblbudget.BudgetID,tblsector.Sector,tblcategory.Category,tblbudget.DSIPBudgetAmount,tblbudget.GoPNGBudgetAmount,(tblbudget.DSIPBudgetAmount+tblbudget.GoPNGBudgetAmount) as Total
from tblbudget inner JOIN tblfyearsector on tblfyearsector.FYSectorID=tblbudget.FYSectorID
INNER join tblfinancialyear on tblfinancialyear.FYID=tblfyearsector.FYID
INNER join tbldistrict on tbldistrict.DistrictID=tblfinancialyear.DistrictID
inner join tblsector on  tblfyearsector.SectorID=tblsector.SectorID
INNER join tblproject on tblproject.ProjectID=tblbudget.ProjectID
inner join tblcategory on tblcategory.CategoryID=tblbudget.CategoryID


trigger req check
BEGIN
DECLARE balance DECIMAL(10,2);

IF (NEW.RevenueTypeID = 1) THEN 
SET @balance = (SELECT tblbudget.DSIPActualBalance FROM tblbudget INNER JOIN tblrequisition ON tblrequisition.BudgetID = tblbudget.BudgetID WHERE tblbudget.BudgetID = tblrequisition.BudgetID);
IF (@balance < NEW.amount) THEN

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Insufficient Funds In DSIP Balance';
END IF;
END IF;

IF (NEW.RevenueTypeID = 2) THEN 
SET @balance = (SELECT tblbudget.GoPNGActualBalance FROM tblbudget INNER JOIN tblrequisition ON tblrequisition.BudgetID = tblbudget.BudgetID WHERE tblbudget.BudgetID = tblrequisition.BudgetID);
IF (@balance < NEW.amount) THEN

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Insufficient Funds in GoPNG balance';
END IF;
END IF;


END


triger reqapproval
BEGIN
DECLARE balance DECIMAL(10,2);
DECLARE amount DECIMAL(10,2);
DECLARE rtid INT;

SET @amount = (SELECT tblrequisition.Amount FROM tblrequisition WHERE tblrequisition.RequisitionID=NEW.RequisitionID);

SET @rtid = (SELECT tblrequisition.RevenueTypeID FROM tblrequisition WHERE tblrequisition.RequisitionID=NEW.RequisitionID);

IF (@rtid = 1) THEN 
SET @balance = (SELECT tblbudget.DSIPActualBalance FROM tblbudget INNER JOIN tblrequisition ON tblrequisition.BudgetID = tblbudget.BudgetID WHERE tblrequisition.RequisitionID = NEW.RequisitionID);
IF (@balance < @amount) THEN SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Insufficient Funds In DSIP Balance';
END IF;
END IF;

IF (@rtid = 2) THEN 
SET @balance = (SELECT tblbudget.GoPNGActualBalance FROM tblbudget INNER JOIN tblrequisition ON tblrequisition.BudgetID = tblbudget.BudgetID WHERE tblrequisition.RequisitionID = NEW.RequisitionID);
IF (@balance < @amount) THEN SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Insufficient Funds In DSIP Balance';
END IF;
END IF;



END


