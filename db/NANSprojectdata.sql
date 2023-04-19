CREATE DATABASE IF NOT EXISTS FitBase;
# DROP DATABASE FitBase;
SHOW DATABASES;

USE FitBase;

CREATE TABLE IF NOT EXISTS Gym
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

CREATE TABLE IF NOT EXISTS MarketingConsultant
(
    mcid  int PRIMARY KEY,
    first varchar(50) NOT NULL,
    last  varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Membership
(
    msid  int PRIMARY KEY,
    type  varchar(50) NOT NULL,
    price double      NOT NULL,
    mcid  int,
    FOREIGN KEY (mcid) REFERENCES MarketingConsultant (mcid)
);

CREATE TABLE IF NOT EXISTS Manager
(
    first    varchar(50) NOT NULL,
    last     varchar(50) NOT NULL,
    email         varchar(50) NOT NULL,
    phoneNum      varchar(20) NOT NULL,
    mnid          int PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Member
(
    mid        int PRIMARY KEY,
    first_name      varchar(50) NOT NULL,
    last_name       varchar(50) NOT NULL,
    gender     varchar(50) NOT NULL,
    years      int         NOT NULL NOT NULL,
    age        int         NOT NULL,
    mcid       int,
    FOREIGN KEY (mcid) REFERENCES MarketingConsultant (mcid),
    msid       int,
    FOREIGN KEY (msid) REFERENCES Membership (msid),
    phoneNum_1 varchar(20) NOT NULL,
    phoneNum_2 varchar(20),
    email_1    varchar(50) NOT NULL,
    email_2    varchar(50)
);

CREATE TABLE IF NOT EXISTS Trainer
(
    first  varchar(50) NOT NULL,
    last   varchar(50) NOT NULL,
    tid    int PRIMARY KEY,
    gender varchar(50) NOT NULL,
    mnid   int,
    gid    int,
    mcid   int,
    FOREIGN KEY (mnid) REFERENCES Manager (mnid),
    FOREIGN KEY (gid) REFERENCES Gym (gid),
    FOREIGN KEY (mcid) REFERENCES MarketingConsultant (mcid)
);

CREATE TABLE IF NOT EXISTS Specialities
(
    tid       int,
    specialty varchar(50) NOT NULL,
    FOREIGN KEY (tid) REFERENCES Trainer (tid)
);

CREATE TABLE IF NOT EXISTS Gym_Mem
(
    mid int,
    gid int NOT NULL,
    FOREIGN KEY (mid) REFERENCES Member (mid)
);

CREATE TABLE IF NOT EXISTS Certs
(
    tid           int,
    certification varchar(50) NOT NULL,
    FOREIGN KEY (tid) REFERENCES Trainer (tid)
);

CREATE TABLE IF NOT EXISTS Interests
(
    mid      int,
    interest varchar(50),
    FOREIGN KEY (mid) REFERENCES Member (mid)
);

CREATE TABLE IF NOT EXISTS Orders
(
    totalCost double NOT NULL,
    oid       int PRIMARY KEY,
    mcid      int,
    mid       int,
    FOREIGN KEY (mcid) REFERENCES MarketingConsultant (mcid),
    FOREIGN KEY (mid) REFERENCES Member (mid)
);

CREATE TABLE IF NOT EXISTS Product
(
    pid   int PRIMARY KEY,
    price double      NOT NULL,
    name  varchar(50) NOT NULL,
    type  varchar(50) NOT NULL
);

# DROP TABLE IF EXISTS Equipment;
CREATE TABLE IF NOT EXISTS Equipment
(
    eid        int PRIMARY KEY,
    difficulty varchar(10)
);

CREATE TABLE IF NOT EXISTS Prod_Order
(
    oid int,
    pid int,
    FOREIGN KEY (oid) REFERENCES Orders (oid),
    FOREIGN KEY (pid) REFERENCES Product (pid)
);

CREATE TABLE IF NOT EXISTS Class
(
    cid        int PRIMARY KEY,
    activity   varchar(50) NOT NULL,
    name       varchar(50) NOT NULL,
    startTime  datetime    NOT NULL,
    endTime    datetime    NOT NULL,
    roomNum    int         NOT NULL,
    totalSeats int         NOT NULL,
    tid        int,
    FOREIGN KEY (tid) REFERENCES Trainer (tid),
    mcid       int,
    FOREIGN KEY (mcid) REFERENCES MarketingConsultant (mcid)
);

CREATE TABLE IF NOT EXISTS Class_Mem
(
    mid int,
    cid int,
    FOREIGN KEY (mid) REFERENCES Member (mid),
    FOREIGN KEY (cid) REFERENCES Class (cid)
);

CREATE TABLE IF NOT EXISTS Train_Equip
(
    tid int,
    eid int,
    FOREIGN KEY (tid) REFERENCES Trainer (tid),
    FOREIGN KEY (eid) REFERENCES Equipment (eid)
);

CREATE TABLE IF NOT EXISTS PersonalTraining
(
    ptid     int PRIMARY KEY,
    length   int         NOT NULL,
    activity varchar(50) NOT NULL,
    tid      int,
    FOREIGN KEY (tid) REFERENCES Trainer (tid),
    mid      int,
    FOREIGN KEY (mid) REFERENCES Member (mid)
);

CREATE TABLE IF NOT EXISTS Discount
(
    type varchar(50),
    msid int,
    FOREIGN KEY (msid) REFERENCES Membership (msid)
);

insert into Manager (first, last, email, phoneNum, mnid) values ('Ignaz', 'Maharg', 'imaharg0@youtube.com', 213704, 760112);
insert into Manager (first, last, email, phoneNum, mnid) values ('Kally', 'Lace', 'klace1@ibm.com', 205447, 406457);
insert into Manager (first, last, email, phoneNum, mnid) values ('Bonita', 'Capstake', 'bcapstake2@51.la', 236573, 596835);
insert into Manager (first, last, email, phoneNum, mnid) values ('Had', 'Carpe', 'hcarpe3@seattletimes.com', 743740, 617784);
insert into Manager (first, last, email, phoneNum, mnid) values ('Alair', 'Kennagh', 'akennagh4@tinypic.com', 951553, 861790);
insert into Manager (first, last, email, phoneNum, mnid) values ('Francene', 'Gawler', 'fgawler5@ucsd.edu', 598409, 691445);
insert into Manager (first, last, email, phoneNum, mnid) values ('Ulrica', 'Manoch', 'umanoch6@xinhuanet.com', 948545, 270934);
insert into Manager (first, last, email, phoneNum, mnid) values ('Susanne', 'Espie', 'sespie7@free.fr', 549227, 964729);
insert into Manager (first, last, email, phoneNum, mnid) values ('Gillian', 'Scain', 'gscain8@msu.edu', 221644, 184063);
insert into Manager (first, last, email, phoneNum, mnid) values ('Marty', 'Jagiello', 'mjagiello9@tripod.com', 100394, 648372);
insert into Manager (first, last, email, phoneNum, mnid) values ('Coretta', 'Morl', 'cmorla@virginia.edu', 106519, 246048);
insert into Manager (first, last, email, phoneNum, mnid) values ('Edie', 'Shapero', 'eshaperob@amazon.com', 533592, 531160);


insert into MarketingConsultant (mcid, first, last) values (951912, 'Alasteir', 'Grieves');
insert into MarketingConsultant (mcid, first, last) values (342718, 'Aylmar', 'Piner');
insert into MarketingConsultant (mcid, first, last) values (197361, 'Ambur', 'Escalante');
insert into MarketingConsultant (mcid, first, last) values (015199, 'Xever', 'Mendus');
insert into MarketingConsultant (mcid, first, last) values (189856, 'Amitie', 'Thacke');
insert into MarketingConsultant (mcid, first, last) values (118023, 'Gillian', 'Fattorini');
insert into MarketingConsultant (mcid, first, last) values (803303, 'Robinia', 'Baverstock');
insert into MarketingConsultant (mcid, first, last) values (299272, 'Flint', 'Arthur');
insert into MarketingConsultant (mcid, first, last) values (278414, 'Luci', 'Chapellow');
insert into MarketingConsultant (mcid, first, last) values (134843, 'Zebulon', 'De Bruijn');
insert into MarketingConsultant (mcid, first, last) values (504920, 'Carolynn', 'Buckel');
insert into MarketingConsultant (mcid, first, last) values (697772, 'Devi', 'Owbrick');
insert into MarketingConsultant (mcid, first, last) values (870729, 'Georgia', 'Whyler');
insert into MarketingConsultant (mcid, first, last) values (346064, 'Terrye', 'Pickworth');


insert into Membership (msid, type, price, mcid) values (440966, 'Gold', 150.89, 803303);
insert into Membership (msid, type, price, mcid) values (189048, 'Silver', 125.81, 346064);
insert into Membership (msid, type, price, mcid) values (540269, 'Bronze', 98.31, 870729);

insert into Gym (gid, name, openTime, closeTime, street, city, state, zip) values (973240, 'Fitbase- NY', '4:36:00', '8:19:00', '3502 8th Parkway', 'Manhattan', 'NY', 31234);
insert into Gym (gid, name, openTime, closeTime, street, city, state, zip) values (442239, 'Fitbase- BOS', '5:34:00', '7:44:00', '63980 Little Fleur Court', 'Boston', 'MA', 76100);
insert into Gym (gid, name, openTime, closeTime, street, city, state, zip) values (031457, 'Fitbase- ATL', '5:00:00', '7:55:00', '0104 Veith Hill', 'Georgia', 'GA', 78275);
insert into Gym (gid, name, openTime, closeTime, street, city, state, zip) values (546692, 'Fitbase- PITT', '5:47:00', '9:21:00', '5 Oriole Junction', 'Pennsylvania', 'PA', 23974);
insert into Gym (gid, name, openTime, closeTime, street, city, state, zip) values (538349, 'Fitbase- LA', '4:45:00', '11:28:00', '1 Debra Place', 'California', 'CA', 97234);
insert into Gym (gid, name, openTime, closeTime, street, city, state, zip) values (654368, 'Fitbase- DAL', '5:44:00', '10:33:00', '5 Erie Court', 'Texas', 'TX', 54313);
insert into Gym (gid, name, openTime, closeTime, street, city, state, zip) values (805735, 'Fitbase- MIA', '4:28:00', '7:51:00', '88 Basil Road', 'Florida', 'FL', 97234);

insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Elden', 'Island', 8598191, 'Male', 760112, 973240, 299272);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Stephi', 'Stolte', 195028, 'Female', 531160, 973240, 299272);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Wang', 'Crosseland', 703868, 'Male', 531160, 973240, 299272);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Raoul', 'Nunnery', 282840, 'Male', 531160, 973240, 299272);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Dianna', 'Esche', 855104, 'Bigender', 270934, 442239, 346064);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Paco', 'Sibbe', 698643, 'Male', 270934, 442239, 346064);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Baird', 'Kringe', 992205, 'Male', 270934, 442239, 346064);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Ashton', 'Forcer', 130698, 'Male', 691445, 654368, 697772);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Katrina', 'Bourget', 209272, 'Female', 691445, 654368, 697772);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Pepito', 'Barrat', 642630, 'Male', 691445, 654368, 697772);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Saul', 'Dimbleby', 239932, 'Male', 861790, 031457, 803303);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Britt', 'Fockes', 282293, 'Female', 861790, 031457, 803303);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Xenia', 'Chisnell', 437262, 'Female', 861790, 031457, 803303);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Elbertine', 'Chisnall', 619257, 'Female', 617784, 031457, 803303);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Caril', 'Kensington', 249702, 'Female', 617784, 546692, 197361);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Ignaz', 'McKew', 979465, 'Male', 617784, 546692, 197361);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Adrien', 'Guys', 819670, 'Male', 596835, 546692, 197361);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Hastings', 'Zealy', 846958, 'Male', 596835, 546692, 197361);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('West', 'Crotty', 523907, 'Male', 596835, 546692, 197361);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Alley', 'Cristoforo', 503701, 'Male', 406457, 538349, 342718);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Pen', 'Shills', 398402, 'Male', 406457, 538349, 342718);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Nowell', 'Dyball', 930461, 'Male', 406457, 538349, 342718);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Homer', 'Saunt', 601222, 'Male', 760112, 805735, 951912);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('See', 'Pietzker', 928461, 'Male', 760112, 805735, 951912);
insert into Trainer (first, last, tid, gender, mnid, gid, mcid) values ('Mei', 'Shore', 480581, 'Female', 760112, 805735, 951912);

