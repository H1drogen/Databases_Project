CREATE TABLE Members (
    MemberID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(255),
    Surname VARCHAR2(255),
    Suspended NUMBER(1)
        DEFAULT 0 CHECK (Suspended IN (0, 1)),
    MemberType VARCHAR2(50)
        CHECK (MemberType IN ('Student', 'Staff')),
    TotalFines NUMBER(*, 2)
);

 CREATE TABLE Resources (
    ResourceID NUMBER PRIMARY KEY,
    ResourceType VARCHAR2(50)
        CHECK (ResourceType IN ('Electronic_Device', 'eBook', 'Physical_Book')),
    AvailableCopies NUMBER,
    LoanPeriod  NUMBER
);

CREATE TABLE Electronic_Device (
    DeviceID NUMBER PRIMARY KEY,
    ResourceID NUMBER,
    PRODUCTNAME VARCHAR2(255),
    DeviceType VARCHAR2(50)
        CHECK (DeviceType IN ('Laptop', 'Tablet', 'eBookReader')),
    ShelfNo NUMBER(5),
    FloorNo NUMBER(5)
        CHECK (FloorNo < 4),
    TotalDevices NUMBER,
    FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID)
);

CREATE TABLE eBook (
    EBookID NUMBER PRIMARY KEY,
    ResourceID NUMBER,
    Title VARCHAR2(255),
    ISBN NUMBER(15)
        UNIQUE,
    ClassNo NUMBER,
    AccessLimit NUMBER,
    FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID)
);

CREATE TABLE Physical_Book (
    PhysicalBookID NUMBER PRIMARY KEY,
    ResourceID NUMBER,
    Title VARCHAR2(255),
    ISBN NUMBER(15)
        UNIQUE,
    ShelfNo NUMBER(5),
    FloorNo NUMBER(5),
    ClassNo NUMBER,
    TotalCopies NUMBER,
    FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID)
);

CREATE TABLE Reservations (
    ReservationID NUMBER PRIMARY KEY,
    ResourceID,
    MemberID,
    ReservationMade DATE,
    ReservationStatus VARCHAR2(50)
        CHECK (ReservationStatus IN ('Pending', 'Accepted', 'Cancelled', 'Notified')),
    OfferDate DATE,
    Strikes NUMBER(1)
        DEFAULT 0 CHECK (Strikes < 4),
    FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)

);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    ResourceID NUMBER,
    MemberID NUMBER,
    LoanedDays NUMBER,
    LoanDate DATE,
    DueDate DATE,
    FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

