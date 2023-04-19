-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
create database FitBase;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on FitBase.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 
use FitBase;

-- Put your DDL 

CREATE TABLE
    IF NOT EXISTS Gym
(
    gid       int PRIMARY KEY,
    name      varchar(50) NOT NULL,
    openTime  time        NOT NULL,
    closeTime time        NOT NULL,
    street    varchar(50) NOT NULL,
    city      varchar(50) NOT NULL,
    state     varchar(2)  NOT NULL,
    zip       int         NOT NULL
);

CREATE TABLE
    IF NOT EXISTS MarketingConsultant
(
    mcid  int PRIMARY KEY,
    first varchar(50) NOT NULL,
    last  varchar(50) NOT NULL
);

CREATE TABLE
    IF NOT EXISTS Membership
(
    msid  int PRIMARY KEY,
    type  varchar(50) NOT NULL,
    price double      NOT NULL,
    mcid  int,
    FOREIGN KEY
        (mcid) REFERENCES MarketingConsultant
        (mcid)
);

CREATE TABLE
    IF NOT EXISTS Manager
(
    first    varchar(50) NOT NULL,
    last     varchar(50) NOT NULL,
    email    varchar(50) NOT NULL,
    phoneNum varchar(20) NOT NULL,
    mnid     int PRIMARY KEY
);


CREATE TABLE
    IF NOT EXISTS Member
(
    mid        int PRIMARY KEY,
    first_name varchar(50) NOT NULL,
    last_name  varchar(50) NOT NULL,
    gender     varchar(50) NOT NULL,
    years      int         NOT NULL,
    age        int         NOT NULL,
    mcid       int,
    FOREIGN KEY
        (mcid) REFERENCES MarketingConsultant
        (mcid),
    msid       int,
    FOREIGN KEY
        (msid) REFERENCES Membership
        (msid),
    phoneNum_1 varchar(20) NOT NULL,
    phoneNum_2 varchar(20),
    email_1    varchar(50) NOT NULL,
    email_2    varchar(50)

);

# drop table Trainer;
CREATE TABLE
    IF NOT EXISTS Trainer
(
    first  varchar(50) NOT NULL,
    last   varchar(50) NOT NULL,
    tid    int PRIMARY KEY,
    gender varchar(50) NOT NULL,
    mnid   int,
    gid    int,
    mcid   int,
    FOREIGN KEY
        (mnid) REFERENCES Manager
        (mnid),
    FOREIGN KEY
        (gid) REFERENCES Gym
        (gid),
    FOREIGN KEY
        (mcid) REFERENCES MarketingConsultant
        (mcid)
);

CREATE TABLE
    IF NOT EXISTS Specialities
(
    tid       int,
    specialty varchar(50) NOT NULL,
    FOREIGN KEY
        (tid) REFERENCES Trainer
        (tid)
);

CREATE TABLE IF NOT EXISTS Gym_Mem (
    mid int,
    gid int NOT NULL,
    FOREIGN KEY (mid) REFERENCES Member (mid) ON DELETE CASCADE,
    FOREIGN KEY (gid) REFERENCES Gym (gid) ON DELETE CASCADE
);

CREATE TABLE
    IF NOT EXISTS Certs
(
    tid           int,
    certification varchar(50) NOT NULL,
    FOREIGN KEY
        (tid) REFERENCES Trainer
        (tid)
);

CREATE TABLE
    IF NOT EXISTS Interests
(
    mid      int,
    interest varchar(50),
    FOREIGN KEY
        (mid) REFERENCES Member
        (mid) ON DELETE CASCADE
);

CREATE TABLE
    IF NOT EXISTS Orders
(
    totalCost double NOT NULL,
    oid       int PRIMARY KEY,
    mcid      int,
    mid       int,
    FOREIGN KEY
        (mcid) REFERENCES MarketingConsultant
        (mcid),
    FOREIGN KEY
        (mid) REFERENCES Member
        (mid) ON DELETE CASCADE
);

CREATE TABLE
    IF NOT EXISTS Product
(
    pid   int PRIMARY KEY,
    price double      NOT NULL,
    name  varchar(50) NOT NULL,
    type  varchar(50) NOT NULL
);

CREATE TABLE
    IF NOT EXISTS Equipment
(
    eid        int PRIMARY KEY,
    difficulty varchar(10)
);

CREATE TABLE
    IF NOT EXISTS Prod_Order
(
    oid int,
    pid int,
    FOREIGN KEY
        (oid) REFERENCES Orders
        (oid),
    FOREIGN KEY
        (pid) REFERENCES Product
        (pid)
);

CREATE TABLE
    IF NOT EXISTS Class
(
    cid        int PRIMARY KEY,
    activity   varchar(50) NOT NULL,
    name       varchar(50) NOT NULL,
    startTime  datetime    NOT NULL,
    endTime    datetime    NOT NULL,
    roomNum    int         NOT NULL,
    totalSeats int         NOT NULL,
    tid        int,
    FOREIGN KEY
        (tid) REFERENCES Trainer
        (tid),
    mcid       int,
    FOREIGN KEY
        (mcid) REFERENCES MarketingConsultant
        (mcid)
);

CREATE TABLE
    IF NOT EXISTS Class_Mem
(
    mid int,
    cid int,
    FOREIGN KEY
        (mid) REFERENCES Member
        (mid), ON DELETE CASCADE
    FOREIGN KEY
        (cid) REFERENCES Class
        (cid)
);

CREATE TABLE
    IF NOT EXISTS Train_Equip
(
    tid int,
    eid int,
    FOREIGN KEY
        (tid) REFERENCES Trainer
        (tid),
    FOREIGN KEY
        (eid) REFERENCES Equipment
        (eid)
);