insert into Certs (tid, certification) values (953903, 'NSCA Certified Personal Trainer');
insert into Certs (tid, certification) values (796214, 'ISSA Certified Fitness Trainer');
insert into Certs (tid, certification) values (567420, 'NCCPT Certified Personal Trainer');
insert into Certs (tid, certification) values (839192, 'NASM Certified Personal Trainer');
insert into Certs (tid, certification) values (836442, 'ISSA Certified Fitness Trainer');
insert into Certs (tid, certification) values (905086, 'ACSM Certified Personal Trainer');
insert into Certs (tid, certification) values (069331, 'ISSA Certified Fitness Trainer');
insert into Certs (tid, certification) values (878185, 'ACE Personal Trainer Certification');
insert into Certs (tid, certification) values (872432, 'NSCA Certified Personal Trainer');
insert into Certs (tid, certification) values (548013, 'ISSA Certified Fitness Trainer');
insert into Certs (tid, certification) values (537593, 'ISSA Certified Fitness Trainer');
insert into Certs (tid, certification) values (202093, 'AFPA Certified Personal Trainer');
insert into Certs (tid, certification) values (657921, 'ACSM Certified Personal Trainer');
insert into Certs (tid, certification) values (500811, 'ISSA Certified Fitness Trainer');
insert into Certs (tid, certification) values (899050, 'NCCPT Certified Personal Trainer');
insert into Certs (tid, certification) values (009409, 'NASM Certified Personal Trainer');
insert into Certs (tid, certification) values (889298, 'NCSF Certified Personal Trainer');
insert into Certs (tid, certification) values (644028, 'AFPA Certified Personal Trainer');
insert into Certs (tid, certification) values (804683, 'ACSM Certified Personal Trainer');
insert into Certs (tid, certification) values (722736, 'NSCA Certified Personal Trainer');
insert into Certs (tid, certification) values (170915, 'AFPA Certified Personal Trainer');
insert into Certs (tid, certification) values (558763, 'NCSF Certified Personal Trainer');
insert into Certs (tid, certification) values (564010, 'NESTA Personal Fitness Trainer Certification');
insert into Certs (tid, certification) values (906291, 'NESTA Personal Fitness Trainer Certification');
insert into Certs (tid, certification) values (951002, 'NCSF Certified Personal Trainer');

insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (867016, 'zumba', 'Glow in the Dark Zumba', '2023-01-12 7:05:00', '2023-01-12 9:25:00', 900, 15, 567420, 514556);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (090630, 'kickboxing', 'Kickboxing', '2023-04-23 3:55:00', '2023-04-23 5:15:00', 26, 35, 722736, 752425);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (317839, 'yoga', 'Yoga with Goats', '2023-10-13 3:25:00', '2023-10-13 3:20:00', 560, 32, 202093, 226192);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (445626, 'yoga', 'Hot Yoga', '2023-11-24 17:15:00', '2023-11-24 18:20:00', 418, 23, 644028, 746911);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (015282, 'weights', 'Get Stronger', '2023-08-11 13:35:00', '2023-08-11 14:25:00', 84, 4, 548013, 432083);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (120599, 'weights', 'Get Stronger Arms', '2023-02-19 15:15:00', '2023-02-19 17:30:00', 742, 8, 657921, 043112);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (094351, 'body', 'Arm Sculpt', '2023-12-01 5:00:00', '2023-12-01 6:55:00', 732, 30, 878185, 605735);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (534438, 'body', 'Butt Sculpt', '2023-01-02 6:00:00', '2023-01-02 8:00:00', 332, 31, 951002, 966656);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (118354, 'zumba', 'Glow in the Dark Zumba', '2023-01-03 4:30:00', '2023-01-03 6:30:00', 699, 20, 905086, 602280);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (856088, 'kickboxing', 'Kickboxing', '2023-02-09 12:30:00', '2023-02-09 13:45:00', 41, 6, 796214, 339032);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (528526, 'yoga', 'Yoga with Goats', '2023-03-13 11:00:00', '2023-03-13 13:30:00', 325, 22, 500811, 245518);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (323399, 'yoga', 'Hot Yoga', '2023-04-17 5:00:00', '2023-04-17 7:00:00', 7, 29, 836442, 117617);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (350150, 'weights', 'Get Stronger', '2023-07-29 9:45:00', '2023-07-29 11:00:00', 96, 6, 889298, 908002);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (022825, 'weights', 'Get Stronger Arms', '2023-10-30 13:45:00', '2023-10-30 14:55:00', 517, 22, 009409, 803994);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (947273, 'body', 'Arm Sculpt', '2023-10-10 7:50:00', '2023-10-10 10:15:00', 268, 16, 804683, 117617);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (125455, 'body', 'Butt Sculpt', '2023-10-11 14:00:00', '2023-10-11 16:00:00', 132, 28, 564010, 966656);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (352149, 'zumba', 'Glow in the Dark Zumba', '2023-05-29 4:00:00', '2023-05-29 6:00:00', 179, 24, 170915, 339032);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (130156, 'kickboxing', 'Kickboxing', '2023-07-30 6:00:00', '2023-07-30 7:00:00', 139, 22, 537593, 803994);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (587013, 'yoga', 'Yoga with Goats', '2023-05-31 12:00:00', '2023-05-31 13:30:00', 373, 28, 953903, 226192);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (895933, 'yoga', 'Hot Yoga', '2023-06-02 6:45:00', '2023-06-02 7:45:00', 988, 15, 899050, 752425);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (994970, 'weights', 'Get Stronger', '2023-07-12 11:00:00', '2023-07-12 12:30:00', 50, 9, 069331, 245518);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (069268, 'weights', 'Get Stronger Arms', '2023-12-12 11:00:00', '2023-12-12 13:00:00', 531, 32, 872432, 908002);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (598163, 'body', 'Arm Sculpt', '2023-10-22 6:10:00', '2023-10-22 7:55:00', 849, 34, 558763, 602280);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (177244, 'body', 'Butt Sculpt', '2023-11-28 9:00:00', '2023-11-28 11:30:00', 186, 30, 839192, 043112);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (105066, 'zumba', 'Glow in the Dark Zumba', '2023-11-13 13:45:00', '2023-11-23 14:00:00', 407, 19, 906291, 605735);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (117815, 'kickboxing', 'Kickboxing', '2023-04-22 5:00:00', '2023-04-22 7:00:00', 724, 32, 567420, 514556);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (803662, 'yoga', 'Yoga with Goats', '2023-04-14 9:45:00', '2023-04-14 10:50:00', 886, 33, 170915, 432083);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (014343, 'yoga', 'Hot Yoga', '2023-11-13 7:40:00', '2023-11-13 8:45:00', 317, 33, 899050, 746911);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (913373, 'weights', 'Get Stronger', '2023-11-10 10:00:00', '2023-11-10 11:30:00', 26, 1, 878185, 803994);
insert into Class (cid, activity, name, startTime, endTime, roomNum, totalSeats, tid, mcid) values (123396, 'weights', 'Get Stronger Arms', '2023-12-22 16:00:00', '2023-12-22 6:00:00', 433, 4, 836442, 245518);