CREATE TABLE Loans_History (
    LoanHistoryID NUMBER PRIMARY KEY,
    LoanID NUMBER,
    ReturnDate DATE,
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

CREATE TABLE Fines (
    FineID NUMBER PRIMARY KEY,
    LoanID NUMBER,
    Amount NUMBER(*, 2),
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

CREATE TABLE Fines_History (
    FineHistoryID NUMBER PRIMARY KEY,
    FineID NUMBER,
    ResolutionDate DATE,
    PaidStatus VARCHAR2(50)
        CHECK (PaidStatus IN ('Paid', 'Unpaid', 'Waived')),
    FOREIGN KEY (FineID) REFERENCES Fines(FineID)
);

INSERT INTO Members (MemberID, FirstName, Surname, Suspended, MemberType, TotalFines) VALUES (1, 'Alice', 'Johnson', 0, 'Student', 0.00);
INSERT INTO Members (MemberID, FirstName, Surname, Suspended, MemberType, TotalFines) VALUES (2, 'Bob', 'Smith', 0, 'Student', 6.00);
INSERT INTO Members (MemberID, FirstName, Surname, Suspended, MemberType, TotalFines) VALUES (3, 'Carol', 'White', 1, 'Student', 8.00);
INSERT INTO Members (MemberID, FirstName, Surname, Suspended, MemberType, TotalFines) VALUES (4, 'David', 'Brown', 0, 'Student', 4.00);
INSERT INTO Members (MemberID, FirstName, Surname, Suspended, MemberType, TotalFines) VALUES (5, 'Eve', 'Davis', 0, 'Student', 4.00);
INSERT INTO Members (MemberID, FirstName, Surname, Suspended, MemberType, TotalFines) VALUES (6, 'Frank', 'Wilson', 0, 'Staff', 7.00);
INSERT INTO Members (MemberID, FirstName, Surname, Suspended, MemberType, TotalFines) VALUES (7, 'Grace', 'Martinez', 0, 'Student', 3.00);
INSERT INTO Members (MemberID, FirstName, Surname, Suspended, MemberType, TotalFines) VALUES (8, 'Hank', 'Lee', 0, 'Student', 3.00);
INSERT INTO Members (MemberID, FirstName, Surname, Suspended, MemberType, TotalFines) VALUES (9, 'Ivy', 'Kim', 1, 'Student', 12.00);
INSERT INTO Members (MemberID, FirstName, Surname, Suspended, MemberType, TotalFines) VALUES (10, 'Jack', 'Moore', 0, 'Student', 8.00);

INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (1, 'Physical_Book', 30, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (2, 'Physical_Book', 15, 0);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (3, 'Physical_Book', 0, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (4, 'Physical_Book', 16, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (5, 'Physical_Book', 14, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (6, 'Physical_Book', 11, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (7, 'Physical_Book', 13, 0);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (8, 'Physical_Book', 16, 3);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (9, 'Physical_Book', 16, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (10, 'Physical_Book', 5, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (11, 'eBook', 50, 3);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (12, 'eBook', 39, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (13, 'eBook', 30, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (14, 'eBook', 44, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (15, 'eBook', 54, 3);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (16, 'eBook', 35, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (17, 'eBook', 59, 3);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (18, 'eBook', 49, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (19, 'eBook', 40, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (20, 'eBook', 45, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (21, 'Electronic_Device', 5, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (22, 'Electronic_Device', 3, 0);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (23, 'Electronic_Device', 18, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (24, 'Electronic_Device', 0, 3);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (25, 'Electronic_Device', 6, 0);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (26, 'Electronic_Device', 14, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (27, 'Electronic_Device', 17, 21);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (28, 'Electronic_Device', 9, 0);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (29, 'Electronic_Device', 0, 3);
INSERT INTO Resources (ResourceID, ResourceType, AvailableCopies, LoanPeriod) VALUES (30, 'Electronic_Device', 14, 21);

INSERT INTO Physical_Book (PhysicalBookID, ResourceID, Title, ISBN, ShelfNo, FloorNo, ClassNo, TotalCopies) VALUES (1, 1, 'Mystery at the Mansion', 1234567890124, 2, 1, 2, 30);
INSERT INTO Physical_Book (PhysicalBookID, ResourceID, Title, ISBN, ShelfNo, FloorNo, ClassNo, TotalCopies) VALUES (2, 2, 'Journey to the West', 1234567890125, 3, 1, 3, 15);
INSERT INTO Physical_Book (PhysicalBookID, ResourceID, Title, ISBN, ShelfNo, FloorNo, ClassNo, TotalCopies) VALUES (3, 3, 'Adventures in Space', 1234567890126, 4, 2, 4, 1);
INSERT INTO Physical_Book (PhysicalBookID, ResourceID, Title, ISBN, ShelfNo, FloorNo, ClassNo, TotalCopies) VALUES (4, 4, 'Secrets of the Ocean', 1234567890127, 5, 2, 5, 16);
INSERT INTO Physical_Book (PhysicalBookID, ResourceID, Title, ISBN, ShelfNo, FloorNo, ClassNo, TotalCopies) VALUES (5, 5, 'The Great Heist', 1234567890128, 6, 3, 6, 2);
INSERT INTO Physical_Book (PhysicalBookID, ResourceID, Title, ISBN, ShelfNo, FloorNo, ClassNo, TotalCopies) VALUES (6, 6, 'The Lost City', 1234567890129, 7, 1, 1, 11);
INSERT INTO Physical_Book (PhysicalBookID, ResourceID, Title, ISBN, ShelfNo, FloorNo, ClassNo, TotalCopies) VALUES (7, 7, 'Enigma Files', 1234567890130, 8, 2, 2, 13);
INSERT INTO Physical_Book (PhysicalBookID, ResourceID, Title, ISBN, ShelfNo, FloorNo, ClassNo, TotalCopies) VALUES (8, 8, 'Mystic Mountains', 1234567890131, 9, 3, 3, 17);
INSERT INTO Physical_Book (PhysicalBookID, ResourceID, Title, ISBN, ShelfNo, FloorNo, ClassNo, TotalCopies) VALUES (9, 9, 'Desert Storms', 1234567890132, 10, 2, 4, 16);
INSERT INTO Physical_Book (PhysicalBookID, ResourceID, Title, ISBN, ShelfNo, FloorNo, ClassNo, TotalCopies) VALUES (10, 10, 'Frost Chronicles', 1234567890133, 11, 1, 5, 15);

INSERT INTO eBook (EBookID, ResourceID, Title, ISBN, ClassNo, AccessLimit) VALUES (1, 11, 'Digital Fortunes', 1234567891123, 1, 50);
INSERT INTO eBook (EBookID, ResourceID, Title, ISBN, ClassNo, AccessLimit) VALUES (2, 12, 'Virtual Ventures', 1234567891124, 2, 40);
INSERT INTO eBook (EBookID, ResourceID, Title, ISBN, ClassNo, AccessLimit) VALUES (3, 13, 'Tech Trends', 1234567891125, 3, 30);
INSERT INTO eBook (EBookID, ResourceID, Title, ISBN, ClassNo, AccessLimit) VALUES (4, 14, 'Online Odyssey', 1234567891126, 4, 45);
INSERT INTO eBook (EBookID, ResourceID, Title, ISBN, ClassNo, AccessLimit) VALUES (5, 15, 'Code Chronicles', 1234567891127, 5, 55);
INSERT INTO eBook (EBookID, ResourceID, Title, ISBN, ClassNo, AccessLimit) VALUES (6, 16, 'Digital Diaries', 1234567891128, 6, 35);
INSERT INTO eBook (EBookID, ResourceID, Title, ISBN, ClassNo, AccessLimit) VALUES (7, 17, 'Web Wonders', 1234567891129, 1, 60);
INSERT INTO eBook (EBookID, ResourceID, Title, ISBN, ClassNo, AccessLimit) VALUES (8, 18, 'Cyber Saga', 1234567891130, 2, 50);
INSERT INTO eBook (EBookID, ResourceID, Title, ISBN, ClassNo, AccessLimit) VALUES (9, 19, 'Net Novels', 1234567891131, 3, 40);
INSERT INTO eBook (EBookID, ResourceID, Title, ISBN, ClassNo, AccessLimit) VALUES (10, 20, 'Binary Biographies', 1234567891132, 4, 45);

INSERT INTO Electronic_Device (DeviceID, ResourceID, ProductName, DeviceType, ShelfNo, FloorNo, TotalDevices) VALUES (1, 21, 'Dell XPS 13', 'Laptop', 1, 1, 5);
INSERT INTO Electronic_Device (DeviceID, ResourceID, ProductName, DeviceType, ShelfNo, FloorNo, TotalDevices) VALUES (2, 22, 'iPad Air', 'Tablet', 1, 1, 3);
INSERT INTO Electronic_Device (DeviceID, ResourceID, ProductName, DeviceType, ShelfNo, FloorNo, TotalDevices) VALUES (3, 23, 'Kindle Paperwhite', 'eBookReader', 1, 1, 2);
INSERT INTO Electronic_Device (DeviceID, ResourceID, ProductName, DeviceType, ShelfNo, FloorNo, TotalDevices) VALUES (4, 24, 'MacBook Pro', 'Laptop', 2, 2, 1);
INSERT INTO Electronic_Device (DeviceID, ResourceID, ProductName, DeviceType, ShelfNo, FloorNo, TotalDevices) VALUES (5, 25, 'Samsung Galaxy Tab S6', 'Tablet', 2, 2, 6);
INSERT INTO Electronic_Device (DeviceID, ResourceID, ProductName, DeviceType, ShelfNo, FloorNo, TotalDevices) VALUES (6, 26, 'Kobo Clara HD', 'eBookReader', 2, 2, 14);
INSERT INTO Electronic_Device (DeviceID, ResourceID, ProductName, DeviceType, ShelfNo, FloorNo, TotalDevices) VALUES (7, 27, 'HP Spectre x360', 'Laptop', 3, 3, 17);
INSERT INTO Electronic_Device (DeviceID, ResourceID, ProductName, DeviceType, ShelfNo, FloorNo, TotalDevices) VALUES (8, 28, 'Microsoft Surface Pro 7', 'Tablet', 3, 3, 9);
INSERT INTO Electronic_Device (DeviceID, ResourceID, ProductName, DeviceType, ShelfNo, FloorNo, TotalDevices) VALUES (9, 29, 'Nook GlowLight 3', 'eBookReader', 3, 3, 1);
INSERT INTO Electronic_Device (DeviceID, ResourceID, ProductName, DeviceType, ShelfNo, FloorNo, TotalDevices) VALUES (10, 30, 'Lenovo ThinkPad X1', 'Laptop', 3, 3, 15);


INSERT INTO Reservations (ReservationID, ResourceID, MemberID, ReservationMade, ReservationStatus, OfferDate, Strikes) VALUES (1, 3, 3, TO_DATE('2023-11-16', 'YYYY-MM-DD'), 'Pending', NULL, 0);
INSERT INTO Reservations (ReservationID, ResourceID, MemberID, ReservationMade, ReservationStatus, OfferDate, Strikes) VALUES (2, 13, 6, TO_DATE('2023-11-02', 'YYYY-MM-DD'), 'Cancelled', TO_DATE('2023-11-12', 'YYYY-MM-DD'), 2);
INSERT INTO Reservations (ReservationID, ResourceID, MemberID, ReservationMade, ReservationStatus, OfferDate, Strikes) VALUES (3, 29, 1, TO_DATE('2023-11-17', 'YYYY-MM-DD'), 'Pending', NULL, 0);
INSERT INTO Reservations (ReservationID, ResourceID, MemberID, ReservationMade, ReservationStatus, OfferDate, Strikes) VALUES (4, 15, 9, TO_DATE('2023-10-04', 'YYYY-MM-DD'), 'Cancelled', TO_DATE('2023-10-30', 'YYYY-MM-DD'), 3);
INSERT INTO Reservations (ReservationID, ResourceID, MemberID, ReservationMade, ReservationStatus, OfferDate, Strikes) VALUES (5, 18, 4, TO_DATE('2023-11-05', 'YYYY-MM-DD'), 'Accepted', TO_DATE('2023-11-06', 'YYYY-MM-DD'), 0);
INSERT INTO Reservations (ReservationID, ResourceID, MemberID, ReservationMade, ReservationStatus, OfferDate, Strikes) VALUES (6, 23, 7, TO_DATE('2023-11-06', 'YYYY-MM-DD'), 'Cancelled', TO_DATE('2023-11-14', 'YYYY-MM-DD'), 1);
INSERT INTO Reservations (ReservationID, ResourceID, MemberID, ReservationMade, ReservationStatus, OfferDate, Strikes) VALUES (7, 26, 2, TO_DATE('2023-10-07', 'YYYY-MM-DD'), 'Notified', TO_DATE('2023-11-16', 'YYYY-MM-DD'), 2);
INSERT INTO Reservations (ReservationID, ResourceID, MemberID, ReservationMade, ReservationStatus, OfferDate, Strikes) VALUES (8, 24, 5, TO_DATE('2023-11-02', 'YYYY-MM-DD'), 'Pending', TO_DATE('2023-11-13', 'YYYY-MM-DD'), 2);
INSERT INTO Reservations (ReservationID, ResourceID, MemberID, ReservationMade, ReservationStatus, OfferDate, Strikes) VALUES (9, 30, 8, TO_DATE('2023-11-09', 'YYYY-MM-DD'), 'Notified', TO_DATE('2023-11-17', 'YYYY-MM-DD'), 1);

INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (1, 12, 1, 20, TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2023-09-22', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (2, 8, 2, 5, TO_DATE('2023-09-03', 'YYYY-MM-DD'), TO_DATE('2023-09-06', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (3, 18, 3, 23, TO_DATE('2023-09-05', 'YYYY-MM-DD'), TO_DATE('2023-09-26', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (4, 15, 4, 2, TO_DATE('2023-09-07', 'YYYY-MM-DD'), TO_DATE('2023-09-10', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (5, 30, 5, 23, TO_DATE('2023-09-10', 'YYYY-MM-DD'), TO_DATE('2023-10-01', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (6, 3, 6, 23, TO_DATE('2023-09-12', 'YYYY-MM-DD'), TO_DATE('2023-10-03', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (7, 14, 7, 20, TO_DATE('2023-09-14', 'YYYY-MM-DD'), TO_DATE('2023-10-05', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (8, 17, 8, 4, TO_DATE('2023-09-17', 'YYYY-MM-DD'), TO_DATE('2023-09-20', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (9, 24, 9, 5, TO_DATE('2023-09-20', 'YYYY-MM-DD'), TO_DATE('2023-09-23', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (10, 29, 10, 3, TO_DATE('2023-09-22', 'YYYY-MM-DD'), TO_DATE('2023-09-25', 'YYYY-MM-DD'));
INSERT INTO Loans(LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (11, 12, 10, 12, TO_DATE('2023-11-06', 'YYYY-MM-DD'), TO_DATE('2023-11-27', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (12, 30, 5, 8, TO_DATE('2023-11-10', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (13, 3, 6, 6, TO_DATE('2023-11-12', 'YYYY-MM-DD'), TO_DATE('2023-12-03', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (14, 14, 7, 4, TO_DATE('2023-11-14', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (15, 17, 8, 1, TO_DATE('2023-11-17', 'YYYY-MM-DD'), TO_DATE('2023-11-20', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (16, 24, 9, 3, TO_DATE('2023-11-05', 'YYYY-MM-DD'), TO_DATE('2023-11-08', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (17, 29, 10, 3, TO_DATE('2023-11-10', 'YYYY-MM-DD'), TO_DATE('2023-11-13', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (18, 8, 2, 3, TO_DATE('2023-11-15', 'YYYY-MM-DD'), TO_DATE('2023-11-18', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (19, 18, 2, 21, TO_DATE('2023-10-26', 'YYYY-MM-DD'), TO_DATE('2023-11-16', 'YYYY-MM-DD'));
INSERT INTO Loans (LoanID, ResourceID, MemberID, LoanedDays, LoanDate, DueDate) VALUES (20, 15, 4, 3, TO_DATE('2023-11-12', 'YYYY-MM-DD'), TO_DATE('2023-11-15', 'YYYY-MM-DD'));


INSERT INTO Loans_History  (LoanID, LoanHistoryID, ReturnDate) VALUES (1, 1, TO_DATE('2023-09-21', 'YYYY-MM-DD'));
INSERT INTO Loans_History (LoanID, LoanHistoryID, ReturnDate) VALUES (2, 2, TO_DATE('2023-09-08', 'YYYY-MM-DD'));
INSERT INTO Loans_History (LoanID, LoanHistoryID, ReturnDate) VALUES (3, 3, TO_DATE('2023-09-28', 'YYYY-MM-DD'));
INSERT INTO Loans_History (LoanID, LoanHistoryID, ReturnDate) VALUES (4, 4, TO_DATE('2023-09-09', 'YYYY-MM-DD'));
INSERT INTO Loans_History (LoanID, LoanHistoryID, ReturnDate) VALUES (5, 5, TO_DATE('2023-10-03', 'YYYY-MM-DD'));
INSERT INTO Loans_History (LoanID, LoanHistoryID, ReturnDate) VALUES (6, 6, TO_DATE('2023-10-05', 'YYYY-MM-DD'));
INSERT INTO Loans_History (LoanID, LoanHistoryID, ReturnDate) VALUES (7, 7, TO_DATE('2023-10-04', 'YYYY-MM-DD'));
INSERT INTO Loans_History (LoanID, LoanHistoryID, ReturnDate) VALUES (8, 8, TO_DATE('2023-09-21', 'YYYY-MM-DD'));
INSERT INTO Loans_History (LoanID, LoanHistoryID, ReturnDate) VALUES (9, 9, TO_DATE('2023-09-25', 'YYYY-MM-DD'));
INSERT INTO Loans_History (LoanID, LoanHistoryID, ReturnDate) VALUES (10, 10, TO_DATE('2023-09-24', 'YYYY-MM-DD'));


INSERT INTO Fines (FineID, LoanID, Amount) VALUES (1, 2, 2.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (2, 3, 2.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (3, 5, 2.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (4, 5, 2.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (5, 6, 2.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (6, 8, 1.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (7, 9, 2.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (8, 13, 2.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (9, 14, 2.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (10, 15, 2.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (11, 16, 2.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (12, 17, 1.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (13, 18, 2.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (19, 6, 2.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (20, 7, 5.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (21, 9, 2.00);
INSERT INTO Fines (FineID, LoanID, Amount) VALUES (22, 10, 3.00);


INSERT INTO Fines_History (FineHistoryID, FineID, ResolutionDate, PaidStatus) VALUES (1, 1, TO_DATE('2023-09-08', 'YYYY-MM-DD'), 'Paid');
INSERT INTO Fines_History (FineHistoryID, FineID, ResolutionDate, PaidStatus) VALUES (2, 3, TO_DATE('2023-09-28', 'YYYY-MM-DD'), 'Paid');
INSERT INTO Fines_History (FineHistoryID, FineID, ResolutionDate, PaidStatus) VALUES (3, 5, TO_DATE('2023-10-03', 'YYYY-MM-DD'), 'Paid');
INSERT INTO Fines_History (FineHistoryID, FineID, ResolutionDate, PaidStatus) VALUES (4, 6, TO_DATE('2023-10-05', 'YYYY-MM-DD'), 'Paid');
INSERT INTO Fines_History (FineHistoryID, FineID, ResolutionDate, PaidStatus) VALUES (5, 8, TO_DATE('2023-09-21', 'YYYY-MM-DD'), 'Paid');
INSERT INTO Fines_History (FineHistoryID, FineID, ResolutionDate, PaidStatus) VALUES (6, 9, TO_DATE('2023-09-25', 'YYYY-MM-DD'), 'Paid');
INSERT INTO Fines_History (FineHistoryID, FineID, ResolutionDate, PaidStatus) VALUES (7, 13, TO_DATE('2023-10-22', 'YYYY-MM-DD'), 'Paid');

CREATE VIEW ResourceDetails AS
SELECT
    r.ResourceID,
    r.ResourceType,
    ed.ProductName AS ResourceName,
    NULL AS ClassNo,
    ed.TotalDevices AS TotalCopies,
    ed.ShelfNo,
    ed.FloorNo
FROM
    Resources r
    JOIN Electronic_Device ed ON r.ResourceID = ed.ResourceID
UNION ALL
SELECT
    r.ResourceID,
    r.ResourceType,
    eb.Title AS ResourceName,
    eb.ClassNo,
    eb.AccessLimit AS TotalCopies,
    NULL AS ShelfNo,
    NULL AS FloorNo
FROM
    Resources r
    JOIN eBook eb ON r.ResourceID = eb.ResourceID
UNION ALL
SELECT
    r.ResourceID,
    r.ResourceType,
    pb.Title AS ResourceName,
    pb.ClassNo,
    pb.TotalCopies,
    pb.ShelfNo,
    pb.FloorNo
FROM
    Resources r
    JOIN Physical_Book pb ON r.ResourceID = pb.ResourceID;

CREATE VIEW MemberLoanDetails AS
SELECT
    m.MemberID,
    m.FirstName,
    m.Surname,
    m.MemberType,
    COUNT(l.LoanID) AS ActiveLoans,
    CASE
        WHEN m.MemberType = 'Student' THEN 5
        WHEN m.MemberType = 'Staff' THEN 10
    END AS MaxAllowedLoans,
    CASE
        WHEN m.MemberType = 'Student' THEN 5 - COUNT(l.LoanID)
        WHEN m.MemberType = 'Staff' THEN 10 - COUNT(l.LoanID)
    END AS LoansRemaining
FROM
    Members m
    LEFT JOIN Loans l ON m.MemberID = l.MemberID
    LEFT JOIN Loans_History lh ON l.LoanID = lh.LoanID
WHERE
    lh.ReturnDate IS NULL
GROUP BY
    m.MemberID,
    m.FirstName,
    m.Surname,
    m.MemberType;


CREATE VIEW Fines_View AS
SELECT
    F.FineID,
    F.LoanID,
    F.Amount AS FineAmount,
    L.ResourceID,
    L.MemberID,
    L.LoanDate,
    L.DueDate,
    M.FirstName,
    M.Surname,
    M.MemberType,
    FH.PaidStatus,
    FH.ResolutionDate
FROM
    Fines F
JOIN
    Loans L ON F.LoanID = L.LoanID
JOIN
    Members M ON L.MemberID = M.MemberID
LEFT JOIN
    Fines_History FH ON F.FineID = FH.FineID;

SELECT * FROM Reservations
WHERE ReservationStatus = 'Pending'
ORDER BY ReservationMade ASC
FETCH FIRST 1 ROWS ONLY;

SELECT COUNT(*) AS TotalResourcesLoaned
FROM Loans
WHERE LoanDate >= TO_DATE('2023-09-01', 'YYYY-MM-DD') AND LoanDate < TO_DATE('2023-10-01', 'YYYY-MM-DD');

SELECT L.LoanID, L.ResourceID, L.MemberID, L.LoanDate, L.DueDate,
    TO_DATE('2023-11-18', 'YYYY-MM-DD') AS CurrentDate,
    TO_DATE('2023-11-18', 'YYYY-MM-DD') - L.DueDate AS OverdueDays
FROM Loans L
WHERE L.DueDate < TO_DATE('2023-11-18', 'YYYY-MM-DD')
    AND L.LoanID NOT IN (
        SELECT LoanID
        FROM Loans_History
    );

SELECT * FROM Resources
WHERE LoanPeriod = 0;

SELECT SUM(f.Amount) FROM Fines f
JOIN Fines_History fh ON f.FineID = fh.FineID
WHERE fh.PaidStatus = 'Paid';

SELECT l.LoanID, l.ResourceID, l.MemberID, l.LoanDate, l.DueDate
FROM Loans l
JOIN Resources r ON l.ResourceID = r.ResourceID
WHERE l.LoanedDays < r.LoanPeriod;


SELECT L.LoanID, L.ResourceID, L.MemberID, L.LoanedDays, L.LoanDate, L.DueDate, LH.ReturnDate FROM Loans L
LEFT JOIN Loans_History LH ON L.LoanID = LH.LoanID
WHERE L.DueDate < TO_DATE('2023-11-18', 'YYYY-MM-DD') AND LH.ReturnDate IS NULL;


SELECT PB.ResourceID, PB.Title AS ResourceTitle, PB.ISBN, 'Physical Book' AS ResourceType, PB.TotalCopies
FROM Physical_Book PB
JOIN Resources R ON PB.ResourceID = R.ResourceID
WHERE PB.FloorNo = 2
UNION
SELECT ED.ResourceID, ED.ProductName AS ResourceTitle, NULL AS ISBN, 'Electronic Device' AS ResourceType, ED.TotalDevices
FROM Electronic_Device ED
JOIN Resources R ON ED.ResourceID = R.ResourceID
WHERE ED.FloorNo = 2;


SELECT r.ResourceID, r.ResourceType, r.AvailableCopies, r.LoanPeriod, COUNT(l.LoanID) AS LoanCount
FROM Loans l
JOIN Resources r ON l.ResourceID = r.ResourceID
GROUP BY r.ResourceID, r.ResourceType, r.AvailableCopies, r.LoanPeriod
ORDER BY LoanCount DESC
FETCH FIRST 1 ROWS ONLY;

SELECT M.MemberID, M.FirstName, M.Surname, COUNT(L.LoanID) AS TotalLoans, COALESCE(SUM(F.Amount), 0) AS TotalFines
FROM Members M
LEFT JOIN Loans L ON M.MemberID = L.MemberID
LEFT JOIN Fines F ON L.LoanID = F.LoanID
GROUP BY M.MemberID, M.FirstName, M.Surname
ORDER BY TotalLoans DESC, TotalFines DESC;

SELECT R.ResourceType, AVG(L.LoanedDays) AS AverageLoanDuration
FROM Loans L
JOIN Resources R ON L.ResourceID = R.ResourceID
GROUP BY R.ResourceType
ORDER BY AverageLoanDuration DESC;

SELECT M.MemberID, M.FirstName, M.Surname, M.MemberType, M.Suspended, SUM(F.Amount) AS TotalFinesOwed FROM Members M
JOIN Loans L ON M.MemberID = L.MemberID
JOIN Fines F ON L.LoanID = F.LoanID
LEFT JOIN Fines_History FH ON F.FineID = FH.FineID
WHERE M.Suspended = 1 AND F.Amount > 0 AND FH.FineID IS NULL
GROUP BY M.MemberID, M.FirstName, M.Surname, M.MemberType, M.Suspended
HAVING SUM(F.Amount) > 0;


