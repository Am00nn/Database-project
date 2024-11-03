
--1)

create database  Hotel_Booking_System 

use Hotel_Booking_System

create table Hotall
(

H_ID int identity primary key ,
H_Name varchar (100) not null unique ,
H_location varchar (50) not null,
H_phone varchar(50) not null , 
H_rating decimal (2,1) 


)



INSERT INTO Hotall (H_Name, H_location, H_phone, H_rating)
VALUES 
('Grand Plaza', 'New York', '123-456-7890', 4.5),
('Royal Inn', 'London', '234-567-8901', 4.0),
('Ocean Breeze', 'Miami', '456-789-0123', 4.2),
('Mountain Retreat', 'Denver', '567-890-1234', 3.9),
('City Lights Hotel', 'Las Vegas', '678-901-2345', 4.7),
('Desert Oasis', 'Phoenix', '789-012-3456', 4.3),
('Lakeview Lodge', 'Minnesota', '890-123-4567', 4.1),
('Sunset Resort', 'California', '345-678-9012', 3.8);

select * from Hotall



---------------------------------------------------------------
--2)
create table Room 
(

R_ID int identity primary key , 

R_number int not null unique , 
R_type varchar(20) not null check(R_type in ('Single', 'Double', 'Suite')),
R_PricePerNight decimal (20,2) not null check (R_PricePerNight > 0),
R_IsAvailable int default 1 check (R_IsAvailable IN (0, 1)),
H_ID int not null , 
foreign key (H_ID) references Hotall(H_ID) on delete cascade on update cascade


)
drop table Room

INSERT INTO Room (H_ID, R_number, R_type, R_PricePerNight, R_IsAvailable)
VALUES 
(1, 101, 'Single', 100, 1),
(1, 102, 'Double', 150, 1),
(1, 103, 'Suite', 300, 1),
(2, 201, 'Single', 90, 1),
(2, 202, 'Double', 140, 0),
(3, 301, 'Suite', 250, 1),
(4, 401, 'Single', 120, 1),
(4, 402, 'Double', 180, 1),
(5, 501, 'Suite', 350, 1),
(5, 502, 'Single', 130, 0),
(6, 601, 'Double', 200, 1),
(6, 602, 'Suite', 400, 0),
(7, 701, 'Single', 110, 1),
(7, 702, 'Double', 160, 1),
(8, 801, 'Suite', 380, 1),
(8, 802, 'Single', 140, 1);


select * from Room

---------------------------------------------------
--3) 

create table Guest
(

G_ID int identity primary key , 
G_Name varchar (50) not null, 
G_IDProofType varchar (50) not null ,
G_IDProofNumber varchar(50) not null , 
G_phone varchar (20) not null

)

INSERT INTO Guest (G_Name, G_phone, G_IDProofType, G_IDProofNumber)
VALUES 
('John Doe', '567-890-1234', 'Passport', 'A1234567'),
('Alice Smith', '678-901-2345', 'Driver License', 'D8901234'),
('Robert Brown', '789-012-3456', 'ID Card', 'ID567890'),
('Sophia Turner', '012-345-6789', 'Passport', 'B2345678'),
('James Lee', '123-456-7890', 'ID Card', 'ID890123'),
('Emma White', '234-567-8901', 'Driver License', 'DL3456789'),
('Daniel Kim', '345-678-9012', 'Passport', 'C3456789'),
('Olivia Harris', '456-789-0123', 'ID Card', 'ID234567'),
('Noah Brown', '567-890-1234', 'Driver License', 'DL4567890'),
('Ava Scott', '678-901-2345', 'Passport', 'D4567890'),
('Mason Clark', '789-012-3456', 'ID Card', 'ID345678');

select * from Guest  

------------------------------------------------------------

--4)


create table Booking 
(
B_ID int identity primary key , 
B_CheckInDate date not null , 
B_CheckOutDate date not null,
B_BookingDate date not null , 
B_cost decimal (10,2),
B_Status varchar(10) not null  default 'Pending'check (B_Status in ('Pending', 'Confirmed', 'Canceled', 'Check-in', 'Check-out')),
R_ID int not null , 
G_ID  int not null ,

foreign key (R_ID) references Room(R_ID) on delete cascade on update cascade ,
foreign key (G_ID) references Guest(G_ID) on delete cascade on update cascade


)

