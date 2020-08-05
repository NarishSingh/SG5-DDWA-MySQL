USE hotel;

-- 1
-- list reservations that end in July 2023
-- guest name, the room #'s, and dates
SELECT
	concat(g.FirstName, ' ', g.LastName) GuestName,
    ro.RoomNum,
    res.StartDate,
    res.EndDate
FROM guest g
INNER JOIN reservation res ON res.GuestID = g.GuestID
INNER JOIN room ro ON ro.RoomNum = res.RoomNum
WHERE res.EndDate >= '2023-07-01'
	AND res.EndDate <= '2023-07-31';

-- 4 rows

-------------------------------------------------------

-- 2
-- list of all reservations for rooms with a jacuzzi
-- guest's name, room #, and dates of reservation
SELECT
	CONCAT(g.FirstName, ' ', g.LastName) GuestName,
    ro.RoomNum,
    res.StartDate,
    res.EndDate
FROM guest g
INNER JOIN reservation res ON res.GuestID = g.GuestID
INNER JOIN room ro ON ro.RoomNum = res.RoomNum
INNER JOIN roomamenity ra ON ro.RoomNum = ra.RoomNum
WHERE AmenityId = 4;

-- 11 rows

-------------------------------------------------------

-- 3
-- list of all the rooms reserved for a chosen guest
-- name, the room(s), starting date, and how many people
SELECT
	concat(g.FirstName, ' ', g.LastName) GuestName,
    ro.RoomNum,
    res.StartDate,
    res.EndDate,
    COUNT(res.AdultCount) + COUNT(res.ChildCount) TotalOccupants
FROM guest g
INNER JOIN reservation res ON res.GuestID = g.GuestID
INNER JOIN room ro ON ro.RoomNum = res.RoomNum
WHERE g.FirstName = 'Narish'
GROUP BY ro.RoomNum;

-- 2 rows

-------------------------------------------------------

-- 4
-- a list of rooms, reservation ID, and per-room cost for each reservation
-- include all rooms, whether or not there is a reservation
SELECT
	ro.RoomNum,
    res.ReservationId,
    res.TotalRoomCost
FROM room ro
RIGHT OUTER JOIN reservation res ON res.RoomNum = ro.RoomNum
ORDER BY res.ReservationId;

-- 24 rows

-------------------------------------------------------

-- 5
-- all rooms with at least 3 guests during April 2023
SELECT
	ro.RoomNum,
    COUNT(res.AdultCount) + COUNT(res.ChildCount) TotalOccupants,
    res.StartDate,
    res.EndDate
FROM room ro
INNER JOIN reservation res ON res.RoomNum = ro.RoomNum
GROUP BY ro.RoomNum
HAVING COUNT(res.AdultCount) + COUNT(res.ChildCount) >= 3
	AND 
		((res.StartDate >= '2023-04-01' AND res.StartDate <= '2023-04-30') 
		OR (res.EndDate >= '2023-04-01' AND res.EndDate <= '2023-04-30'));

-- 1 row

-------------------------------------------------------

-- 6
-- all guest names and the number of reservations per guest
-- sorted starting with the guest with the most reservations and then by the guest's last name.
SELECT
	CONCAT(g.FirstName, ' ', g.LastName) GuestName,
    COUNT(res.ReservationId) ReservationCount
FROM guest g
INNER JOIN reservation res ON res.GuestID = g.GuestID
GROUP BY CONCAT(g.FirstName, ' ', g.LastName)
ORDER BY COUNT(res.ReservationId) DESC, g.LastName;

-- 11 rows

-------------------------------------------------------

-- 7
-- the name, address, and phone num of a guest based on a chosen phone number
SELECT
	CONCAT(g.FirstName, ' ', g.LastName) GuestName,
    ga.Address,
    g.PhoneNumber
FROM guest g
INNER JOIN guestaddress ga ON ga.GuestAddressId = g.GuestAddressId
WHERE g.PhoneNumber = '555-555-5555';

-- 1 row