insert into Discount (type, msid) values ('Black Friday', 440966);
insert into Discount (type, msid) values ('Senior Citizen', 440966);
insert into Discount (type, msid) values ('Senior Citizen', 189048);
insert into Discount (type, msid) values ('Family', 440966);
insert into Discount (type, msid) values ('Veteran', 189048);
insert into Discount (type, msid) values ('Veteran', 540269);
insert into Discount (type, msid) values ('Black Friday', 189048);
insert into Discount (type, msid) values ('Black Friday', 540269);
insert into Discount (type, msid) values ('Family', 189048);
insert into Discount (type, msid) values ('Student', 189048);
insert into Discount (type, msid) values ('Family', 540269);
insert into Discount (type, msid) values ('Student', 440966);
insert into Discount (type, msid) values ('Student', 540269);

insert into Equipment (eid, difficulty) values (005556, 'easy');
insert into Equipment (eid, difficulty) values (086734, 'easy');
insert into Equipment (eid, difficulty) values (462979, 'easy');
insert into Equipment (eid, difficulty) values (740185, 'medium');
insert into Equipment (eid, difficulty) values (849264, 'easy');
insert into Equipment (eid, difficulty) values (410345, 'difficult');
insert into Equipment (eid, difficulty) values (171017, 'difficult');
insert into Equipment (eid, difficulty) values (413558, 'medium');
insert into Equipment (eid, difficulty) values (234270, 'difficult');
insert into Equipment (eid, difficulty) values (819176, 'difficult');
insert into Equipment (eid, difficulty) values (307720, 'difficult');
insert into Equipment (eid, difficulty) values (474120, 'easy');
insert into Equipment (eid, difficulty) values (076815, 'medium');
insert into Equipment (eid, difficulty) values (143877, 'easy');
insert into Equipment (eid, difficulty) values (383447, 'difficult');
insert into Equipment (eid, difficulty) values (780229, 'medium');
insert into Equipment (eid, difficulty) values (297960, 'difficult');
insert into Equipment (eid, difficulty) values (033901, 'difficult');
insert into Equipment (eid, difficulty) values (585025, 'easy');
insert into Equipment (eid, difficulty) values (479482, 'easy');
insert into Equipment (eid, difficulty) values (817742, 'easy');
insert into Equipment (eid, difficulty) values (912914, 'difficult');
insert into Equipment (eid, difficulty) values (612943, 'easy');
insert into Equipment (eid, difficulty) values (666290, 'difficult');
insert into Equipment (eid, difficulty) values (011303, 'difficult');
insert into Equipment (eid, difficulty) values (844482, 'difficult');
insert into Equipment (eid, difficulty) values (714359, 'medium');
insert into Equipment (eid, difficulty) values (372230, 'easy');
insert into Equipment (eid, difficulty) values (683295, 'difficult');
insert into Equipment (eid, difficulty) values (912819, 'easy');