INSERT INTO Booking (G_ID, R_ID, B_BookingDate, B_CheckInDate, B_CheckOutDate, B_Status, B_cost)
VALUES 
(1, 1, '2024-10-01', '2024-10-05', '2024-10-10', 'Confirmed', 500),
(2, 2, '2024-10-15', '2024-10-20', '2024-10-25', 'Pending', 750),
(3, 3, '2024-10-05', '2024-10-07', '2024-10-09', 'Check-in', 600),
(4, 4, '2024-10-10', '2024-10-12', '2024-10-15', 'Confirmed', 360),
(5, 5, '2024-10-16', '2024-10-18', '2024-10-21', 'Pending', 540),
(6, 6, '2024-10-05', '2024-10-08', '2024-10-12', 'Check-in', 800),
(7, 7, '2024-10-22', '2024-10-25', '2024-10-28', 'Confirmed', 450),
(8, 8, '2024-10-15', '2024-10-18', '2024-10-20', 'Pending', 420),
(1, 9, '2024-10-25', '2024-10-27', '2024-10-29', 'Confirmed', 340),
(2, 10, '2024-10-19', '2024-10-21', '2024-10-24', 'Check-in', 480);




----------------------------------------------------------------------
--5 

create table Payment 
(
P_ID int identity primary key , 
P_Method varchar (100),
P_Amount decimal (10,2),
P_Date date not null ,
B_ID int not null , 
foreign key (B_ID) references Booking(B_ID) on delete cascade on update cascade 

)

INSERT INTO Payment (B_ID, P_Date, P_Amount, P_Method)
VALUES 
(1, '2024-10-02', 250, 'Credit Card'),
(1, '2024-10-06', 250, 'Credit Card'),
(2, '2024-10-16', 750, 'Debit Card'),
(4, '2024-10-11', 180, 'Credit Card'),
(4, '2024-10-14', 180, 'Credit Card'),
(5, '2024-10-17', 270, 'Debit Card'),
(5, '2024-10-20', 270, 'Credit Card'),
(6, '2024-10-06', 400, 'Cash'),
(6, '2024-10-09', 400, 'Credit Card'),
(7, '2024-10-23', 450, 'Debit Card');


select * from Payment

---------------------------------------------
--6)

create table staff 
(
S_ID int identity primary key ,  
H_ID int not null , 
foreign key (H_ID) references Hotall(H_ID) on delete cascade on update cascade,
S_Name varchar (100) not null , 
P_phonee varchar (20) not null , 
P_Position varchar (50)not null 



)



INSERT INTO Staff (S_Name, P_Position, P_phonee, H_ID)
VALUES 
('Michael Johnson', 'Manager', '890-123-4567', 1),
('Emily Davis', 'Receptionist', '901-234-5678', 2),
('David Wilson', 'Housekeeper', '012-345-6789', 3),
('Laura Thompson', 'Manager', '901-234-5678', 4),
('Ryan Foster', 'Receptionist', '012-345-6789', 5),
('Sophia Roberts', 'Housekeeper', '123-456-7890', 6),
('Ethan Walker', 'Chef', '234-567-8901', 7),
('Liam Mitchell', 'Security', '345-678-9012', 8),
('Isabella Martinez', 'Manager', '456-789-0123', 1);

select * from Staff

-----------------------------------------------------------------

--7)


create table Review 
(
Review_ID int identity primary key ,  
Review_comments text , 
Review_Date date not null ,
Review_Rating int not null check (Review_Rating between 1 and 5) , 
H_ID int not null , 
G_ID int not null ,
foreign key (H_ID) references Hotall(H_ID) on delete cascade on update cascade,
foreign key (G_ID) references Guest(G_ID) on delete cascade on update cascade,


)

INSERT INTO Review (G_ID, H_ID, Review_Rating, Review_comments, Review_Date)
VALUES 
(1, 1, 5, 'Excellent stay!', '2024-10-11'),
(2, 2, 4, 'Good service, but room was small.', '2024-10-26'),
(3, 3, 3, 'Average experience.', '2024-10-12'),
(4, 1, 4, 'Good experience, but room service was slow.', '2024-10-16'),
(5, 2, 5, 'Amazing ambiance and friendly staff.', '2024-10-20'),
(6, 3, 3, 'Decent stay, but room cleanliness needs improvement.', '2024-10-25'),
(7, 4, 4, 'Great location, will visit again!', '2024-10-27'),
(8, 5, 2, 'Not satisfied with the facilities.', '2024-10-29');