CREATE TABLE
    IF NOT EXISTS PersonalTraining
(
    ptid     int PRIMARY KEY,
    length   int         NOT NULL,
    activity varchar(50) NOT NULL,
    tid      int,
    FOREIGN KEY
        (tid) REFERENCES Trainer
        (tid),
    mid      int,
    FOREIGN KEY
        (mid) REFERENCES Member
        (mid) ON DELETE CASCADE
);

CREATE TABLE
    IF NOT EXISTS Discount
(
    type varchar(50) PRIMARY KEY,
    msid int,
    FOREIGN KEY
        (msid) REFERENCES Membership
        (msid)
);



insert into Manager (first, last, email, phoneNum, mnid)
values ('Ignaz', 'Maharg', 'imaharg0@youtube.com', 213704, 760112);
insert into Manager (first, last, email, phoneNum, mnid)
values ('Kally', 'Lace', 'klace1@ibm.com', 205447, 406457);
insert into Manager (first, last, email, phoneNum, mnid)
values ('Bonita', 'Capstake', 'bcapstake2@51.la', 236573, 596835);
insert into Manager (first, last, email, phoneNum, mnid)
values ('Had', 'Carpe', 'hcarpe3@seattletimes.com', 743740, 617784);
insert into Manager (first, last, email, phoneNum, mnid)
values ('Alair', 'Kennagh', 'akennagh4@tinypic.com', 951553, 861790);
insert into Manager (first, last, email, phoneNum, mnid)
values ('Francene', 'Gawler', 'fgawler5@ucsd.edu', 598409, 691445);
insert into Manager (first, last, email, phoneNum, mnid)
values ('Ulrica', 'Manoch', 'umanoch6@xinhuanet.com', 948545, 270934);
insert into Manager (first, last, email, phoneNum, mnid)
values ('Susanne', 'Espie', 'sespie7@free.fr', 549227, 964729);
insert into Manager (first, last, email, phoneNum, mnid)
values ('Gillian', 'Scain', 'gscain8@msu.edu', 221644, 184063);
insert into Manager (first, last, email, phoneNum, mnid)
values ('Marty', 'Jagiello', 'mjagiello9@tripod.com', 100394, 648372);
insert into Manager (first, last, email, phoneNum, mnid)
values ('Coretta', 'Morl', 'cmorla@virginia.edu', 106519, 246048);
insert into Manager (first, last, email, phoneNum, mnid)
values ('Edie', 'Shapero', 'eshaperob@amazon.com', 533592, 531160);


insert into MarketingConsultant (mcid, first, last)
values (951912, 'Alasteir', 'Grieves');
insert into MarketingConsultant (mcid, first, last)
values (342718, 'Aylmar', 'Piner');
insert into MarketingConsultant (mcid, first, last)
values (197361, 'Ambur', 'Escalante');
insert into MarketingConsultant (mcid, first, last)
values (015199, 'Xever', 'Mendus');
insert into MarketingConsultant (mcid, first, last)
values (189856, 'Amitie', 'Thacke');
insert into MarketingConsultant (mcid, first, last)
values (118023, 'Gillian', 'Fattorini');
insert into MarketingConsultant (mcid, first, last)
values (803303, 'Robinia', 'Baverstock');
insert into MarketingConsultant (mcid, first, last)
values (299272, 'Flint', 'Arthur');
insert into MarketingConsultant (mcid, first, last)
values (278414, 'Luci', 'Chapellow');
insert into MarketingConsultant (mcid, first, last)
values (134843, 'Zebulon', 'De Bruijn');
insert into MarketingConsultant (mcid, first, last)
values (504920, 'Carolynn', 'Buckel');
insert into MarketingConsultant (mcid, first, last)
values (697772, 'Devi', 'Owbrick');
insert into MarketingConsultant (mcid, first, last)
values (870729, 'Georgia', 'Whyler');
insert into MarketingConsultant (mcid, first, last)
values (346064, 'Terrye', 'Pickworth');


insert into Membership (msid, type, price, mcid)
values (440966, 'Gold', 150.89, 803303);
insert into Membership (msid, type, price, mcid)
values (189048, 'Silver', 125.81, 346064);
insert into Membership (msid, type, price, mcid)
values (540269, 'Bronze', 98.31, 870729);

insert into Gym (gid, name, openTime, closeTime, street, city, state, zip)
values (973240, 'Fitbase- NY', '4:36:00', '8:19:00', '3502 8th Parkway', 'Manhattan', 'NY', 31234);
insert into Gym (gid, name, openTime, closeTime, street, city, state, zip)
values (442239, 'Fitbase- BOS', '5:34:00', '7:44:00', '63980 Little Fleur Court', 'Boston', 'MA', 76100);
insert into Gym (gid, name, openTime, closeTime, street, city, state, zip)
values (031457, 'Fitbase- ATL', '5:00:00', '7:55:00', '0104 Veith Hill', 'Georgia', 'GA', 78275);
insert into Gym (gid, name, openTime, closeTime, street, city, state, zip)
values (546692, 'Fitbase- PITT', '5:47:00', '9:21:00', '5 Oriole Junction', 'Pennsylvania', 'PA', 23974);
insert into Gym (gid, name, openTime, closeTime, street, city, state, zip)
values (538349, 'Fitbase- LA', '4:45:00', '11:28:00', '1 Debra Place', 'California', 'CA', 97234);
insert into Gym (gid, name, openTime, closeTime, street, city, state, zip)
values (654368, 'Fitbase- DAL', '5:44:00', '10:33:00', '5 Erie Court', 'Texas', 'TX', 54313);
insert into Gym (gid, name, openTime, closeTime, street, city, state, zip)
values (805735, 'Fitbase- MIA', '4:28:00', '7:51:00', '88 Basil Road', 'Florida', 'FL', 97234);

insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Elden', 'Island', 8598191, 'Male', 760112, 973240, 951912);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Stephi', 'Stolte', 195028, 'Female', 531160, 973240, 342718);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Wang', 'Crosseland', 703868, 'Male', 406457, 973240, 197361);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Raoul', 'Nunnery', 282840, 'Male', 596835, 973240, 015199);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Dianna', 'Esche', 855104, 'Bigender', 617784, 442239, 189856);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Paco', 'Sibbe', 698643, 'Male', 861790, 442239, 118023);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Baird', 'Kringe', 992205, 'Male', 691445, 442239, 803303);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Ashton', 'Forcer', 130698, 'Male', 270934, 654368, 299272);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Katrina', 'Bourget', 209272, 'Female', 964729, 654368, 278414);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Pepito', 'Barrat', 642630, 'Male', 184063, 654368, 134843);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Saul', 'Dimbleby', 239932, 'Male', 648372, 031457, 504920);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Britt', 'Fockes', 282293, 'Female', 246048, 031457, 697772);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Xenia', 'Chisnell', 437262, 'Female', 531160, 031457, 870729);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Elbertine', 'Chisnall', 619257, 'Female', 760112, 031457, 346064);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Caril', 'Kensington', 249702, 'Female', 406457, 546692, 015199);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Ignaz', 'McKew', 979465, 'Male', 596835, 546692, 189856);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Adrien', 'Guys', 819670, 'Male', 617784, 546692, 118023);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Hastings', 'Zealy', 846958, 'Male', 861790, 546692, 803303);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('West', 'Crotty', 523907, 'Male', 691445, 546692, 299272);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Alley', 'Cristoforo', 503701, 'Male', 270934, 538349, 278414);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Pen', 'Shills', 398402, 'Male', 964729, 538349, 134843);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Nowell', 'Dyball', 930461, 'Male', 184063, 538349, 504920);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Homer', 'Saunt', 601222, 'Male', 648372, 805735, 697772);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('See', 'Pietzker', 928461, 'Male', 246048, 805735, 870729);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid)
values ('Mei', 'Shore', 480581, 'Female', 531160, 805735, 346064);

insert into Certs (tid, certification)
values (480581, 'NSCA Certified Personal Trainer');
insert into Certs (tid, certification)
values (928461, 'ISSA Certified Fitness Trainer');
insert into Certs (tid, certification)
values (601222, 'NCCPT Certified Personal Trainer');
insert into Certs (tid, certification)
values (282293, 'NASM Certified Personal Trainer');
insert into Certs (tid, certification)
values (398402, 'ISSA Certified Fitness Trainer');
insert into Certs (tid, certification)
values (642630, 'ACSM Certified Personal Trainer');
insert into Certs (tid, certification)
values (282293, 'ISSA Certified Fitness Trainer');
insert into Certs (tid, certification)
values (846958, 'ACE Personal Trainer Certification');
insert into Certs (tid, certification)
values (819670, 'NSCA Certified Personal Trainer');
insert into Certs (tid, certification)
values (979465, 'ISSA Certified Fitness Trainer');
insert into Certs (tid, certification)
values (249702, 'ISSA Certified Fitness Trainer');
insert into Certs (tid, certification)
values (619257, 'AFPA Certified Personal Trainer');
insert into Certs (tid, certification)
values (437262, 'ACSM Certified Personal Trainer');
insert into Certs (tid, certification)
values (282293, 'ISSA Certified Fitness Trainer');
insert into Certs (tid, certification)
values (239932, 'NCCPT Certified Personal Trainer');
insert into Certs (tid, certification)
values (642630, 'NASM Certified Personal Trainer');
insert into Certs (tid, certification)
values (209272, 'NCSF Certified Personal Trainer');
insert into Certs (tid, certification)
values (130698, 'AFPA Certified Personal Trainer');
insert into Certs (tid, certification)
values (992205, 'ACSM Certified Personal Trainer');
insert into Certs (tid, certification)
values (698643, 'NSCA Certified Personal Trainer');
insert into Certs (tid, certification)
values (855104, 'AFPA Certified Personal Trainer');
insert into Certs (tid, certification)
values (282840, 'NCSF Certified Personal Trainer');
insert into Certs (tid, certification)
values (703868, 'NESTA Personal Fitness Trainer Certification');
insert into Certs (tid, certification)
values (195028, 'NESTA Personal Fitness Trainer Certification');
insert into Certs (tid, certification)
values (8598191, 'NCSF Certified Personal Trainer');

insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (867016, 'zumba', 'Glow in the Dark Zumba', '2023-01-12 7:05:00', '2023-01-12 9:25:00', 900, 15, 8598191,
        346064);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (090630, 'kickboxing', 'Kickboxing', '2023-04-23 3:55:00', '2023-04-23 5:15:00', 26, 35, 480581, 951912);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (317839, 'yoga', 'Yoga with Goats', '2023-10-13 3:25:00', '2023-10-13 3:20:00', 560, 32, 928461, 870729);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (445626, 'yoga', 'Hot Yoga', '2023-11-24 17:15:00', '2023-11-24 18:20:00', 418, 23, 601222, 342718);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (015282, 'weights', 'Get Stronger', '2023-08-11 13:35:00', '2023-08-11 14:25:00', 84, 4, 930461, 197361);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (120599, 'weights', 'Get Stronger Arms', '2023-02-19 15:15:00', '2023-02-19 17:30:00', 742, 8, 398402, 697772);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (094351, 'body', 'Arm Sculpt', '2023-12-01 5:00:00', '2023-12-01 6:55:00', 732, 30, 503701, 015199);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (534438, 'body', 'Butt Sculpt', '2023-01-02 6:00:00', '2023-01-02 8:00:00', 332, 31, 523907, 504920);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (118354, 'zumba', 'Glow in the Dark Zumba', '2023-01-03 4:30:00', '2023-01-03 6:30:00', 699, 20, 846958, 189856);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (856088, 'kickboxing', 'Kickboxing', '2023-02-09 12:30:00', '2023-02-09 13:45:00', 41, 6, 819670, 118023);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (528526, 'yoga', 'Yoga with Goats', '2023-03-13 11:00:00', '2023-03-13 13:30:00', 325, 22, 979465, 803303);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (323399, 'yoga', 'Hot Yoga', '2023-04-17 5:00:00', '2023-04-17 7:00:00', 7, 29, 249702, 299272);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (350150, 'weights', 'Get Stronger', '2023-07-29 9:45:00', '2023-07-29 11:00:00', 96, 6, 619257, 278414);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (022825, 'weights', 'Get Stronger Arms', '2023-10-30 13:45:00', '2023-10-30 14:55:00', 517, 22, 437262, 134843);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (947273, 'body', 'Arm Sculpt', '2023-10-10 7:50:00', '2023-10-10 10:15:00', 268, 16, 282293, 504920);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (125455, 'body', 'Butt Sculpt', '2023-10-11 14:00:00', '2023-10-11 16:00:00', 132, 28, 703868, 697772);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (352149, 'zumba', 'Glow in the Dark Zumba', '2023-05-29 4:00:00', '2023-05-29 6:00:00', 179, 24, 282840, 870729);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (130156, 'kickboxing', 'Kickboxing', '2023-07-30 6:00:00', '2023-07-30 7:00:00', 139, 22, 855104, 346064);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (587013, 'yoga', 'Yoga with Goats', '2023-05-31 12:00:00', '2023-05-31 13:30:00', 373, 28, 698643, 951912);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (895933, 'yoga', 'Hot Yoga', '2023-06-02 6:45:00', '2023-06-02 7:45:00', 988, 15, 992205, 342718);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (994970, 'weights', 'Get Stronger', '2023-07-12 11:00:00', '2023-07-12 12:30:00', 50, 9, 130698, 197361);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (069268, 'weights', 'Get Stronger Arms', '2023-12-12 11:00:00', '2023-12-12 13:00:00', 531, 32, 209272, 015199);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (598163, 'body', 'Arm Sculpt', '2023-10-22 6:10:00', '2023-10-22 7:55:00', 849, 34, 642630, 189856);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (177244, 'body', 'Butt Sculpt', '2023-11-28 9:00:00', '2023-11-28 11:30:00', 186, 30, 239932, 118023);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (105066, 'zumba', 'Glow in the Dark Zumba', '2023-11-13 13:45:00', '2023-11-23 14:00:00', 407, 19, 282293,
        803303);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (117815, 'kickboxing', 'Kickboxing', '2023-04-22 5:00:00', '2023-04-22 7:00:00', 724, 32, 437262, 299272);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (803662, 'yoga', 'Yoga with Goats', '2023-04-14 9:45:00', '2023-04-14 10:50:00', 886, 33, 619257, 278414);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (014343, 'yoga', 'Hot Yoga', '2023-11-13 7:40:00', '2023-11-13 8:45:00', 317, 33, 249702, 134843);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (913373, 'weights', 'Get Stronger', '2023-11-10 10:00:00', '2023-11-10 11:30:00', 26, 1, 979465, 504920);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid)
values (123396, 'weights', 'Get Stronger Arms', '2023-12-22 16:00:00', '2023-12-22 6:00:00', 433, 4, 819670, 697772);

insert into Discount (type, msid)
values ('Black Friday', 440966);
insert into Discount (type, msid)
values ('Senior Citizen', 189048);
insert into Discount (type, msid)
values ('Family', 440966);
insert into Discount (type, msid)
values ('Veteran', 189048);
insert into Discount (type, msid)
values ('Student', 189048);


insert into Equipment (eid, difficulty)
values (005556, 'easy');
insert into Equipment (eid, difficulty)
values (086734, 'easy');
insert into Equipment (eid, difficulty)
values (462979, 'easy');
insert into Equipment (eid, difficulty)
values (740185, 'medium');
insert into Equipment (eid, difficulty)
values (849264, 'easy');
insert into Equipment (eid, difficulty)
values (410345, 'difficult');
insert into Equipment (eid, difficulty)
values (171017, 'difficult');
insert into Equipment (eid, difficulty)
values (413558, 'medium');
insert into Equipment (eid, difficulty)
values (234270, 'difficult');
insert into Equipment (eid, difficulty)
values (819176, 'difficult');
insert into Equipment (eid, difficulty)
values (307720, 'difficult');
insert into Equipment (eid, difficulty)
values (474120, 'easy');
insert into Equipment (eid, difficulty)
values (076815, 'medium');
insert into Equipment (eid, difficulty)
values (143877, 'easy');
insert into Equipment (eid, difficulty)
values (383447, 'difficult');
insert into Equipment (eid, difficulty)
values (780229, 'medium');
insert into Equipment (eid, difficulty)
values (297960, 'difficult');
insert into Equipment (eid, difficulty)
values (033901, 'difficult');
insert into Equipment (eid, difficulty)
values (585025, 'easy');
insert into Equipment (eid, difficulty)
values (479482, 'easy');
insert into Equipment (eid, difficulty)
values (817742, 'easy');
insert into Equipment (eid, difficulty)
values (912914, 'difficult');
insert into Equipment (eid, difficulty)
values (612943, 'easy');
insert into Equipment (eid, difficulty)
values (666290, 'difficult');
insert into Equipment (eid, difficulty)
values (011303, 'difficult');
insert into Equipment (eid, difficulty)
values (844482, 'difficult');
insert into Equipment (eid, difficulty)
values (714359, 'medium');
insert into Equipment (eid, difficulty)
values (372230, 'easy');
insert into Equipment (eid, difficulty)
values (683295, 'difficult');
insert into Equipment (eid, difficulty)
values (912819, 'easy');



insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (289845, 'Rachel', 'Evangelinos', 'Female', 2, 83, 951912, 440966, '6726970136', '5025268957',
        'revangelinos0@cnet.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (722892, 'Dionysus', 'Sanford', 'Male', 7, 38, 342718, 440966, '5764264659', '6506498117', 'dsanford1@ning.com',
        null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (212257, 'Merna', 'Shutler', 'Genderfluid', 7, 62, 197361, 440966, '9964321916', '9311967106',
        'mshutler2@ameblo.jp', 'mshutler2@blogspot.com');
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (683704, 'Reagen', 'Hounsom', 'Male', 6, 64, 015199, 440966, '6827965193', '8047304255', 'rhounsom3@usgs.gov',
        null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (756852, 'Spencer', 'Cryer', 'Male', 10, 21, 189856, 440966, '9354587100', null, 'scryer4@amazon.de', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (804364, 'Klaus', 'Darrington', 'Male', 5, 52, 118023, 440966, '7212475974', '4201830996',
        'kdarrington5@utexas.edu', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (478105, 'Georgina', 'Danaher', 'Female', 10, 57, 803303, 440966, '9846536160', '6799593360',
        'gdanaher6@people.com.cn', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (811363, 'Darci', 'Gruszka', 'Female', 10, 66, 299272, 189048, '7543626141', '9748207024',
        'dgruszka7@shareasale.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (120845, 'Donal', 'Hansel', 'Male', 7, 67, 278414, 189048, '3277453943', '7418420644', 'dhansel8@amazon.de',
        null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (284848, 'Consolata', 'Caizley', 'Female', 9, 49, 134843, 189048, '2458208573', null, 'ccaizley9@nature.com',
        'ccaizley9@si.edu');
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (976144, 'Jenilee', 'Jobke', 'Agender', 9, 71, 504920, 189048, '4658134710', '9912756504', 'jjobkea@wufoo.com',
        null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (963577, 'Lizabeth', 'Slott', 'Female', 9, 41, 697772, 189048, '4108297517', null, 'lslottb@stumbleupon.com',
        null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (883749, 'Chad', 'Gale', 'Male', 9, 45, 870729, 189048, '4682140829', '8489627016', 'cgalec@bandcamp.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (852823, 'Callean', 'Calafate', 'Agender', 6, 68, 346064, 189048, '4386294519', null, 'ccalafated@unicef.org',
        null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (375112, 'Vanessa', 'Keningham', 'Female', 1, 67, 951912, 540269, '1362449002', '8102419724',
        'vkeninghame@soup.io', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (310290, 'Rosco', 'McFadyen', 'Male', 10, 62, 342718, 540269, '3172245837', '8359706667',
        'rmcfadyenf@eepurl.com', 'rmcfadyenf@networkadvertising.org');
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (868509, 'Jerry', 'Bahike', 'Genderqueer', 9, 26, 197361, 540269, '6884222437', '6525607941',
        'jbahikeg@stumbleupon.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (248187, 'Gibby', 'Wimp', 'Male', 9, 26, 015199, 540269, '4008684556', '2487645537', 'gwimph@scribd.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (172529, 'Perri', 'Gopsell', 'Female', 3, 17, 189856, 540269, '8318244973', '6999150648',
        'pgopselli@marriott.com', 'pgopselli@cbc.ca');
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (212225, 'Rosana', 'Challens', 'Female', 8, 79, 118023, 540269, '8047978608', null, 'rchallensj@meetup.com',
        null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (750285, 'Noah', 'Offer', 'Male', 10, 51, 803303, 440966, '5136079910', '5911177567',
        'nofferk@ezinearticles.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (624049, 'Darby', 'Pozzi', 'Female', 3, 22, 299272, 440966, '3149536358', '7311799145', 'dpozzil@newsvine.com',
        null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (482580, 'Catie', 'Kinsett', 'Female', 2, 31, 278414, 189048, '3419302077', '3509611470', 'ckinsettm@dot.gov',
        'ckinsettm@php.net');
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (001843, 'Helaine', 'Daine', 'Female', 9, 50, 134843, 189048, '8424710767', '4902104944', 'hdainen@marriott.com',
        'hdainen@foxnews.com');
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (867237, 'Darn', 'Clare', 'Male', 8, 87, 504920, 540269, '5576171171', '7871823859', 'dclareo@google.de', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (179281, 'Silvester', 'Greenslade', 'Male', 5, 21, 697772, 540269, '7976537212', '8151177368',
        'sgreensladep@canalblog.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (266886, 'Leodora', 'Bisp', 'Female', 7, 12, 870729, 440966, '6052948538', null, 'lbispq@over-blog.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (280773, 'Michail', 'Creech', 'Male', 3, 64, 346064, 189048, '5037399746', '2512017796',
        'mcreechr@domainmarket.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (347118, 'Myranda', 'Thorndycraft', 'Female', 9, 36, 951912, 540269, '3763359081', '5441181476',
        'mthorndycrafts@vistaprint.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1,
                    email_2)
values (796600, 'Bobine', 'Prinett', 'Female', 10, 54, 342718, 540269, '8657416057', '3219278532',
        'bprinettt@ameblo.jp', 'bprinettt@arizona.edu');

insert into Gym_Mem (mid, gid)
values (289845, 973240);
insert into Gym_Mem (mid, gid)
values (722892, 973240);
insert into Gym_Mem (mid, gid)
values (212257, 973240);
insert into Gym_Mem (mid, gid)
values (683704, 973240);
insert into Gym_Mem (mid, gid)
values (756852, 442239);
insert into Gym_Mem (mid, gid)
values (804364, 442239);
insert into Gym_Mem (mid, gid)
values (478105, 442239);
insert into Gym_Mem (mid, gid)
values (811363, 442239);
insert into Gym_Mem (mid, gid)
values (120845, 031457);
insert into Gym_Mem (mid, gid)
values (284848, 031457);
insert into Gym_Mem (mid, gid)
values (976144, 031457);
insert into Gym_Mem (mid, gid)
values (963577, 805735);
insert into Gym_Mem (mid, gid)
values (883749, 805735);
insert into Gym_Mem (mid, gid)
values (852823, 805735);
insert into Gym_Mem (mid, gid)
values (375112, 538349);
insert into Gym_Mem (mid, gid)
values (310290, 538349);
insert into Gym_Mem (mid, gid)
values (868509, 538349);
insert into Gym_Mem (mid, gid)
values (248187, 538349);
insert into Gym_Mem (mid, gid)
values (172529, 654368);
insert into Gym_Mem (mid, gid)
values (212225, 654368);
insert into Gym_Mem (mid, gid)
values (624049, 654368);
insert into Gym_Mem (mid, gid)
values (750285, 654368);
insert into Gym_Mem (mid, gid)
values (482580, 654368);
insert into Gym_Mem (mid, gid)
values (001843, 546692);
insert into Gym_Mem (mid, gid)
values (867237, 546692);
insert into Gym_Mem (mid, gid)
values (179281, 546692);
insert into Gym_Mem (mid, gid)
values (266886, 546692);
insert into Gym_Mem (mid, gid)
values (280773, 031457);
insert into Gym_Mem (mid, gid)
values (347118, 654368);
insert into Gym_Mem (mid, gid)
values (280773, 805735);

insert into Interests (mid, interest)
values (289845, 'Strength Training');
insert into Interests (mid, interest)
values (722892, 'Kickboxing');
insert into Interests (mid, interest)
values (212257, 'Hot Yoga');
insert into Interests (mid, interest)
values (683704, 'Kickboxing');
insert into Interests (mid, interest)
values (756852, 'Zumba');
insert into Interests (mid, interest)
values (804364, 'Zumba');
insert into Interests (mid, interest)
values (478105, 'Kickboxing');
insert into Interests (mid, interest)
values (811363, 'Zumba');
insert into Interests (mid, interest)
values (120845, 'Dance');
insert into Interests (mid, interest)
values (284848, 'Hot Yoga');
insert into Interests (mid, interest)
values (976144, 'Dance');
insert into Interests (mid, interest)
values (963577, 'Hot Yoga');
insert into Interests (mid, interest)
values (883749, 'Yoga');
insert into Interests (mid, interest)
values (852823, 'Hot Yoga');
insert into Interests (mid, interest)
values (375112, 'Yoga');

insert into Orders (totalCost, oid, mcid, mid)
values (225.67, 026112, 870729, 796600);
insert into Orders (totalCost, oid, mcid, mid)
values (457.42, 314520, 951912, 347118);
insert into Orders (totalCost, oid, mcid, mid)
values (12.60, 023125, 342718, 280773);
insert into Orders (totalCost, oid, mcid, mid)
values (150.75, 682417, 197361, 266886);
insert into Orders (totalCost, oid, mcid, mid)
values (607.58, 648688, 015199, 179281);
insert into Orders (totalCost, oid, mcid, mid)
values (196.75, 458411, 189856, 867237);
insert into Orders (totalCost, oid, mcid, mid)
values (791.34, 290886, 118023, 001843);
insert into Orders (totalCost, oid, mcid, mid)
values (704.18, 743894, 803303, 482580);
insert into Orders (totalCost, oid, mcid, mid)
values (67.28, 713489, 299272, 624049);
insert into Orders (totalCost, oid, mcid, mid)
values (650.87, 271081, 278414, 750285);
insert into Orders (totalCost, oid, mcid, mid)
values (528.27, 666172, 134843, 212225);
insert into Orders (totalCost, oid, mcid, mid)
values (587.70, 629112, 504920, 172529);
insert into Orders (totalCost, oid, mcid, mid)
values (647.67, 908902, 697772, 248187);
insert into Orders (totalCost, oid, mcid, mid)
values (126.52, 720639, 870729, 868509);
insert into Orders (totalCost, oid, mcid, mid)
values (693.17, 042165, 346064, 478105);
insert into Orders (totalCost, oid, mcid, mid)
values (301.39, 065809, 951912, 375112);
insert into Orders (totalCost, oid, mcid, mid)
values (992.03, 980637, 342718, 212225);
insert into Orders (totalCost, oid, mcid, mid)
values (445.92, 570810, 197361, 976144);
insert into Orders (totalCost, oid, mcid, mid)
values (385.89, 275786, 015199, 289845);
insert into Orders (totalCost, oid, mcid, mid)
values (707.48, 266148, 189856, 722892);
insert into Orders (totalCost, oid, mcid, mid)
values (663.70, 031703, 118023, 883749);
insert into Orders (totalCost, oid, mcid, mid)
values (731.06, 546697, 803303, 624049);
insert into Orders (totalCost, oid, mcid, mid)
values (836.78, 922389, 299272, 212225);
insert into Orders (totalCost, oid, mcid, mid)
values (823.37, 944039, 278414, 248187);
insert into Orders (totalCost, oid, mcid, mid)
values (22.68, 299203, 134843, 976144);
insert into Orders (totalCost, oid, mcid, mid)
values (23.37, 640375, 504920, 375112);
insert into Orders (totalCost, oid, mcid, mid)
values (833.07, 535578, 697772, 624049);
insert into Orders (totalCost, oid, mcid, mid)
values (323.69, 619107, 870729, 266886);
insert into Orders (totalCost, oid, mcid, mid)
values (81.22, 734115, 346064, 976144);
insert into Orders (totalCost, oid, mcid, mid)
values (147.94, 888742, 951912, 001843);

insert into PersonalTraining (ptid, length, activity, tid, mid)
values (672861, 30, 'Zumba', 437262, 347118);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (424056, 90, 'Zumba', 8598191, 266886);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (696988, 90, 'Hot Yoga', 195028, 867237);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (367993, 60, 'Kickboxing', 703868, 001843);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (151145, 30, 'Strength', 282840, 482580);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (890941, 60, 'Zumba', 239932, 750285);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (957885, 60, 'Strength', 855104, 624049);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (391022, 30, 'Strength', 698643, 179281);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (909729, 60, 'Strength', 642630, 976144);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (325042, 90, 'Cardio', 992205, 867237);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (691317, 30, 'Strength', 209272, 001843);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (582176, 30, 'Zumba', 209272, 963577);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (949541, 60, 'Zumba', 130698, 289845);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (701031, 60, 'Hot Yoga', 642630, 482580);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (384749, 60, 'Hot Yoga', 992205, 212257);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (266679, 90, 'Zumba', 239932, 624049);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (784039, 30, 'Hot Yoga', 698643, 683704);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (431075, 30, 'Strength', 282293, 750285);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (238723, 90, 'Yoga', 855104, 284848);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (211872, 60, 'Zumba', 282840, 212225);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (358579, 30, 'Cardio', 437262, 478105);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (309890, 90, 'Strength', 619257, 172529);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (696230, 60, 'Hot Yoga', 928461, 001843);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (866746, 60, 'Hot Yoga', 703868, 248187);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (107334, 60, 'Kickboxing', 601222, 868509);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (238914, 60, 'Yoga', 195028, 179281);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (173736, 90, 'Hot Yoga', 282293, 310290);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (979165, 90, 'Yoga', 8598191, 280773);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (113616, 60, 'Yoga', 642630, 852823);
insert into PersonalTraining (ptid, length, activity, tid, mid)
values (195717, 30, 'Cardio', 979465, 482580);

insert into Product (pid, price, name, type)
values (958739, 22.99, 'Top', 'Apparel');
insert into Product (pid, price, name, type)
values (687423, 17.25, 'Short', 'Apparel');
insert into Product (pid, price, name, type)
values (547293, 54.99, 'Pant', 'Apparel');
insert into Product (pid, price, name, type)
values (103057, 75.99, 'Sneaker', 'Shoe');
insert into Product (pid, price, name, type)
values (311763, 14.98, 'Water bottle', 'Accessory');
insert into Product (pid, price, name, type)
values (630467, 25, 'Protein powder', 'Supplement');
insert into Product (pid, price, name, type)
values (429289, 14.66, 'Vitamin', 'Supplement');
insert into Product (pid, price, name, type)
values (704611, 35.55, 'Gym bag', 'Accessory');
insert into Product (pid, price, name, type)
values (089303, 69.99, 'Headphone', 'Tech');
insert into Product (pid, price, name, type)
values (964384, 129.99, 'Fitness tracker', 'Tech');
insert into Product (pid, price, name, type)
values (541428, 3.5, 'Nutrition bar', 'Snack');
insert into Product (pid, price, name, type)
values (797750, 4.5, 'Protein bar', 'Snack');
insert into Product (pid, price, name, type)
values (200096, 22.3, 'Compression sleeve', 'Accessory');
insert into Product (pid, price, name, type)
values (827755, 3.75, 'Fitness magazine', 'Book');
insert into Product (pid, price, name, type)
values (251937, 11.75, 'Yoga mat', 'Accessory');
insert into Product (pid, price, name, type)
values (819516, 8.99, 'Sunscreen', 'Sunscreen');
insert into Product (pid, price, name, type)
values (998311, 30.75, 'Sport bra', 'Apparel');
insert into Product (pid, price, name, type)
values (767500, 3, 'Energy drink', 'Drink');
insert into Product (pid, price, name, type)
values (465676, 6.99, 'Socks', 'Accessory');
insert into Product (pid, price, name, type)
values (971857, 21.88, 'Sunglasses', 'Accessory');
insert into Product (pid, price, name, type)
values (958238, 31.99, 'Massage gun', 'Tech');
insert into Product (pid, price, name, type)
values (748763, 27.89, 'Weight scale', 'Tech');
insert into Product (pid, price, name, type)
values (560422, 30, 'Gift card', 'Gift');
insert into Product (pid, price, name, type)
values (890139, 11.99, 'Headband', 'Headware');
insert into Product (pid, price, name, type)
values (954237, 19.99, 'Beanie', 'Headware');
insert into Product (pid, price, name, type)
values (726997, 54.99, 'Fitbase sweatshirt', 'Company Apparel');
insert into Product (pid, price, name, type)
values (645075, 24.99, 'Fitbase shirt', 'Company Apparel');
insert into Product (pid, price, name, type)
values (072905, 28.99, 'Fitbase shorts', 'Company Apparel');
insert into Product (pid, price, name, type)
values (908630, 13.45, 'Goggles', 'Accessory');
insert into Product (pid, price, name, type)
values (209379, 17.89, 'Armband', 'Accessory');

insert into Prod_Order (oid, pid)
values (026112, 209379);
insert into Prod_Order (oid, pid)
values (888742, 958739);
insert into Prod_Order (oid, pid)
values (734115, 908630);
insert into Prod_Order (oid, pid)
values (619107, 687423);
insert into Prod_Order (oid, pid)
values (535578, 072905);
insert into Prod_Order (oid, pid)
values (640375, 547293);
insert into Prod_Order (oid, pid)
values (299203, 103057);
insert into Prod_Order (oid, pid)
values (944039, 645075);
insert into Prod_Order (oid, pid)
values (922389, 311763);
insert into Prod_Order (oid, pid)
values (546697, 726997);
insert into Prod_Order (oid, pid)
values (031703, 954237);
insert into Prod_Order (oid, pid)
values (266148, 630467);
insert into Prod_Order (oid, pid)
values (275786, 890139);
insert into Prod_Order (oid, pid)
values (570810, 429289);
insert into Prod_Order (oid, pid)
values (980637, 704611);
insert into Prod_Order (oid, pid)
values (065809, 560422);
insert into Prod_Order (oid, pid)
values (042165, 089303);
insert into Prod_Order (oid, pid)
values (720639, 748763);
insert into Prod_Order (oid, pid)
values (908902, 958739);
insert into Prod_Order (oid, pid)
values (629112, 964384);
insert into Prod_Order (oid, pid)
values (666172, 687423);
insert into Prod_Order (oid, pid)
values (271081, 541428);
insert into Prod_Order (oid, pid)
values (713489, 797750);
insert into Prod_Order (oid, pid)
values (743894, 200096);
insert into Prod_Order (oid, pid)
values (290886, 827755);
insert into Prod_Order (oid, pid)
values (458411, 251937);
insert into Prod_Order (oid, pid)
values (648688, 819516);
insert into Prod_Order (oid, pid)
values (682417, 103057);
insert into Prod_Order (oid, pid)
values (023125, 998311);
insert into Prod_Order (oid, pid)
values (314520, 311763);

insert into Specialities (tid, specialty)
values (480581, 'dance');
insert into Specialities (tid, specialty)
values (8598191, 'strength');
insert into Specialities (tid, specialty)
values (195028, 'legs');
insert into Specialities (tid, specialty)
values (703868, 'arms');
insert into Specialities (tid, specialty)
values (282840, 'arms');
insert into Specialities (tid, specialty)
values (855104, 'cardio');
insert into Specialities (tid, specialty)
values (698643, 'dance');
insert into Specialities (tid, specialty)
values (992205, 'dance');
insert into Specialities (tid, specialty)
values (130698, 'arms');
insert into Specialities (tid, specialty)
values (209272, 'pilates');
insert into Specialities (tid, specialty)
values (642630, 'dance');
insert into Specialities (tid, specialty)
values (239932, 'strength');
insert into Specialities (tid, specialty)
values (282293, 'kickboxing');
insert into Specialities (tid, specialty)
values (437262, 'strength');
insert into Specialities (tid, specialty)
values (619257, 'dance');
insert into Specialities (tid, specialty)
values (249702, 'abs');
insert into Specialities (tid, specialty)
values (979465, 'pilates');
insert into Specialities (tid, specialty)
values (819670, 'strength');
insert into Specialities (tid, specialty)
values (846958, 'endurance');
insert into Specialities (tid, specialty)
values (282293, 'arms');
insert into Specialities (tid, specialty)
values (642630, 'pilates');
insert into Specialities (tid, specialty)
values (398402, 'pilates');
insert into Specialities (tid, specialty)
values (282293, 'strength');
insert into Specialities (tid, specialty)
values (601222, 'endurance');
insert into Specialities (tid, specialty)
values (928461, 'cardio');

insert into Train_Equip (tid, eid)
values (523907, 033901);
insert into Train_Equip (tid, eid)
values (480581, 076815);
insert into Train_Equip (tid, eid)
values (846958, 474120);
insert into Train_Equip (tid, eid)
values (928461, 612943);
insert into Train_Equip (tid, eid)
values (979465, 612943);
insert into Train_Equip (tid, eid)
values (601222, 474120);
insert into Train_Equip (tid, eid)
values (437262, 076815);
insert into Train_Equip (tid, eid)
values (282293, 033901);
insert into Train_Equip (tid, eid)
values (239932, 780229);
insert into Train_Equip (tid, eid)
values (398402, 714359);
insert into Train_Equip (tid, eid)
values (642630, 844482);
insert into Train_Equip (tid, eid)
values (282293, 011303);
insert into Train_Equip (tid, eid)
values (209272, 612943);
insert into Train_Equip (tid, eid)
values (846958, 817742);
insert into Train_Equip (tid, eid)
values (819670, 383447);
insert into Train_Equip (tid, eid)
values (130698, 143877);
insert into Train_Equip (tid, eid)
values (979465, 076815);
insert into Train_Equip (tid, eid)
values (992205, 474120);
insert into Train_Equip (tid, eid)
values (698643, 307720);
insert into Train_Equip (tid, eid)
values (249702, 819176);
insert into Train_Equip (tid, eid)
values (855104, 234270);
insert into Train_Equip (tid, eid)
values (619257, 413558);
insert into Train_Equip (tid, eid)
values (437262, 171017);
insert into Train_Equip (tid, eid)
values (282840, 410345);
insert into Train_Equip (tid, eid)
values (282293, 849264);
insert into Train_Equip (tid, eid)
values (703868, 011303);
insert into Train_Equip (tid, eid)
values (195028, 714359);
insert into Train_Equip (tid, eid)
values (195028, 372230);
insert into Train_Equip (tid, eid)
values (642630, 683295);
insert into Train_Equip (tid, eid)
values (8598191, 912819);
