USE hotel;

INSERT INTO roomtype (RoomTypeId, TypeName, BasePrice, ExtraPersonFee, StandardOccupany, MaxOccupancy)
VALUES
	(1, 'Single', 149.99, 0.00, 2, 2),
    (2, 'Double', 174.99, 10.00, 2, 4),
    (3, 'Suite', 399.99, 20.00, 3, 8);

INSERT INTO amenity (AmenityId, AmenityName, AmenityCost)
VALUES
	(1, 'Microwave', 0.00),
    (2, 'Refrigerator', 0.00),
    (3, 'Oven', 0.00),
    (4, 'Jacuzzi', 25.00);
    
INSERT INTO room (RoomNum, RoomTypeId, AdaAccessible)
VALUES
	(201, 2, false),
    (202, 2, true),
    (203, 2, false),
    (204, 2, true),
    (205, 1, false),
    (206, 1, true),
    (207, 1, false),
    (208, 1, true),
    (301, 2, false),
    (302, 2, true),
    (303, 2, false),
    (304, 2, true),
    (305, 1, false),
    (306, 1, true),
    (307, 1, false),
    (308, 1, true),
    (401, 3, true),
    (402, 3, true);
    
INSERT INTO roomamenity (RoomNum, AmenityId)
VALUES
	(201, 1),
    (201, 4),
    (202, 2),
    (203, 1),
    (203, 4),
    (204, 2),
    (205, 1),
    (205, 2),
    (205, 4),
    (206, 1),
    (206, 2),
    (207, 1),
    (207, 2),
    (207, 4),
    (208, 1),
    (208, 2),
    (301, 1),
    (301, 4),
    (302, 2),
    (303, 1),
    (303, 4),
    (304, 2),
    (305, 1),
    (305, 2),
    (305, 4),
    (306, 1),
    (306, 2),
    (307, 1),
    (307, 2),
    (307, 4),
    (308, 1),
    (308, 2),
    (401, 1),
    (401, 2),
    (401, 3),
    (402, 1),
    (402, 2),
    (402, 3);

INSERT INTO guestaddress (GuestAddressId, Address, City, State, ZipCode)
VALUES
	(1, '100-10 Testing Blvd', 'NYC', 'NY', '55555'),
    (2, '379 Old Shore Street', 'Council Bluffs', 'IA', '51501'),
    (3, '750 Wintergreen Dr.', 'Wasilla', 'AK', '99654'),
    (4, '9662 Foxrun Lane', 'Harlingen', 'TX', '78552'),
    (5, '9378 W. Augusta Ave.', 'West Deptford', 'NJ', '08096'),
    (6, '762 Wild Rose Street', 'Saginaw', 'MI', '48601'),
    (7, '7 Poplar Dr.', 'Arvada', 'CO', '80003'),
    (8, '70 Oakwood St.', 'Zion', 'IL', '60099'),
    (9, '7556 Arrowhead St.', 'Cumberland', 'RI', '02864'),
    (10, '77 West Surrey Street', 'Oswego', 'NY', '13126'),
    (11, '939 Linda Rd.', 'Burke', 'VA', '22015'),
    (12, '87 Queen St.', 'Drexel Hill', 'PA', '19026');
    
INSERT INTO guest (FirstName, LastName, PhoneNumber, GuestAddressId)
VALUES
	('Narish', 'Singh', '555-555-5555', 1),
    ('Mack', 'Simmer', '291-553-0508', 2),
    ('Bettyann', 'Seery', '478-277-9632', 3),
    ('Duane', 'Cullison', '308-494-0198', 4),
    ('Karie', 'Yang', '214-730-0298', 5),
    ('Aurore', 'Lipton', '377-507-0974', 6),
    ('Zachery', 'Luechtefeld', '814-485-2615', 7),
    ('Jeremiah', 'Pendergrass', '279-491-0960', 8),
    ('Walter', 'Holaway', '446-396-6785', 9),
    ('Wilfred', 'Vise', '834-727-1001', 10),
    ('Maritza', 'Tilton', '446-351-6860', 11),
    ('Joleen', 'Tison', '231-893-2755', 12);

INSERT INTO reservation (RoomNum, GuestID, AdultCount, ChildCount, StartDate, EndDate, TotalRoomCost)
VALUES
	(308, 2, 1, 0, '2023-02-02', '2023-02-04', 299.98),
    (203, 3, 2, 1, '2023-02-05', '2023-02-10', 999.95),
    (305, 4, 2, 0, '2023-02-22', '2023-02-24', 349.98),
    (201, 5, 2, 2, '2023-03-06', '2023-03-07', 199.99),
    (307, 1, 1, 1, '2023-03-17', '2023-03-20', 524.97),
    (302, 6, 3, 0, '2023-03-18', '2023-03-23', 924.95),
    (202, 7, 2, 2, '2023-03-29', '2023-03-31', 349.98),
    (304, 8, 2, 0, '2023-03-31', '2023-04-05', 874.95),
    (301, 9, 1, 0, '2023-04-09', '2023-04-13', 799.96),
    (207, 10, 1, 1, '2023-04-23', '2023-04-24', 174.99),
    (401, 11, 2, 4, '2023-05-30', '2023-06-02', 1199.97),
    (206, 12, 2, 0, '2023-06-10', '2023-06-14', 599.96),
    (208, 12, 1, 0, '2023-06-10', '2023-06-14', 599.96),
    (304, 6, 3, 0, '2023-06-17', '2023-06-18', 184.99),
    (205, 1, 2, 0, '2023-06-28', '2023-07-02', 699.96),
    (204, 9, 3, 1, '2023-07-13', '2023-07-14', 184.99),
    (401, 10, 4, 2, '2023-07-18', '2023-07-21', 1259.97),
    (303, 3, 2, 1, '2023-07-28', '2023-07-29', 199.99),
    (305, 3, 1, 0, '2023-08-30', '2023-09-01', 349.98),
    (208, 2, 2, 0, '2023-09-16', '2023-09-17', 149.99),
    (203, 5, 2, 2, '2023-09-13', '2023-09-15', 399.98),
    (401, 4, 2, 2, '2023-11-22', '2023-11-25', 1199.97),
    (206, 2, 2, 0, '2023-11-22', '2023-11-25', 449.97),
    (301, 2, 2, 2, '2023-11-22', '2023-11-25', 599.97),
    (302, 11, 2, 0, '2023-12-24', '2023-12-28', 699.96);

-- Deletion of Jeremiah Pendergrass