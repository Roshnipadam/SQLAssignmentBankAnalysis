-- Databricks notebook source
create table AgentTable(agent_id int, Name varchar(30));

-- COMMAND ----------

insert into AgentTable values (1,"Vijay"),(2,"Rajesh"),(3,"Satish"),(4,"Anji")

-- COMMAND ----------

select * from AgentTable

-- COMMAND ----------

create table Case_transaction_details(Case_id int,Stage varchar(20),Login_Time varchar(20),logout_time varchar(20),agent_id int ,status varchar(20));

-- COMMAND ----------

insert into  Case_transaction_details values (101,"Maker","5/11/2019 10:20","10:30",2,"Success"),(102,"Maker","10:25","10:35",1,"Success"),(103,"Maker","10:40","10:50",2,"Success"),
(101,"Checker","10:45","11:00",3,"Success"),(101,"Approver","11:15","11:30",2,"Success"),(102,"Checker","10:50","11:00",1,"Reject"),(102,"Maker","11:15","11:45",4,"Reverify"),
(103,"Checker","11:30","11:40",2,"Reject")


-- COMMAND ----------

select * from Case_transaction_details

-- COMMAND ----------

-- MAGIC %md
-- MAGIC sql queries

-- COMMAND ----------

-- How many unique cases per day?
select count(distinct(Case_id)) as Unique_cases_per_day from Case_transaction_details


-- COMMAND ----------

-- Case Id which is  rejected by checkerbutstill not reverified
select case_id from case_transaction_details where status like 'Reject' and case_id not in 
           (select case_id from case_transaction_details where status like 'Reverify')

-- COMMAND ----------

-- Top Agent names with who processed more applications
-- in this we need to join the tables to  get the agent id names
create view  resultData  AS select Case_transaction_details.Case_id,Case_transaction_details.Stage,Case_transaction_details.Login_time,Case_transaction_details.Logout_time,AgentTable.Name,Case_transaction_details.status from Case_transaction_details inner join AgentTable on Case_transaction_details.agent_id = AgentTable.agent_id 

-- COMMAND ----------

select * from resultData

-- COMMAND ----------

-- Agent names with who processed more applications
select  Name ,count(Name) as application_Number from resultData group By Name order by application_Number desc  limit 2
