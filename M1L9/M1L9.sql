create database if not exists TrackIt;

use TrackIt;

create table Task(
	Taskid int primary key auto_increment,
    Title varchar(100) not null,
    Details text null,
    DueDate date not null,
    EstimatedHours decimal(5, 2) null
);