select * from Review

select * from Room
------------------------------------------------------------------------------
--part (2):

--1. Indexing Requirements 
--A)
-- Add a non-clustered index on the Name column to optimize queries that search for hotels by name. 
create Nonclustered index idx_H_Name ON Hotall (H_Name)

-- Add a non-clustered index on the Rating column to speed up queries that filter hotels by rating.
create Nonclustered index idx_H_Rating ON Hotall (H_rating)

SELECT *
FROM sys.indexes
WHERE object_id = OBJECT_ID('Hotall');

--B)

create Nonclustered index index_room
on Room(H_ID, R_number)

--c)

--Add a non-clustered index on GuestID to optimize guest-related booking searches.
create Nonclustered index idx_Guest_ID ON Booking (G_ID)

-- Add a non-clustered index on the Status column to improve filtering of bookings by status.
create Nonclustered index idx_Booking_Status ON Booking (B_Status);

-- Add a composite index on RoomID, CheckInDate, and CheckOutDate for efficient querying of  booking schedules.
create Nonclustered index idx_Room_Checkin_Checkout ON Booking (R_ID, B_CheckInDate, B_CheckOutDate)

---------------------------------------------------------
--View 1: View_Top_RatedHotels

create view View_Top_Rated_Hotel as

select  h.H_Name, h.H_location, count(r.R_ID) AS RooomCount,avg(R.R_PricePerNight) AS Avg_RoomzzPrice
FROM  Hotall H inner join Room r on h.H_ID = r.H_ID where h.H_rating > 4.5
group  by h.H_Name, h.H_location

select * from View_Top_Rated_Hotel

select * from Hotall



--View 2: View_Guest_Bookings

create view ViewGuestBookings AS
select G.G_Name,  G.G_phone,sum(B.B_cost) as TotalAmountSpent , count(B.B_ID) as TotalBookings
from Guest G inner join   Booking B on G.G_ID = B.G_ID
group by G.G_Name, G.G_phone
  

select * from ViewGuestBookings



--View 3: View_Available_Rooms

create view View_Available_Rooms as 
select h.H_Name, r.R_type, min (r.R_PricePerNight) as 'Min_Price ', max(r.R_PricePerNight) AS 'Max_Price' , count(r.R_ID) AS 'Available_Rooms'
from  Hotall h inner join Room r on h.H_ID = r.H_ID
where  r.R_IsAvailable = 1 group by h.H_Name , r.R_type


select * from View_Available_Rooms


--View 4: ViewBookingSummary

create view View_Booking_Summary AS
select 
    H.H_Name AS HotelName,
    count(B.B_ID) AS TotalBookings,
    (select count(*) 
     from Booking B1 
     inner join Room R1 on B1.R_ID = R1.R_ID
     where R1.H_ID = H.H_ID AND B1.B_Status = 'Confirmed') as 'ConfirmedBookings',
    (select count(*) 
     from Booking B1 
     inner join Room R1 on B1.R_ID = R1.R_ID
     where R1.H_ID = H.H_ID AND B1.B_Status = 'Pending') as 'PendingBookings',
    (select count(*) 
     from Booking B1 
     inner join Room R1 on B1.R_ID = R1.R_ID
     where R1.H_ID = H.H_ID AND B1.B_Status = 'Canceled') as 'CanceledBookings'
from 
    Hotall H
inner join 
    Room R on H.H_ID = R.H_ID
inner join 
    Booking B on R.R_ID = B.R_ID
group by 
    H.H_Name, H.H_ID


select * from View_Booking_Summary 

--View 5: ViewPaymentHistory

create view ViewPaymentHistory as
select G.G_Name as GuestName, H.H_Name as 'HotelName',sum(P.P_Amount) as 'TotalPayment' ,B.B_Status as 'BookingStatus'
FROM Payment P inner join Booking B on P.B_ID = B.B_ID
inner join  Guest G on B.G_ID = G.G_ID
inner join  Room R on B.R_ID = R.R_ID
inner join  Hotall H on R.H_ID = H.H_ID
group by  G.G_Name, H.H_Name, B.B_Status

select * from ViewPaymentHistory


---------------------------------------------------------------------

--Function 1: GetHotelAverageRating

