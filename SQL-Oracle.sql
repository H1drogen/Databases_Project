CREATE TABLE Resources (
    ResourceID INT PRIMARY KEY,
    Title VARCHAR(255),
    ClassNumber VARCHAR(50),
    TotalCopies INT,
    AvailableCopies INT,
    LoanPeriod INT,
    Location VARCHAR(100),
    ResourceType VARCHAR(50) CHECK (ResourceType IN ('Physical', 'eBook', 'Device'))
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(255),
    MemberType VARCHAR(50) CHECK (MemberType IN ('Student', 'Staff')),
    MaxLoans INT DEFAULT 0,
    Suspended BOOLEAN DEFAULT FALSE
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    ResourceID INT,
    MemberID INT,
    LoanDate DATE,
    ReturnDate DATE,
    DueDate DATE,
    Overdue BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY,
    ResourceID INT,
    MemberID INT,
    ReservationDate DATE,
    Attempts INT DEFAULT 0,
    FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

CREATE TABLE Fines (
    FineID INT PRIMARY KEY,
    MemberID INT,
    Amount DECIMAL(5, 2),
    Paid BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

CREATE TABLE LoanHistory (
    HistoryID INT PRIMARY KEY,
    LoanID INT,
    LoanDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
                         );