insert into Gym_Mem (mid, gid) values (289845, 973240);
insert into Gym_Mem (mid, gid) values (722892, 973240);
insert into Gym_Mem (mid, gid) values (212257, 973240);
insert into Gym_Mem (mid, gid) values (683704, 973240);
insert into Gym_Mem (mid, gid) values (756852, 442239);
insert into Gym_Mem (mid, gid) values (804364, 442239);
insert into Gym_Mem (mid, gid) values (478105, 442239);
insert into Gym_Mem (mid, gid) values (811363, 442239);
insert into Gym_Mem (mid, gid) values (120845, 031457);
insert into Gym_Mem (mid, gid) values (284848, 031457);
insert into Gym_Mem (mid, gid) values (976144, 031457);
insert into Gym_Mem (mid, gid) values (963577, 805735);
insert into Gym_Mem (mid, gid) values (883749, 805735);
insert into Gym_Mem (mid, gid) values (852823, 805735);
insert into Gym_Mem (mid, gid) values (375112, 538349);
insert into Gym_Mem (mid, gid) values (310290, 538349);
insert into Gym_Mem (mid, gid) values (868509, 538349);
insert into Gym_Mem (mid, gid) values (248187, 538349);
insert into Gym_Mem (mid, gid) values (172529, 654368);
insert into Gym_Mem (mid, gid) values (212225, 654368);
insert into Gym_Mem (mid, gid) values (624049, 654368);
insert into Gym_Mem (mid, gid) values (750285, 654368);
insert into Gym_Mem (mid, gid) values (482580, 654368);
insert into Gym_Mem (mid, gid) values (001843, 546692);
insert into Gym_Mem (mid, gid) values (867237, 546692);
insert into Gym_Mem (mid, gid) values (179281, 546692);
insert into Gym_Mem (mid, gid) values (266886, 546692);
insert into Gym_Mem (mid, gid) values (280773, 031457);
insert into Gym_Mem (mid, gid) values (347118, 654368);
insert into Gym_Mem (mid, gid) values (280773, 805735);

insert into Interests (mid, interest) values (448906, 'Strength Training');
insert into Interests (mid, interest) values (709198, 'Kickboxing');
insert into Interests (mid, interest) values (053103, 'Hot Yoga');
insert into Interests (mid, interest) values (549127, 'Kickboxing');
insert into Interests (mid, interest) values (764094, 'Zumba');
insert into Interests (mid, interest) values (859592, 'Zumba');
insert into Interests (mid, interest) values (170199, 'Kickboxing');
insert into Interests (mid, interest) values (738399, 'Zumba');
insert into Interests (mid, interest) values (545791, 'Dance');
insert into Interests (mid, interest) values (709077, 'Hot Yoga');
insert into Interests (mid, interest) values (745156, 'Dance');
insert into Interests (mid, interest) values (637793, 'Hot Yoga');
insert into Interests (mid, interest) values (003102, 'Yoga');
insert into Interests (mid, interest) values (282101, 'Hot Yoga');
insert into Interests (mid, interest) values (134341, 'Yoga');
#
insert into Manager (first, last, email, phoneNum, mnid) values ('Ignaz', 'Maharg', 'imaharg0@youtube.com', 213704, 760112);
insert into Manager (first, last, email, phoneNum, mnid) values ('Kally', 'Lace', 'klace1@ibm.com', 205447, 406457);
insert into Manager (first, last, email, phoneNum, mnid) values ('Bonita', 'Capstake', 'bcapstake2@51.la', 236573, 596835);
insert into Manager (first, last, email, phoneNum, mnid) values ('Had', 'Carpe', 'hcarpe3@seattletimes.com', 743740, 617784);
insert into Manager (first, last, email, phoneNum, mnid) values ('Alair', 'Kennagh', 'akennagh4@tinypic.com', 951553, 861790);
insert into Manager (first, last, email, phoneNum, mnid) values ('Francene', 'Gawler', 'fgawler5@ucsd.edu', 598409, 691445);
insert into Manager (first, last, email, phoneNum, mnid) values ('Ulrica', 'Manoch', 'umanoch6@xinhuanet.com', 948545, 270934);
insert into Manager (first, last, email, phoneNum, mnid) values ('Susanne', 'Espie', 'sespie7@free.fr', 549227, 964729);
insert into Manager (first, last, email, phoneNum, mnid) values ('Gillian', 'Scain', 'gscain8@msu.edu', 221644, 184063);
insert into Manager (first, last, email, phoneNum, mnid) values ('Marty', 'Jagiello', 'mjagiello9@tripod.com', 100394, 648372);
insert into Manager (first, last, email, phoneNum, mnid) values ('Coretta', 'Morl', 'cmorla@virginia.edu', 106519, 246048);
insert into Manager (first, last, email, phoneNum, mnid) values ('Edie', 'Shapero', 'eshaperob@amazon.com', 533592, 531160);
#
#


insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (289845, 'Rachel', 'Evangelinos', 'Female', 2, 83, 951912, 440966, '6726970136', '5025268957', 'revangelinos0@cnet.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (722892, 'Dionysus', 'Sanford', 'Male', 7, 38, 951912, 440966, '5764264659', '6506498117', 'dsanford1@ning.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (212257, 'Merna', 'Shutler', 'Genderfluid', 7, 62, 951912, 440966, '9964321916', '9311967106', 'mshutler2@ameblo.jp', 'mshutler2@blogspot.com');
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (683704, 'Reagen', 'Hounsom', 'Male', 6, 64, 951912, 440966, '6827965193', '8047304255', 'rhounsom3@usgs.gov', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (756852, 'Spencer', 'Cryer', 'Male', 10, 21, 342718, 440966, '9354587100', null, 'scryer4@amazon.de', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (804364, 'Klaus', 'Darrington', 'Male', 5, 52, 342718, 440966, '7212475974', '4201830996', 'kdarrington5@utexas.edu', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (478105, 'Georgina', 'Danaher', 'Female', 10, 57, 342718, 440966, '9846536160', '6799593360', 'gdanaher6@people.com.cn', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (811363, 'Darci', 'Gruszka', 'Female', 10, 66, 197361, 189048, '7543626141', '9748207024', 'dgruszka7@shareasale.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (120845, 'Donal', 'Hansel', 'Male', 7, 67, 197361, 189048, '3277453943', '7418420644', 'dhansel8@amazon.de', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (284848, 'Consolata', 'Caizley', 'Female', 9, 49, 197361, 189048, '2458208573', null, 'ccaizley9@nature.com', 'ccaizley9@si.edu');
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (976144, 'Jenilee', 'Jobke', 'Agender', 9, 71, 015199, 189048, '4658134710', '9912756504', 'jjobkea@wufoo.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (963577, 'Lizabeth', 'Slott', 'Female', 9, 41, 015199, 189048, '4108297517', null, 'lslottb@stumbleupon.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (883749, 'Chad', 'Gale', 'Male', 9, 45, 015199, 189048, '4682140829', '8489627016', 'cgalec@bandcamp.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (852823, 'Callean', 'Calafate', 'Agender', 6, 68, 189856, 189048, '4386294519', null, 'ccalafated@unicef.org', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (375112, 'Vanessa', 'Keningham', 'Female', 1, 67, 189856, 540269, '1362449002', '8102419724', 'vkeninghame@soup.io', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (310290, 'Rosco', 'McFadyen', 'Male', 10, 62, 189856, 540269, '3172245837', '8359706667', 'rmcfadyenf@eepurl.com', 'rmcfadyenf@networkadvertising.org');
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (868509, 'Jerry', 'Bahike', 'Genderqueer', 9, 26, 803303, 540269, '6884222437', '6525607941', 'jbahikeg@stumbleupon.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (248187, 'Gibby', 'Wimp', 'Male', 9, 26, 803303, 540269, '4008684556', '2487645537', 'gwimph@scribd.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (172529, 'Perri', 'Gopsell', 'Female', 3, 17, 803303, 540269, '8318244973', '6999150648', 'pgopselli@marriott.com', 'pgopselli@cbc.ca');
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (212225, 'Rosana', 'Challens', 'Female', 8, 79, 278414, 540269, '8047978608', null, 'rchallensj@meetup.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (750285, 'Noah', 'Offer', 'Male', 10, 51, 278414, 440966, '5136079910', '5911177567', 'nofferk@ezinearticles.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (624049, 'Darby', 'Pozzi', 'Female', 3, 22, 278414, 440966, '3149536358', '7311799145', 'dpozzil@newsvine.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (482580, 'Catie', 'Kinsett', 'Female', 2, 31, 697772, 189048, '3419302077', '3509611470', 'ckinsettm@dot.gov', 'ckinsettm@php.net');
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (001843, 'Helaine', 'Daine', 'Female', 9, 50, 697772, 189048, '8424710767', '4902104944', 'hdainen@marriott.com', 'hdainen@foxnews.com');
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (867237, 'Darn', 'Clare', 'Male', 8, 87, 346064, 540269, '5576171171', '7871823859', 'dclareo@google.de', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (179281, 'Silvester', 'Greenslade', 'Male', 5, 21, 346064, 540269, '7976537212', '8151177368', 'sgreensladep@canalblog.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (266886, 'Leodora', 'Bisp', 'Female', 7, 12, 504920, 440966, '6052948538', null, 'lbispq@over-blog.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (280773, 'Michail', 'Creech', 'Male', 3, 64, 504920, 189048, '5037399746', '2512017796', 'mcreechr@domainmarket.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (347118, 'Myranda', 'Thorndycraft', 'Female', 9, 36, 346064, 540269, '3763359081', '5441181476', 'mthorndycrafts@vistaprint.com', null);
insert into Member (mid, first_name, last_name, gender, years, age, mcid, msid, phoneNum_1, phoneNum_2, email_1, email_2) values (796600, 'Bobine', 'Prinett', 'Female', 10, 54, 346064, 540269, '8657416057', '3219278532', 'bprinettt@ameblo.jp', 'bprinettt@arizona.edu');


insert into Orders (totalCost, oid, mcid, mid) values (225.67, 026112, 870729, 796600);
insert into Orders (totalCost, oid, mcid, mid) values (457.42, 314520, 951912, 347118);
insert into Orders (totalCost, oid, mcid, mid) values (12.60, 023125, 951912, 280773);
insert into Orders (totalCost, oid, mcid, mid) values (150.75, 682417, 342718, 266886);
insert into Orders (totalCost, oid, mcid, mid) values (607.58, 648688, 342718, 179281);
insert into Orders (totalCost, oid, mcid, mid) values (196.75, 458411, 342718, 867237);
insert into Orders (totalCost, oid, mcid, mid) values (791.34, 290886, 197361, 001843);
insert into Orders (totalCost, oid, mcid, mid) values (704.18, 743894, 197361, 482580);
insert into Orders (totalCost, oid, mcid, mid) values (67.28, 713489, 197361, 624049);
insert into Orders (totalCost, oid, mcid, mid) values (650.87, 271081, 015199, 750285);
insert into Orders (totalCost, oid, mcid, mid) values (528.27, 666172, 015199, 212225);
insert into Orders (totalCost, oid, mcid, mid) values (587.70, 629112, 803303, 172529);
insert into Orders (totalCost, oid, mcid, mid) values (647.67, 908902, 299272, 248187);
insert into Orders (totalCost, oid, mcid, mid) values (126.52, 720639, 299272, 868509);
insert into Orders (totalCost, oid, mcid, mid) values (693.17, 042165, 299272, 478105);
insert into Orders (totalCost, oid, mcid, mid) values (301.39, 065809, 134843, 375112);
insert into Orders (totalCost, oid, mcid, mid) values (992.03, 980637, 134843, 212225);
insert into Orders (totalCost, oid, mcid, mid) values (445.92, 570810, 134843, 976144);
insert into Orders (totalCost, oid, mcid, mid) values (385.89, 275786, 504920, 289845);
insert into Orders (totalCost, oid, mcid, mid) values (707.48, 266148, 504920, 722892);
insert into Orders (totalCost, oid, mcid, mid) values (663.70, 031703, 504920, 883749);
insert into Orders (totalCost, oid, mcid, mid) values (731.06, 546697, 504920, 624049);
insert into Orders (totalCost, oid, mcid, mid) values (836.78, 922389, 346064, 212225);
insert into Orders (totalCost, oid, mcid, mid) values (823.37, 944039, 346064, 248187);
insert into Orders (totalCost, oid, mcid, mid) values (22.68, 299203, 346064, 976144);
insert into Orders (totalCost, oid, mcid, mid) values (23.37, 640375, 870729, 375112);
insert into Orders (totalCost, oid, mcid, mid) values (833.07, 535578, 870729, 624049);
insert into Orders (totalCost, oid, mcid, mid) values (323.69, 619107, 870729, 266886);
insert into Orders (totalCost, oid, mcid, mid) values (81.22, 734115, 697772, 976144);
insert into Orders (totalCost, oid, mcid, mid) values (147.94, 888742, 697772, 001843);

insert into PersonalTraining (ptid, length, activity, tid, mid) values ('6728617663', 30, 'Zumba', 437262, 347118);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('4240563453', 90, 'Zumba', 437262, 347118);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('6969887944', 90, 'Hot Yoga', 282293, 280773);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('3679930615', 60, 'Kickboxing', 282293, 280773);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('1511450495', 30, 'Strength', 239932, 266886);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('8909415606', 60, 'Zumba', 239932, 266886);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('9578850069', 60, 'Strength', 642630, 179281);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('3910226817', 30, 'Strength', 642630, 179281);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('9097296773', 60, 'Strength', 642630, 867237);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('3250428191', 90, 'Cardio', 209272, 867237);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('6913174381', 30, 'Strength', 209272, 001843);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('5821768969', 30, 'Zumba', 130698, 001843);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('9495414202', 60, 'Zumba', 130698, 482580);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('7010315256', 60, 'Hot Yoga', 992205, 482580);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('3847497030', 60, 'Hot Yoga', 992205, 624049);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('2666795330', 90, 'Zumba', 698643, 624049);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('7840398081', 30, 'Hot Yoga', 698643, 750285);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('4310753000', 30, 'Strength', 855104, 750285);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('2387239180', 90, 'Yoga', 855104, 212225);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('2118724349', 60, 'Zumba', 282840, 212225);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('3585792049', 30, 'Cardio', 282840, 172529);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('3098901012', 90, 'Strength', 703868, 172529);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('6962309872', 60, 'Hot Yoga', 703868, 248187);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('8667461997', 60, 'Hot Yoga', 703868, 248187);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('1073340252', 60, 'Kickboxing', 195028, 868509);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('2389140076', 60, 'Yoga', 195028, 868509);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('1737368080', 90, 'Hot Yoga', 195028, 310290);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('9791656746', 90, 'Yoga', 8598191, 310290);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('1136169180', 60, 'Yoga', 8598191, 852823);
insert into PersonalTraining (ptid, length, activity, tid, mid) values ('1957177381', 30, 'Cardio', 8598191, 852823);

insert into Product (pid, price, name, type) values (958739, 22.99, 'Top', 'Apparel');
insert into Product (pid, price, name, type) values (687423, 17.25, 'Short', 'Apparel');
insert into Product (pid, price, name, type) values (547293, 54.99, 'Pant', 'Apparel');
insert into Product (pid, price, name, type) values (103057, 75.99, 'Sneaker', 'Shoe');
insert into Product (pid, price, name, type) values (311763, 14.98, 'Water bottle', 'Accessory');
insert into Product (pid, price, name, type) values (630467, 25, 'Protein powder', 'Supplement');
insert into Product (pid, price, name, type) values (429289, 14.66, 'Vitamin', 'Supplement');
insert into Product (pid, price, name, type) values (704611, 35.55, 'Gym bag', 'Accessory');
insert into Product (pid, price, name, type) values (089303, 69.99, 'Headphone', 'Tech');
insert into Product (pid, price, name, type) values (964384, 129.99, 'Fitness tracker', 'Tech');
insert into Product (pid, price, name, type) values (541428, 3.5, 'Nutrition bar', 'Snack');
insert into Product (pid, price, name, type) values (797750, 4.5, 'Protein bar', 'Snack');
insert into Product (pid, price, name, type) values (200096, 22.3, 'Compression sleeve', 'Accessory');
insert into Product (pid, price, name, type) values (827755, 3.75, 'Fitness magazine', 'Book');
insert into Product (pid, price, name, type) values (251937, 11.75, 'Yoga mat', 'Accessory');
insert into Product (pid, price, name, type) values (819516, 8.99, 'Sunscreen', 'Sunscreen');
insert into Product (pid, price, name, type) values (998311, 30.75, 'Sport bra', 'Apparel');
insert into Product (pid, price, name, type) values (767500, 3, 'Energy drink', 'Drink');
insert into Product (pid, price, name, type) values (465676, 6.99, 'Socks', 'Accessory');
insert into Product (pid, price, name, type) values (971857, 21.88, 'Sunglasses', 'Accessory');
insert into Product (pid, price, name, type) values (958238, 31.99, 'Massage gun', 'Tech');
insert into Product (pid, price, name, type) values (748763, 27.89, 'Weight scale', 'Tech');
insert into Product (pid, price, name, type) values (560422, 30, 'Gift card', 'Gift');
insert into Product (pid, price, name, type) values (890139, 11.99, 'Headband', 'Headware');
insert into Product (pid, price, name, type) values (954237, 19.99, 'Beanie', 'Headware');
insert into Product (pid, price, name, type) values (726997, 54.99, 'Fitbase sweatshirt', 'Company Apparel');
insert into Product (pid, price, name, type) values (645075, 24.99, 'Fitbase shirt', 'Company Apparel');
insert into Product (pid, price, name, type) values (072905, 28.99, 'Fitbase shorts', 'Company Apparel');
insert into Product (pid, price, name, type) values (908630, 13.45, 'Goggles', 'Accessory');
insert into Product (pid, price, name, type) values (209379, 17.89, 'Armband', 'Accessory');

insert into Prod_Order (oid, pid) values (389370, 209379);
insert into Prod_Order (oid, pid) values (152867, 209379);
insert into Prod_Order (oid, pid) values (564579, 908630);
insert into Prod_Order (oid, pid) values (473272, 908630);
insert into Prod_Order (oid, pid) values (819350, 072905);
insert into Prod_Order (oid, pid) values (671892, 072905);
insert into Prod_Order (oid, pid) values (881361, 645075);
insert into Prod_Order (oid, pid) values (852318, 645075);
insert into Prod_Order (oid, pid) values (542301, 726997);
insert into Prod_Order (oid, pid) values (482555, 726997);
insert into Prod_Order (oid, pid) values (776703, 954237);
insert into Prod_Order (oid, pid) values (633775, 954237);
insert into Prod_Order (oid, pid) values (114964, 890139);
insert into Prod_Order (oid, pid) values (839532, 890139);
insert into Prod_Order (oid, pid) values (057725, 560422);
insert into Prod_Order (oid, pid) values (864583, 560422);
insert into Prod_Order (oid, pid) values (922971, 748763);
insert into Prod_Order (oid, pid) values (723770, 748763);
insert into Prod_Order (oid, pid) values (200140, 958739);
insert into Prod_Order (oid, pid) values (291545, 958739);
insert into Prod_Order (oid, pid) values (809628, 687423);
insert into Prod_Order (oid, pid) values (349612, 687423);
insert into Prod_Order (oid, pid) values (882492, 687423);
insert into Prod_Order (oid, pid) values (861233, 687423);
insert into Prod_Order (oid, pid) values (576288, 547293);
insert into Prod_Order (oid, pid) values (769776, 547293);
insert into Prod_Order (oid, pid) values (028356, 103057);
insert into Prod_Order (oid, pid) values (343366, 103057);
insert into Prod_Order (oid, pid) values (884568, 311763);
insert into Prod_Order (oid, pid) values (606898, 311763);

insert into Specialities (tid, specialty) values (7962149884, 'dance');
insert into Specialities (tid, specialty) values (7227363023, 'strength');
insert into Specialities (tid, specialty) values (5008112171, 'legs');
insert into Specialities (tid, specialty) values (9062916449, 'arms');
insert into Specialities (tid, specialty) values (9050868649, 'arms');
insert into Specialities (tid, specialty) values (8724320102, 'cardio');
insert into Specialities (tid, specialty) values (5375933152, 'dance');
insert into Specialities (tid, specialty) values (1709159677, 'dance');
insert into Specialities (tid, specialty) values (5674205841, 'arms');
insert into Specialities (tid, specialty) values (8781853181, 'pilates');
insert into Specialities (tid, specialty) values (5480130242, 'dance');
insert into Specialities (tid, specialty) values (8046830984, 'strength');
insert into Specialities (tid, specialty) values (2020930889, 'kickboxing');
insert into Specialities (tid, specialty) values (8892985760, 'strength');
insert into Specialities (tid, specialty) values (8391925889, 'dance');
insert into Specialities (tid, specialty) values (6440280430, 'abs');
insert into Specialities (tid, specialty) values (9510020133, 'pilates');
insert into Specialities (tid, specialty) values (0094093474, 'strength');
insert into Specialities (tid, specialty) values (0693313161, 'endurance');
insert into Specialities (tid, specialty) values (5587631591, 'arms');
insert into Specialities (tid, specialty) values (8990502233, 'pilates');
insert into Specialities (tid, specialty) values (8364424165, 'pilates');
insert into Specialities (tid, specialty) values (9539032083, 'strength');
insert into Specialities (tid, specialty) values (5640107472, 'endurance');
insert into Specialities (tid, specialty) values (6579218010, 'cardio');

insert into Train_Equip (tid, eid) values (523907, 033901);
insert into Train_Equip (tid, eid) values (523907, 076815);
insert into Train_Equip (tid, eid) values (846958, 474120);
insert into Train_Equip (tid, eid) values (846958, 612943);
insert into Train_Equip (tid, eid) values (979465, 612943);
insert into Train_Equip (tid, eid) values (979465, 474120);
insert into Train_Equip (tid, eid) values (437262, 076815);
insert into Train_Equip (tid, eid) values (437262, 033901);
insert into Train_Equip (tid, eid) values (239932, 780229);
insert into Train_Equip (tid, eid) values (239932, 714359);
insert into Train_Equip (tid, eid) values (642630, 844482);
insert into Train_Equip (tid, eid) values (642630, 011303);
insert into Train_Equip (tid, eid) values (209272, 612943);
insert into Train_Equip (tid, eid) values (209272, 817742);
insert into Train_Equip (tid, eid) values (130698, 383447);
insert into Train_Equip (tid, eid) values (130698, 143877);
insert into Train_Equip (tid, eid) values (992205, 076815);
insert into Train_Equip (tid, eid) values (992205, 474120);
insert into Train_Equip (tid, eid) values (698643, 307720);
insert into Train_Equip (tid, eid) values (698643, 819176);
insert into Train_Equip (tid, eid) values (855104, 234270);
insert into Train_Equip (tid, eid) values (855104, 413558);
insert into Train_Equip (tid, eid) values (282840, 171017);
insert into Train_Equip (tid, eid) values (282840, 410345);
insert into Train_Equip (tid, eid) values (703868, 849264);
insert into Train_Equip (tid, eid) values (703868, 011303);
insert into Train_Equip (tid, eid) values (195028, 714359);
insert into Train_Equip (tid, eid) values (195028, 372230);
insert into Train_Equip (tid, eid) values (8598191, 683295);
insert into Train_Equip (tid, eid) values (8598191, 912819);