create function Get_Hotel_Avg_Rating
(@H_ID int) 
returns decimal(3, 2) 
as
begin
    declare @Avg_Rating decimal(3, 2) 
    
    select @Avg_Rating = avg(Review_Rating)from Review where H_ID = @H_ID
	return isnull(@Avg_Rating, 0)
end

select dbo.Get_Hotel_Avg_Rating(1)

drop function  Get_Hotel_Avg_Rating


--Function 2: GetNextAvailableRoom

create function GetNextAvailableRoom(
    @H_ID INT, 
    @R_Type VARCHAR(20)
)
returns varchar(100) 
as
begin
    declare @RoomDetails varchar(100);

    select top 1 @RoomDetails = 
        'Room ID: ' + convert(varchar, R_ID) + 
        ', Room Number: ' + convert(varchar, R_number) + 
        ', Room Type: ' + R_type + 
        ', Price per Night: ' + convert(varchar, R_PricePerNight)
    from Room
    where H_ID = @H_ID AND R_type = @R_Type AND R_IsAvailable = 1
    order by R_number;

    return isnull(@RoomDetails, 'No available rooms'); 
end


select dbo.GetNextAvailableRoom(2, 'Single') AS Next_Available_Room

--drop function GetNextAvailableRoom

--Function 3: CalculateOccupancyRate

create function CalculateOccupancyRatee
(@HotelID int)
returns decimal(5, 2)
as
begin
    return (
        select 
            (count(distinct B.R_ID) * 1.0 / count(R.R_ID)) * 100 as 'OccupancyRate'
        from Room R  
        left join Booking B on R.R_ID = B.R_ID 
            and B.B_CheckInDate <= getdate() 
            and B.B_CheckOutDate >= dateadd(day, -30, getdate())
        where R.H_ID = @HotelID
    )
end

select dbo.CalculateOccupancyRatee(1) AS Occupancy_Rate

--drop function CalculateOccupancyRatee

-------------------------------------------------------------------------
--Stored Procedure 1: sp_MarkRoomUnavailable
create procedure sp_MarkRoomUnavailable
@R_ID int
as
begin
    update Room set R_IsAvailable = 0 where R_ID = @R_ID
end
exec sp_MarkRoomUnavailable @R_ID = 1
-------------------------------------------------

--Stored Procedure 2: sp_UpdateBookingStatus
create procedure sp_UpdateBookingStatuss
    @UpdateBooking varchar(20),
    @B_ID int
AS
begin
    update Booking set B_Status = @UpdateBooking where B_ID = @B_ID;
end

exec sp_UpdateBookingStatuss @UpdateBooking = 'Confirmed', @B_ID = 1



---------------------------------------------------------

--Stored Procedure 3: sp_RankGuestsBySpending
create Procedure sp_RankGuestsBySpending
as
begin
    with RankedGuests as (
        select G.G_ID  ,G.G_Name,sum(B.B_cost) AS TotalSpending, row_number() over (order by sum(B.B_cost) desc) as Ranking
        from  Guest G inner join Booking B on G.G_ID = B.G_ID
        group by G.G_ID, G.G_Name
    )
    select Ranking , G_ID, G_Name,TotalSpending
    from RankedGuests
    order by Ranking
end


exec sp_RankGuestsBySpending



--------------------------------------------------------
--Trigger 1: trg_UpdateRoomAvailability
create trigger trg_UpdateRoomAvailability
on Booking
after insert
as
begin
    update R set R.R_IsAvailable = 0
    from Room R inner join inserted I on R.R_ID = I.R_ID
end


update Room set R_IsAvailable = 1; 
--------------------------------------------------------
--Trigger 2: trg_CalculateTotalRevenue

create trigger TTotalRevenue
on Payment
after insert
as
select Sum(P_Amount) AS Revenue
from Payment
select *
from Payment
insert into Payment (B_ID, P_Date, P_Amount, P_Method)
values
(3, '2024-10-02', 250, 'Credit')


select * from Payment

------------------------------------------------------------------
--3. Trigger: trg_CheckInDateValidation
create trigger trg_date_booking 
ON Booking
AFTER insert ,  update
as
begin

    if exists ( SELECT 1  FROM inserted where B_CheckInDate > B_CheckOutDate  )
        
            
    begin
       
        Raiserror ('Check-out date must be on or after the check-in date.', 16, 1);
       rollback transaction   

    end
end 

select * from Booking








