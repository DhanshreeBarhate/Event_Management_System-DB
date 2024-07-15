# Creating an Event Management System(E_M_S) database containing data of attendees, events, organizers, speakers, sponsors, venues, etc.
show tables;

create database E_M_S;
use E_M_S;
-- 1. Create table Venues
CREATE TABLE Venues (
    VenueID varchar(20) PRIMARY KEY,
    VenueName char(20),
    VenueLocation char(200)
);

-- 2. Create table Events
CREATE TABLE Events (
    EventID varchar(20) PRIMARY KEY,
    EventName char(20),
    EventDescription char(200),
    EventDate date,
    VenueID varchar(20),
    FOREIGN KEY (VenueID) REFERENCES Venues(VenueID)
);
SELECT EventID FROM events;

-- 3. Create table Attendees
CREATE TABLE Attendees (
    AttendeeID varchar(20) PRIMARY KEY,
    EventID varchar(20),
    FirstName char(20),
    LastName char(20),
    Email varchar(40),
    RSVPStatus varchar(20),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

-- 4. Create table Tracks
CREATE TABLE Tracks (
    TrackID varchar(20) PRIMARY KEY,
    EventID varchar(20),
    TrackName char(200),
    TrackDescription char(200),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);


-- 5. Create table Sessions
CREATE TABLE Sessions (
    SessionID varchar(20) PRIMARY KEY,
    TrackID varchar(20),
    SessionTitle char(20),
    SessionDescription text,
    SessionStartTime datetime,
    SessionEndTime datetime,
    FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID)
);
DESC Sessions;

-- 6. Create table Speakers
create table Speakers(
SpeakerID varchar(20) primary key,
EventID Varchar(20),
SpeakerName char(20),
SpeakerBio char(200),
foreign key (EventID) references Events(EventID)
);
create table SessionSpeakers(
SessionSpeakerID varchar(20) primary key,
SessionID varchar(20),
SpeakerID varchar(20),
foreign key (SessionID) references Sessions(SessionID),
foreign key (SpeakerID) references Speakers(SpeakerID)
);



-- 7. Create table SessionAttendees
CREATE TABLE SessionAttendees (
    SessionAttendeeID varchar(225) PRIMARY KEY,
    SessionID varchar(225),
    AttendeeID varchar(225),
    FOREIGN KEY (SessionID) REFERENCES Sessions(SessionID),
    FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
);

-- 8. Create remaining tables (Skipped for brevity)

create table Schedules(
ScheduleID varchar(20) primary key,
EventID varchar(20),
StartTime datetime,
EndTime datetime,
foreign key (EventID) references Events(EventID)
);

create table Organizers(
OrganizerID varchar(20),
EventID varchar(20),
OrganizerName char(20),
OrganizerEmail varchar(20)
);

create table Sponsors(
SponsorID varchar(20) primary key,
EventID varchar(20),
SponsorName char(20),
SponsorType char(20),
SponsorLevel int,
foreign key(EventID) references Events(EventID)
);

create table EventFeedback (FeedbackID varchar(225),EventID varchar(225),AttendeeID varchar(225),FeedbackText varchar(225), Rating varchar(225) ,PRIMARY KEY (FeedbackID),
FOREIGN KEY (EventID) REFERENCES Events(EventID),FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID),CHECK (1<=Rating<=10));


CREATE TABLE EventPhotos( PhotoID varchar(255), EventID varchar(255), PhotoURL varchar(255), 
PhotoDescription varchar(255));

ALTER TABLE EventPhotos
ADD PRIMARY KEY(PhotoID);

ALTER TABLE EventPhotos
ADD FOREIGN KEY(EventID) REFERENCES Events (EventID);

CREATE TABLE EventDocuments (DocumentID varchar(255), EventID varchar(255), DocumentURL varchar(255),
DocumentTitle varchar(255));

ALTER TABLE EventDocuments
ADD PRIMARY KEY (DocumentID);

ALTER TABLE EventDocuments
ADD FOREIGN KEY(EventID) REFERENCES Events (EventID);

create table EventPolls ( PollID varchar(20), EventID varchar(20), PollQuestion varchar(255), Option1 varchar(255), Option2 varchar(255));
alter table EventPolls add primary key (PollID);
alter table EventPolls add foreign key(EventID) references Events (EventID);

create table EventPollResponses ( ResponseID varchar(20), PollID varchar(20), AttendeeID varchar(20), SelectedOption varchar(255));
alter table EventPollResponses add primary key (ResponseID);
alter table EventPollResponses add foreign key(PollID) references EventPolls (PollID);
alter table EventPollResponses add foreign key(AttendeeID) references Attendees(AttendeeID);
 
create table PaymentTransactions(TransactionID varchar(225),AttendeeID varchar(225),Amount varchar(225),PaymentStatus varchar(225),PaymentDate varchar(225),
PRIMARY KEY (TransactionID),FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID));
 
create table EventDiscounts(DiscountID varchar(225), EventID varchar(225), DiscountCode varchar(225), 
DiscountPercentage varchar(225), ValidityPeriod varchar(225),PRIMARY KEY (DiscountID) ,FOREIGN KEY (EventID) REFERENCES Events(EventID));

 
create table EventRegistrations(RegistrationID varchar(225),PRIMARY KEY (RegistrationID)
,EventID varchar(225),FOREIGN KEY (EventID) REFERENCES Events(EventID),
AttendeeID varchar(225),FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID),
RegistrationDate varchar(225));

create table EventAnalytics(AnalyticsID varchar(225),PRIMARY KEY (AnalyticsID),
EventID varchar(225),FOREIGN KEY (EventID) REFERENCES Events(EventID),
PageViews varchar(225), ClickThroughRate varchar(225),
AttendeeEngagementMetrics varchar(225));

-- 9. Insert data into Venues table (if needed)
INSERT INTO Venues (VenueID, VenueName, VenueLocation) VALUES
('VEN001', 'Convention Center', 'Mumbai'),
('VEN002', 'Grand Hotel', 'Thane'),
('VEN003', 'Mall', 'Powai'),
('VEN004', 'Grand Hotel', 'UlhasNagar'),
('VEN005', 'City Park', 'Parel');

-- 10. Insert data into Events table (if needed)
INSERT INTO Events (EventID, EventName, EventDescription, EventDate, VenueID) VALUES
('E001', 'Holi', 'Holi, also known as the Festival of Colors or the Festival of Love, is a Hindu spring festival celebrated mainly in India and Nepal, but also in other regions with significant Hindu populations.', '2023-03-23','VEN001'),
('E002', 'Sunburn', 'Sunburn is one of Asia\'s biggest electronic dance music festivals, known for its grand scale, energetic atmosphere, and top-tier lineup of international and local DJs and artists.', '2023-02-01','VEN003'),
('E003', 'Kapoor\'s Wedding', 'The Kapoor wedding extravaganza was nothing short of a fairy tale come to life. Set against the backdrop of a palatial mansion in the heart of Mumbai.', '2023-03-20','VEN005'),
('E004', 'Diwali', 'Event in Thane Talavpali', '2023-11-20','VEN003'),
('E005', 'Gudipadva', 'Event in Girnagoan', '2023-04-04','VEN001'),
('E006', 'Durga Puja', 'A major Hindu festival celebrating the victory of goddess Durga over the demon Mahishasura, observed with grand processions and elaborate pandals', '2023-10-20','VEN002'),
('E007', 'Goa Carnival', 'A colorful and vibrant festival featuring parades, music, and dance, held annually in the state of Goa', '2023-12-25','VEN004'),
('E008', 'Onam Festival', 'A harvest festival celebrated in the southern state of Kerala, featuring elaborate feasts, traditional dances, and boat races', '2023-11-11','VEN001'),
('E009', 'Pushkar Camel Fair', 'A unique cultural and livestock fair held annually in the town of Pushkar, Rajasthan, featuring camel trading, competitions, and festivities', '2023-11-30','VEN004'),
('E010', 'Navratri Festival', 'A nine-night Hindu festival celebrated with dance, music, and devotion across India', '2023-10-21','VEN001');

INSERT INTO Speakers (SpeakerID, EventID, SpeakerName, SpeakerBio)
VALUES 
    ('1', 'E001', 'John Doe', 'John Doe is an experienced speaker in the field of technology.'),
    ('2', 'E002', 'Jane Smith', 'Jane Smith has expertise in marketing and branding.'),
    ('3', 'E003', 'Michael Johnson', 'Michael Johnson is a renowned expert in finance and investments.'),
    ('4', 'E001', 'Emily Davis', 'Emily Davis specializes in project management and leadership.'),
    ('5', 'E002', 'David Brown', 'David Brown is an accomplished entrepreneur and business consultant.');




-- 11. Insert data into Attendees table (if needed)
INSERT INTO Attendees (EventID, AttendeeID, FirstName, LastName, Email, RSVPStatus) VALUES  
('E005', 'A001', 'Aarav', 'Sharma', 'aarav.sharma@example.com', 'yes'),
('E009', 'A002', 'Aashi', 'Patel', 'aashi.patel@example.com', 'no'),
('E001', 'A003', 'Aaradhya', 'Gupta', 'aaradhya.gupta@example.com', 'maybe'),
('E009', 'A004', 'Advait', 'Kumar', 'advait.kumar@example.com', 'yes'),
('E010', 'A005', 'Aditi', 'Singh', 'aditi.singh@example.com', 'no'),
('E001', 'A006', 'Advik', 'Das', 'advik.das@example.com', 'maybe'),
('E008', 'A007', 'Ahana', 'Chatterjee', 'ahana.chatterjee@example.com', 'yes'),
('E005', 'A008', 'Amit', 'Naidu', 'amit.naidu@example.com', 'no'),
('E005', 'A009', 'Amrita', 'Rao', 'amrita.rao@example.com', 'yes'),
('E005', 'A010', 'Ananya', 'Desai', 'ananya.desai@example.com', 'no'),
('E005', 'A011', 'Aryan', 'Shah', 'aryan.shah@example.com', 'maybe'),
('E001', 'A012', 'Aadhira', 'Reddy', 'aadhira.reddy@example.com', 'yes'),
('E005', 'A013', 'Aadi', 'Dutta', 'aadi.dutta@example.com', 'no'),
('E005', 'A014', 'Aarav', 'Mishra', 'aarav.mishra@example.com', 'maybe'),
('E002', 'A015', 'Aarohi', 'Nair', 'aarohi.nair@example.com', 'yes'),
('E001', 'A016', 'Aashi', 'Iyer', 'aashi.iyer@example.com', 'no'),
('E001', 'A017', 'Aarush', 'Joshi', 'aarush.joshi@example.com', 'yes'),
('E002', 'A018', 'Aahana', 'Menon', 'aahana.menon@example.com', 'no'),
('E006', 'A019', 'Aaradhya', 'Khanna', 'aaradhya.khanna@example.com', 'maybe'),
('E006', 'A020', 'Adhira', 'Gowda', 'adhira.gowda@example.com', 'yes'),
('E006', 'A021', 'Anvi', 'Rajput', 'anvi.rajput@example.com', 'no'),
('E001', 'A022', 'Arya', 'Pillai', 'arya.pillai@example.com', 'yes'),
('E005', 'A023', 'Arnav', 'Kulkarni', 'arnav.kulkarni@example.com', 'no'),
('E005', 'A024', 'Aarna', 'Saxena', 'aarna.saxena@example.com', 'maybe'),
('E006', 'A025', 'Aditi', 'Koirala', 'aditi.koirala@example.com', 'yes'),
('E002', 'A026', 'Aadhya', 'Chauhan', 'aadhya.chauhan@example.com', 'no'),
('E001', 'A027', 'Anaya', 'Thomas', 'anaya.thomas@example.com', 'yes'),
('E007', 'A028', 'Advaita', 'Gupta', 'advaita.gupta@example.com', 'no'),
('E004', 'A029', 'Ahaan', 'Sinha', 'ahaan.sinha@example.com', 'maybe'),
('E010', 'A030', 'Aarav', 'Raj', 'aarav.raj@example.com', 'yes'),
('E008', 'A031', 'Aaradhya', 'Verma', 'aaradhya.verma@example.com', 'no'),
('E002', 'A032', 'Aaryan', 'Rastogi', 'aaryan.rastogi@example.com', 'maybe'),
('E003', 'A033', 'Aadhira', 'Pande', 'aadhira.pande@example.com', 'yes'),
('E005', 'A034', 'Advik', 'Biswas', 'advik.biswas@example.com', 'no'),
('E002', 'A035', 'Amaira', 'Sharma', 'amaira.sharma@example.com', 'maybe'),
('E002', 'A036', 'Anika', 'Nair', 'anika.nair@example.com', 'yes'),
('E007', 'A037', 'Aadya', 'Menon', 'aadya.menon@example.com', 'no'),
('E006', 'A038', 'Ayaan', 'Sinha', 'ayaan.sinha@example.com', 'maybe'),
('E009', 'A039', 'Aarohi', 'Acharya', 'aarohi.acharya@example.com', 'yes'),
('E006', 'A040', 'Aarav', 'Nayar', 'aarav.nayar@example.com', 'no'),
('E010', 'A041', 'Aanya', 'Chakraborty', 'aanya.chakraborty@example.com', 'maybe'),
('E010', 'A042', 'Adhvik', 'Krishnan', 'adhvik.krishnan@example.com', 'yes'),
('E010', 'A043', 'Aaditya', 'Das', 'aaditya.das@example.com', 'no'),
('E002', 'A044', 'Aashvi', 'Balakrishnan', 'aashvi.balakrishnan@example.com', 'maybe'),
('E008', 'A045', 'Aaradhya', 'Mehra', 'aaradhya.mehra@example.com', 'yes'),
('E006', 'A046', 'Aadrika', 'Nayak', 'aadrika.nayak@example.com', 'no'),
('E010', 'A047', 'Aarna', 'Shah', 'aarna.shah@example.com', 'maybe'),
('E010', 'A048', 'Aarav', 'Gupta', 'aarav.gupta@example.com', 'yes'),
('E010', 'A049', 'Aarohi', 'Sharma', 'aarohi.sharma@example.com', 'no'),
('E002', 'A050', 'Advait', 'Nair', 'advait.nair@example.com', 'maybe'),
('E009', 'A051', 'Aditi', 'Bhattacharya', 'aditi.bhattacharya@example.com', 'yes'),
('E009', 'A052', 'Ahaana', 'Rao', 'ahaana.rao@example.com', 'no'),
('E007', 'A053', 'Anvi', 'Chatterjee', 'anvi.chatterjee@example.com', 'maybe'),
('E007', 'A054', 'Aarav', 'Iyer', 'aarav.iyer@example.com', 'yes'),
('E009', 'A055', 'Advika', 'Menon', 'advika.menon@example.com', 'no'),
('E008', 'A056', 'Anaya', 'Kapoor', 'anaya.kapoor@example.com', 'maybe'),
('E010', 'A057', 'Aarav', 'Reddy', 'aarav.reddy@example.com', 'yes'),
('E010', 'A058', 'Aaradhya', 'Sharma', 'aaradhya.sharma@example.com', 'no'),
('E010', 'A059', 'Aarav', 'Menon', 'aarav.menon@example.com', 'maybe'),
('E002', 'A060', 'Aaradhya', 'Deshpande', 'aaradhya.deshpande@example.com', 'yes'),
('E009', 'A061', 'Aarav', 'Balakrishnan', 'aarav.balakrishnan@example.com', 'no'),
('E009', 'A062', 'Aarav', 'Jain', 'aarav.jain@example.com', 'maybe'),
('E007', 'A063', 'Aadvik', 'Dutta', 'aadvik.dutta@example.com', 'yes'),
('E007', 'A064', 'Aarav', 'Menon', 'aarav.menon@example.com', 'no'),
('E009', 'A065', 'Aarna', 'Sharma', 'aarna.sharma@example.com', 'maybe'),
('E010', 'A066', 'Aarush', 'Sinha', 'aarush.sinha@example.com', 'yes'),
('E010', 'A067', 'Aarna', 'Nair', 'aarna.nair@example.com', 'no'),
('E010', 'A068', 'Aaradhya', 'Pillai', 'aaradhya.pillai@example.com', 'maybe'),
('E010', 'A069', 'Aarav', 'Krishnan', 'aarav.krishnan@example.com', 'yes'),
('E010', 'A070', 'Aarna', 'Menon', 'aarna.menon@example.com', 'no'),
('E002', 'A071', 'Aarya', 'Menon', 'aarya.menon@example.com', 'maybe'),
('E009', 'A072', 'Aarush', 'Shah', 'aarush.shah@example.com', 'yes'),
('E009', 'A073', 'Aarav', 'Kapoor', 'aarav.kapoor@example.com', 'no'),
('E007', 'A074', 'Aarav', 'Sinha', 'aarav.sinha@example.com', 'maybe'),
('E007', 'A075', 'Aaradhya', 'Krishnan', 'aaradhya.krishnan@example.com', 'yes'),
('E009', 'A076', 'Aaradhya', 'Rao', 'aaradhya.rao@example.com', 'no'),
('E010', 'A077', 'Aarav', 'Chakraborty', 'aarav.chakraborty@example.com', 'maybe'),
('E002', 'A078', 'Aadvik', 'Rao', 'aadvik.rao@example.com', 'yes'),
('E008', 'A079', 'Aarav', 'Menon', 'aarav.menon@example.com', 'no'),
('E006', 'A080', 'Aaradhya', 'Kumar', 'aaradhya.kumar@example.com', 'maybe'),
('E007', 'A081', 'Aarav', 'Chopra', 'aarav.chopra@example.com', 'yes'),
('E008', 'A082', 'Aaradhya', 'Krishna', 'aaradhya.krishna@example.com', 'no'),
('E010', 'A083', 'Aarav', 'Biswas', 'aarav.biswas@example.com', 'maybe'),
('E002', 'A084', 'Aarav', 'Bhattacharya', 'aarav.bhattacharya@example.com', 'yes'),
('E008', 'A085', 'Aarav', 'Rao', 'aarav.rao@example.com', 'no'),
('E006', 'A086', 'Aadvik', 'Gupta', 'aadvik.gupta@example.com', 'maybe'),
('E010', 'A087', 'Aarav', 'Menon', 'aarav.menon@example.com', 'yes'),
('E002', 'A088', 'Aarav', 'Sharma', 'aarav.sharma@example.com', 'no'),
('E008', 'A089', 'Aarav', 'Gupta', 'aarav.gupta@example.com', 'maybe'),
('E006', 'A090', 'Aarav', 'Sinha', 'aarav.sinha@example.com', 'yes'),
('E007', 'A091', 'Aarav', 'Menon', 'aarav.menon@example.com', 'no'),
('E008', 'A092', 'Aarav', 'Bhattacharya', 'aarav.bhattacharya@example.com', 'maybe'),
('E010', 'A093', 'Aarav', 'Rao', 'aarav.rao@example.com', 'yes'),
('E009', 'A094', 'Aadvik', 'Gupta', 'aadvik.gupta@example.com', 'no'),
('E008', 'A095', 'Aarav', 'Menon', 'aarav.menon@example.com', 'maybe'),
('E004', 'A096', 'Aarav', 'Sharma', 'aarav.sharma@example.com', 'yes'),
('E005', 'A097', 'Aarav', 'Menon', 'aarav.menon@example.com', 'no'),
('E009', 'A098', 'Aarav', 'Jain', 'aarav.jain@example.com', 'maybe'),
('E010', 'A099', 'Aarav', 'Menon', 'aarav.menon@example.com', 'yes'),
('E002', 'A100', 'Aarav', 'Balakrishnan', 'aarav.balakrishnan@example.com', 'no');
-- 12. Insert data into Tracks table (if needed)
INSERT INTO Tracks (TrackID, EventID, TrackName, TrackDescription)
VALUES 
    ('TR001', 'E001', 'Emerging Technologies', 'This track focuses on exploring emerging technologies and their impact on various industries.'),
    ('TR002', 'E001', 'Artificial Intelligence and Machine Learning', 'This track delves into the world of artificial intelligence and machine learning, discussing applications and advancements.'),
    ('TR003', 'E001', 'Cybersecurity', 'This track is dedicated to cybersecurity, covering topics such as threat detection, data protection, and risk management.'),
    ('TR004', 'E001', 'Software Development Methodologies', 'This track focuses on software development methodologies, tools, and best practices.'),
    ('TR005', 'E001', 'Digital Marketing Strategies', 'This track explores the latest trends and innovations in digital marketing strategies and techniques.'),
    ('TR006', 'E001', 'Future of E-commerce', 'This track examines the future of e-commerce, including trends, challenges, and opportunities in online retail.'),
    ('TR007', 'E001', 'Sustainable Business Practices', 'This track discusses sustainable business practices and environmental responsibility in corporate settings.'),
    ('TR008', 'E001', 'Technology in Healthcare', 'This track explores the intersection of technology and healthcare, including telemedicine, digital health records, and medical innovations.'),
    ('TR009', 'E001', 'Entrepreneurship', 'This track focuses on entrepreneurship, featuring talks and workshops on startup strategies, funding, and growth hacking.'),
    ('TR010', 'E001', 'Future of Work', 'This track explores the future of work, including remote collaboration tools, flexible work arrangements, and workforce trends.'),
    ('TR011', 'E001', 'Nostalgia and Reflections', 'This track reflects on nostalgic memories and bittersweet experiences.'),
    ('TR012', 'E001', 'Themes of Mortality and Love', 'This track delves into themes of mortality, love, and existentialism.'),
    ('TR013', 'E001', 'Complexities of Relationships', 'This track explores the complexities of romantic relationships and emotional vulnerability.'),
    ('TR014', 'E001', 'Youth and Beauty', 'This track reflects on youth, beauty, and the fleeting nature of time.'),
    ('TR015', 'E001', 'Love, Loss, and Longing', 'This track explores themes of love, loss, and longing.'),
    ('TR016', 'E001', 'The Allure of Power and Wealth', 'This track reflects on the allure of power, wealth, and fame in modern society.'),
    ('TR017', 'E001', 'Freedom and Self-Discovery', 'This track explores themes of freedom, adventure, and self-discovery on the open road.'),
    ('TR018', 'E001', 'Laid-back Lifestyle of the West Coast', 'This track captures the laid-back vibes and sun-soaked landscapes of the West Coast lifestyle.'),
    ('TR019', 'E001', 'Celebration of Love', 'This track celebrates the joy and ecstasy of being in love.'),
    ('TR020', 'E001', 'Personal Growth and Finding Peace', 'This track reflects on personal growth, introspection, and finding peace amidst chaos.');

-- 13. Insert data into Sessions table (if needed)
INSERT INTO Sessions (SessionID, TrackID, SessionTitle, SessionDescription, SessionStartTime, SessionEndTime)
VALUES 
    ('SI01', 'TR001', 'Session 1 Title', 'Session 1 Description', '2024-03-13 09:00:00', '2024-03-13 10:00:00'),
    ('SI02', 'TR001', 'Session 2 Title', 'Session 2 Description', '2024-03-13 10:00:00', '2024-03-13 11:00:00'),
    ('SI03', 'TR002', 'Session 3 Title', 'Session 3 Description', '2024-03-13 11:00:00', '2024-03-13 12:00:00'),
    ('SI04', 'TR002', 'Session 4 Title', 'Session 4 Description', '2024-03-13 13:00:00', '2024-03-13 14:00:00'),
    ('SI05', 'TR003', 'Session 5 Title', 'Session 5 Description', '2024-03-13 14:00:00', '2024-03-13 15:00:00'),
    ('SI06', 'TR003', 'Session 6 Title', 'Session 6 Description', '2024-03-13 15:00:00', '2024-03-13 16:00:00'),
    ('SI07', 'TR004', 'Session 7 Title', 'Session 7 Description', '2024-03-13 16:00:00', '2024-03-13 17:00:00'),
    ('SI08', 'TR004', 'Session 8 Title', 'Session 8 Description', '2024-03-14 09:00:00', '2024-03-14 10:00:00'),
    ('SI09', 'TR005', 'Session 9 Title', 'Session 9 Description', '2024-03-14 10:00:00', '2024-03-14 11:00:00'),
    ('SI10', 'TR005', 'Session 10 Title', 'Session 10 Description', '2024-03-14 11:00:00', '2024-03-14 12:00:00'),
    ('SI11', 'TR006', 'Session 11 Title', 'Session 11 Description', '2024-03-14 13:00:00', '2024-03-14 14:00:00'),
    ('SI12', 'TR006', 'Session 12 Title', 'Session 12 Description', '2024-03-14 14:00:00', '2024-03-14 15:00:00'),
    ('SI13', 'TR007', 'Session 13 Title', 'Session 13 Description', '2024-03-14 15:00:00', '2024-03-14 16:00:00'),
    ('SI14', 'TR007', 'Session 14 Title', 'Session 14 Description', '2024-03-14 16:00:00', '2024-03-14 17:00:00'),
    ('SI15', 'TR008', 'Session 15 Title', 'Session 15 Description', '2024-03-14 17:00:00', '2024-03-14 18:00:00'),
    ('SI16', 'TR008', 'Session 16 Title', 'Session 16 Description', '2024-03-15 09:00:00', '2024-03-15 10:00:00'),
    ('SI17', 'TR009', 'Session 17 Title', 'Session 17 Description', '2024-03-15 10:00:00', '2024-03-15 11:00:00'),
    ('SI18', 'TR009', 'Session 18 Title', 'Session 18 Description', '2024-03-15 11:00:00', '2024-03-15 12:00:00'),
    ('SI19', 'TR010', 'Session 19 Title', 'Session 19 Description', '2024-03-15 13:00:00', '2024-03-15 14:00:00'),
    ('SI20', 'TR010', 'Session 20 Title', 'Session 20 Description', '2024-03-15 14:00:00', '2024-03-15 15:00:00'),
    ('SI21', 'TR001', 'Session 21 Title', 'Session 21 Description', '2024-03-15 15:00:00', '2024-03-15 16:00:00'),
    ('SI22', 'TR001', 'Session 22 Title', 'Session 22 Description', '2024-03-15 16:00:00', '2024-03-15 17:00:00'),
    ('SI23', 'TR002', 'Session 23 Title', 'Session 23 Description', '2024-03-16 09:00:00', '2024-03-16 10:00:00'),
    ('SI24', 'TR002', 'Session 24 Title', 'Session 24 Description', '2024-03-16 10:00:00', '2024-03-16 11:00:00'),
    ('SI25', 'TR003', 'Session 25 Title', 'Session 25 Description', '2024-03-16 11:00:00', '2024-03-16 12:00:00'),
    ('SI26', 'TR003', 'Session 26 Title', 'Session 26 Description', '2024-03-16 13:00:00', '2024-03-16 14:00:00'),
    ('SI27', 'TR004', 'Session 27 Title', 'Session 27 Description', '2024-03-16 14:00:00', '2024-03-16 15:00:00'),
    ('SI28', 'TR004', 'Session 28 Title', 'Session 28 Description', '2024-03-16 15:00:00', '2024-03-16 16:00:00'),
    ('SI29', 'TR005', 'Session 29 Title', 'Session 29 Description', '2024-03-16 16:00:00', '2024-03-16 17:00:00'),
    ('SI30', 'TR005', 'Session 30 Title', 'Session 30 Description', '2024-03-16 17:00:00', '2024-03-16 18:00:00');
-- 14. Insert data into Speakers table (if needed)
INSERT INTO SessionSpeakers (SessionSpeakerID, SessionID, SpeakerID)
VALUES 
    ('SS001', 'SI01', '1'),
    ('SS002', 'SI01', '2'),
    ('SS003', 'SI02', '3'),
    ('SS004', 'SI02', '4'),
    ('SS005', 'SI03', '5'),
    ('SS006', 'SI03', '1'),
    ('SS007', 'SI04', '1'),
    ('SS008', 'SI04', '2'),
    ('SS009', 'SI05', '3'),
    ('SS010', 'SI05', '4'),
    ('SS011', 'SI06', '5'),
    ('SS012', 'SI06', '1'),
    ('SS013', 'SI07', '2'),
    ('SS014', 'SI07', '3'),
    ('SS015', 'SI08', '4'),
    ('SS016', 'SI08', '5'),
    ('SS017', 'SI09', '1'),
    ('SS018', 'SI09', '2'),
    ('SS019', 'SI10', '3'),
    ('SS020', 'SI10', '4'),
    ('SS021', 'SI11', '5'),
    ('SS022', 'SI11', '1'),
    ('SS023', 'SI12', '2'),
    ('SS024', 'SI12', '3'),
    ('SS025', 'SI13', '4'),
    ('SS026', 'SI13', '5'),
    ('SS027', 'SI14', '1'),
    ('SS028', 'SI14', '2'),
    ('SS029', 'SI15', '3'),
    ('SS030', 'SI15', '4');

    
INSERT INTO Speakers (SpeakerID, EventID, SpeakerName, SpeakerBio) 
VALUES 
    ('SP001', 'E001', 'John Doe', 'John Doe is an experienced speaker in the field of technology.'),
    ('SP002', 'E002', 'Jane Smith', 'Jane Smith has expertise in marketing and branding.'),
    ('SP003', 'E003', 'Michael Johnson', 'Michael Johnson is a renowned expert in finance and investments.'),
    ('SP004', 'E001', 'Emily Davis', 'Emily Davis specializes in project management and leadership.'),
    ('SP005', 'E002', 'David Brown', 'David Brown is an accomplished entrepreneur and business consultant.');

-- 15. Insert data into SessionAttendees table (if needed)
INSERT INTO SessionAttendees(SessionAttendeeID, SessionID, AttendeeID) 
VALUES
( 'SAI01', 'SI01', 'A001' ),
( 'SAI02', 'SI02', 'A002' ),
( 'SAI03', 'SI03', 'A003' ),
( 'SAI04', 'SI04', 'A004' ),
( 'SAI05', 'SI05', 'A005' ),
( 'SAI06', 'SI06', 'A006' ),
( 'SAI07', 'SI07', 'A007' ),
( 'SAI08', 'SI08', 'A008' ),
( 'SAI09', 'SI09', 'A009' ),
( 'SAI10', 'SI10', 'A010' ),
( 'SAI11', 'SI11', 'A011' ),
( 'SAI12', 'SI12', 'A012' ),
( 'SAI13', 'SI13', 'A013' ),
( 'SAI14', 'SI14', 'A014' ),
( 'SAI15', 'SI15', 'A015' ),
( 'SAI16', 'SI01', 'A016' ),
( 'SAI17', 'SI02', 'A017' ),
( 'SAI18', 'SI03', 'A018' ),
( 'SAI19', 'SI04', 'A019' ),
( 'SAI20', 'SI05', 'A020' ),
( 'SAI21', 'SI06', 'A021' ),
( 'SAI22', 'SI07', 'A022' ),
( 'SAI23', 'SI08', 'A023' ),
( 'SAI24', 'SI09', 'A024' ),
( 'SAI25', 'SI10', 'A025' ),
( 'SAI26', 'SI11', 'A026' ),
( 'SAI27', 'SI12', 'A027' ),
( 'SAI28', 'SI13', 'A028' ),
( 'SAI29', 'SI14', 'A029' ),
( 'SAI30', 'SI15', 'A030' ),
( 'SAI31', 'SI01', 'A031' ),
( 'SAI32', 'SI02', 'A032' ),
( 'SAI33', 'SI03', 'A033' ),
( 'SAI34', 'SI04', 'A034' ),
( 'SAI35', 'SI05', 'A035' ),
( 'SAI36', 'SI06', 'A036' ),
( 'SAI37', 'SI07', 'A037' ),
( 'SAI38', 'SI08', 'A038' ),
( 'SAI39', 'SI09', 'A039' ),
( 'SAI40', 'SI10', 'A040' ),
( 'SAI41', 'SI11', 'A041' ),
( 'SAI42', 'SI12', 'A042' ),
( 'SAI43', 'SI13', 'A043' ),
( 'SAI44', 'SI14', 'A044' ),
( 'SAI45', 'SI15', 'A045' ),
( 'SAI46', 'SI01', 'A046' ),
( 'SAI47', 'SI02', 'A047' ),
( 'SAI48', 'SI03', 'A048' ),
( 'SAI49', 'SI04', 'A049' ),
( 'SAI50', 'SI05', 'A050' );

-- 16. Insert data into the remaining tables (if needed)
INSERT INTO Schedules (ScheduleID, EventID, StartTime, EndTime) VALUES
('SCH001', 'E001', '2024-04-15 09:00:00', '2024-04-15 17:00:00'),
('SCH002', 'E002', '2024-05-20 10:00:00', '2024-05-20 15:00:00'),
('SCH003', 'E003', '2024-06-10 13:00:00', '2024-06-10 16:00:00'),
('SCH004', 'E004', '2024-06-11 09:00:00', '2024-06-11 17:00:00'),
('SCH005', 'E005', '2024-06-18 09:00:00', '2024-06-18 17:00:00'),
('SCH006', 'E006', '2024-06-25 09:00:00', '2024-06-25 17:00:00'),
('SCH007', 'E007', '2024-07-02 09:00:00', '2024-07-02 17:00:00'),
('SCH008', 'E008', '2024-07-09 09:00:00', '2024-07-09 17:00:00'),
('SCH009', 'E009', '2024-07-16 09:00:00', '2024-07-16 17:00:00'),
('SCH010', 'E010', '2024-07-23 09:00:00', '2024-07-23 17:00:00'),
('SCH011', 'E001', '2024-07-30 09:00:00', '2024-07-30 17:00:00'),
('SCH012', 'E002', '2024-08-06 09:00:00', '2024-08-06 17:00:00'),
('SCH013', 'E003', '2024-08-13 09:00:00', '2024-08-13 17:00:00'),
('SCH014', 'E004', '2024-08-20 09:00:00', '2024-08-20 17:00:00'),
('SCH015', 'E005', '2024-08-27 09:00:00', '2024-08-27 17:00:00'),
('SCH016', 'E006', '2024-09-03 09:00:00', '2024-09-03 17:00:00'),
('SCH017', 'E007', '2024-09-10 09:00:00', '2024-09-10 17:00:00'),
('SCH018', 'E008', '2024-09-17 09:00:00', '2024-09-17 17:00:00'),
('SCH019', 'E009', '2024-09-24 09:00:00', '2024-09-24 17:00:00'),
('SCH020', 'E010', '2024-10-01 09:00:00', '2024-10-01 17:00:00'),
('SCH021', 'E001', '2024-10-08 09:00:00', '2024-10-08 17:00:00'),
('SCH022', 'E002', '2024-10-15 09:00:00', '2024-10-15 17:00:00'),
('SCH023', 'E003', '2024-10-22 09:00:00', '2024-10-22 17:00:00');

INSERT INTO Organizers (OrganizerID, EventID, OrganizerName, OrganizerEmail) VALUES
('ORG001', 'E001', 'Arun Kumar', 'arun@gmail.com'),
('ORG002', 'E002', 'Ananya Gupta', 'ananya@jonty.com'),
('ORG003', 'E003', 'Chandan Mishra', 'chandan@ponty.com'),
('ORG004', 'E004', 'Shreya Sharma', 'shreya@tonty.com'),
('ORG005', 'E005', 'Manish Patel', 'manish@romty.com'),
('ORG006', 'E006', 'Neha Singh', 'neha@nonty.com'),
('ORG007', 'E007', 'Divya Shah', 'divya@monty.com'),
('ORG008', 'E008', 'Rahul Verma', 'rahul@donty.com'),
('ORG009', 'E009', 'Pooja Reddy', 'pooja@wonty.com'),
('ORG010', 'E010', 'Rajesh Kumar', 'rajesh@lonty.com');

INSERT INTO Sponsors (SponsorID, EventID, SponsorName, SponsorType, SponsorLevel) VALUES
('SPN001', 'E001', 'ABC Corporation', 'Gold', 1),
('SPN002', 'E002', 'XYZ Inc.', 'Silver', 2),
('SPN003', 'E003', '123 Enterprises', 'Bronze', 3),
('SPN004', 'E004', 'LMN Ltd.', 'Gold', 1),
('SPN005', 'E005', 'PQR Company', 'Silver', 2),
('SPN006', 'E006', 'STU Enterprises', 'Bronze', 3),
('SPN007', 'E007', 'MNO Corporation', 'Gold', 1),
('SPN008', 'E008', 'QRS Inc.', 'Silver', 2),
('SPN009', 'E009', 'VWX Enterprises', 'Bronze', 3),
('SPN010', 'E010', 'EFG Corporation', 'Gold', 1),
('SPN011', 'E001', 'HIJ Inc.', 'Silver', 2),
('SPN012', 'E002', 'KLM Enterprises', 'Bronze', 3),
('SPN013', 'E003', 'NOP Corporation', 'Gold', 1),
('SPN014', 'E004', 'TUV Inc.', 'Silver', 2),
('SPN015', 'E005', 'WXY Enterprises', 'Bronze', 3),
('SPN016', 'E006', 'GHI Corporation', 'Gold', 1),
('SPN017', 'E007', 'JKL Inc.', 'Silver', 2),
('SPN018', 'E008', 'OPQ Enterprises', 'Bronze', 3),
('SPN019', 'E009', 'UVW Corporation', 'Gold', 1),
('SPN020', 'E010', 'XYZ Inc.', 'Silver', 2),
('SPN021', 'E001', 'RST Enterprises', 'Bronze', 3),
('SPN022', 'E002', 'BCD Corporation', 'Gold', 1),
('SPN023', 'E003', 'EFG Inc.', 'Silver', 2),
('SPN024', 'E004', 'HIJ Enterprises', 'Bronze', 3),
('SPN025', 'E005', 'KLM Corporation', 'Gold', 1),
('SPN026', 'E006', 'NOP Inc.', 'Silver', 2),
('SPN027', 'E007', 'PQR Enterprises', 'Bronze', 3),
('SPN028', 'E008', 'STU Corporation', 'Gold', 1),
('SPN029', 'E009', 'UVW Inc.', 'Silver', 2),
('SPN030', 'E010', 'XYZ Enterprises', 'Bronze', 3);

INSERT INTO EventFeedback (FeedbackID, EventID, AttendeeID, FeedbackText, Rating)
VALUES 
    ('FI01', 'E001', 'A001', 'GOOD', '08'),
    ('FI02', 'E002', 'A002', 'GOOD', '07'),
    ('FI03', 'E003', 'A003', 'BAD', '03'),
    ('FI04', 'E004', 'A004', 'BAD', '04'),
    ('FI05', 'E005', 'A005', 'GOOD', '05'),
    ('FI06', 'E006', 'A006', 'BAD', '04'),
    ('FI07', 'E007', 'A007', 'AVERAGE', '06'),
    ('FI08', 'E008', 'A008', 'GOOD', '08'),
    ('FI09', 'E009', 'A009', 'AVERAGE', '05'),
    ('FI10', 'E010', 'A010', 'AVERAGE', '05'),
    ('FI11', 'E001', 'A001', 'GOOD', '09'),
    ('FI12', 'E002', 'A009', 'GOOD', '10'),
    ('FI13', 'E003', 'A005', 'BAD', '04'),
    ('FI14', 'E004', 'A004', 'GOOD', '08'),
    ('FI15', 'E005', 'A005', 'BAD', '02'),
    ('FI16', 'E006', 'A008', 'GOOD', '08'),
    ('FI17', 'E007', 'A007', 'AVERAGE', '06'),
    ('FI18', 'E008', 'A009', 'GOOD', '09'),
    ('FI19', 'E009', 'A010', 'GOOD', '07'),
    ('FI20', 'E010', 'A001', 'BAD', '01'),
    ('FI21', 'E001', 'A005', 'BAD', '03'),
    ('FI22', 'E002', 'A007', 'GOOD', '08'),
    ('FI23', 'E003', 'A009', 'GOOD', '09'),
    ('FI24', 'E004', 'A005', 'GOOD', '10'),
    ('FI25', 'E005', 'A004', 'GOOD', '07'),
    ('FI26', 'E006', 'A006', 'AVERAGE', '05'),
    ('FI27', 'E007', 'A003', 'AVERAGE', '06'),
    ('FI28', 'E008', 'A001', 'GOOD', '07'),
    ('FI29', 'E009', 'A002', 'GOOD', '08'),
    ('FI30', 'E010', 'A005', 'AVERAGE', '06'),
    ('FI31', 'E001', 'A007', 'GOOD', '08'),
    ('FI32', 'E002', 'A008', 'GOOD', '07'),
    ('FI33', 'E003', 'A009', 'BAD', '04'),
    ('FI34', 'E004', 'A007', 'GOOD', '08'),
    ('FI35', 'E005', 'A004', 'GOOD', '09'),
    ('FI36', 'E006', 'A006', 'BAD', '05'),
    ('FI37', 'E007', 'A007', 'GOOD', '07'),
    ('FI38', 'E008', 'A008', 'GOOD', '09'),
    ('FI39', 'E009', 'A009', 'BAD', '02'),
    ('FI40', 'E010', 'A010', 'AVERAGE', '05');


INSERT INTO EventPhotos ( PhotoID, EventID, PhotoURL, PhotoDescription)
VALUES 
    ( 'IMG_01', 'E001', 'http://www.sample.org/head', 'A serene sunset over the ocean'),
    ( 'IMG_02', 'E002', 'http://sample.edu/', 'Vibrant autumn leaves in the forest'),
    ( 'IMG_03', 'E003', 'http://sample.org/', 'A bustling cityscape at night'),
    ( 'IMG_04', 'E004', 'http://sample.info/?insect=fireman&porter=attraction#cave', 'Majestic mountains capped with snow'),
    ( 'IMG_05', 'E005', 'http://sample.org/#yak', 'A cozy fireplace on a winters night'),
    ( 'IMG_06', 'E006', 'https://sample.edu/railway', 'Colorful hot air balloons against a blue sky'),
    ( 'IMG_07', 'E007', 'https://sample.edu/day', 'Delicate cherry blossoms in bloom'),
    ( 'IMG_08', 'E008', 'https://sample.info/#corn', 'A peaceful countryside landscape'),
    ( 'IMG_09', 'E009', 'https://sample.org/cover', 'Sparkling city lights reflected on water'),
    ( 'IMG_10', 'E010', 'https://sample.net/#hose', 'Playful puppies frolicking in a field'),
    ( 'IMG_11', 'E001', 'http://www.example.com/', 'Ancient ruins surrounded by lush greenery'),
    ( 'IMG_12', 'E002', 'https://example.org/birthday.php', 'A solitary tree in a vast desert landscape'),
    ( 'IMG_13', 'E003', 'https://www.example.net/balance', 'Towering skyscrapers reaching for the sky'),
    ( 'IMG_14', 'E004', 'http://www.example.com/?birds=attack', 'Crystal-clear waterfalls cascading down rocks'),
    ( 'IMG_15', 'E005', 'https://example.com/gcp-web-development-cdn/X', 'A quaint village nestled in the hills'),
    ( 'IMG_16', 'E006', 'https://example.com/landing-page-css-wordpress/L', 'Elegant architecture against a clear blue sky'),
    ( 'IMG_17', 'E007', 'https://example.com/flask-django-php/u', 'Dramatic lightning striking across the sky'),
    ( 'IMG_18', 'E008', 'https://example.com/express-docker-symfony/j', 'A serene lake surrounded by towering trees'),
    ( 'IMG_19', 'E009', 'https://example.com/call-to-action-heroku-vue/y', 'Vibrant street art in a bustling alleyway'),
    ( 'IMG_20', 'E010', 'https://example.com/server-flask-flask/6', 'A tranquil garden with blooming flowers'),
    ( 'IMG_21', 'E001', 'https://example.com/web-development-html-a11y/Q', 'A mesmerizing starry night sky'),
    ( 'IMG_22', 'E002', 'https://example.com/rails-joomla-call-to-action/Q', 'A colorful market bustling with activity'),
    ( 'IMG_23', 'E003', 'https://example.com/ab-testing-css-css/M', 'Majestic elephants roaming the savannah'),
    ( 'IMG_24', 'E004', 'https://example.com/css-design-wordpress/c', 'A picturesque lighthouse overlooking the sea'),
    ( 'IMG_25', 'E005', 'https://example.com/ux-mysql-mercurial/m', 'A serene pond with lily pads and frogs'),
    ( 'IMG_26', 'E006', 'https://example.com/conversion-rate-wordpress-kanban/p', 'A peaceful cabin nestled in the woods'),
    ( 'IMG_27', 'E007', 'https://example.com/link-building-cache-server/p', 'Golden fields of wheat swaying in the breeze'),
    ( 'IMG_28', 'E008', 'https://example.com/server-sql-accessibility/r', 'A breathtaking rainbow after a storm'),
    ( 'IMG_29', 'E009', 'https://example.com/css-sitemap-affiliate-marketing/J', 'A playful cat chasing butterflies in a meadow'),
    ( 'IMG_30', 'E010', 'https://example.com/travis-travis-sitemap/R', 'A stunning aurora dancing across the night sky');


-- table 14
INSERT INTO EventDocuments (DocumentID, EventID, DocumentURL, DocumentTitle)
VALUES 
('DOC01', 'E001', 'https://DocumentID/flask-heroku-mvc/m', 'The Art of Leadership: Strategies for Success'),
('DOC02', 'E002', 'https://DocumentID/vue-vue-react/y', 'Unlocking Creativity: A Guide for Innovators'),
('DOC03', 'E003', 'https://DocumentID/flask-azure-circleci/7', 'The Power of Positive Thinking: Transform Your Life'),
('DOC04', 'E004', 'https://DocumentID/framework-vercel-rails/k', 'Mastering Time Management: Productivity Secrets'),
('DOC05', 'E005', 'https://DocumentID/mvc-sitemap-sitemap/N', 'The Science of Happiness: Keys to Fulfillment'),
('DOC06', 'E006', 'https://DocumentID/flask-nosql-node/f', 'Effective Communication: Building Stronger Connections'),
('DOC07', 'E007', 'https://DocumentID/keyword-bounce-rate-mvc/F', 'Financial Freedom: Strategies for Wealth Accumulation'),
('DOC08', 'E008', 'https://DocumentID/content-marketing-angular-netlify/6', 'The Art of Negotiation: Winning Deals with Confidence'),
('DOC09', 'E009', 'https://DocumentID/mercurial-email-marketing-framework/w', 'Healthy Living: Wellness Tips for a Balanced Life'),
('DOC10', 'E010', 'https://DocumentID/azure-web-development-aws/O', 'Unlock Your Potential: Personal Development Guide'),
('DOC11', 'E001', 'https://DocumentID/redis-node-netlify/f', 'The Entrepreneurs Handbook: From Idea to Success'),
('DOC12', 'E002', 'https://DocumentID/node-postgresql-kanban/9', 'Mindfulness Meditation: Finding Peace in a Busy World'),
('DOC13', 'E003', 'https://DocumentID/mercurial-flask-social-media/x', 'Strategic Planning: Roadmap to Business Success'),
('DOC14', 'E004', 'https://DocumentID/api-ui-circleci/Z', 'The Power of Resilience: Overcoming Lifes Challenges'),
('DOC15', 'E005', 'https://DocumentID/bounce-rate-django-javascript/E', 'Effective Parenting: Nurturing Tomorrows Leaders'),
('DOC16', 'E006', 'https://DocumentID/angular-seo-git/M', 'The Ultimate Guide to Self-Care: Prioritize Your Wellbeing'),
('DOC17', 'E007', 'https://DocumentID/python-wordpress-react/u', 'Leadership in a Digital Age: Navigating Change'),
('DOC18', 'E008', 'https://DocumentID/netlify-information-architecture-laravel/w', 'Discover Your Passion: Pursuing Your Dreams'),
('DOC19', 'E009', 'https://DocumentID/angular-postgresql-circleci/6', 'Investing 101: Building Wealth for the Future'),
('DOC20', 'E010', 'https://DocumentID/link-building-travis-email-marketing/i', 'The Art of Decision Making: From Analysis to Action'),
('DOC21', 'E001', 'https://DocumentID/python-affiliate-marketing-drupal/U', 'Emotional Intelligence: Mastering Your Emotions'),
('DOC22', 'E002', 'https://DocumentID/web-development-oracle-ui/w', 'The Art of Persuasion: Influence and Impact'),
('DOC23', 'E003', 'https://DocumentID/ppc-devops-heroku/I', 'Achieving Work-Life Balance: Strategies for Success'),
('DOC24', 'E004', 'https://DocumentID/svn-web-development-kubernetes/F', 'The Power of Mindset: Shaping Your Reality'),
('DOC25', 'E005', 'https://DocumentID/redis-kanban-optimization/V', 'The Leaders Toolkit: Essential Skills for Success'),
('DOC26', 'E006', 'https://DocumentID/mercurial-responsive-aspnet/K', 'The Science of Motivation: Igniting Your Drive'),
('DOC27', 'E007', 'https://DocumentID/link-building-ab-testing-jenkins/N', 'The Art of Networking: Building Meaningful Connections'),
('DOC28', 'E008', 'https://DocumentID/responsive-optimization-mvc/9', 'Financial Planning for Beginners: Secure Your Future'),
('DOC29', 'E009', 'https://DocumentID/sitemap-ppc-express/i', 'Effective Conflict Resolution: Navigating Difficult Conversations'),
('DOC30', 'E010', 'https://DocumentID/affiliate-marketing-heroku-firebase/Z', 'The Mindful Leader: Cultivating Presence and Purpose'),
('DOC31', 'E001', 'https://DocumentID/jenkins-aws-landing-page/6', 'Discover Your Strengths: Unleash Your Potential'),
('DOC32', 'E002', 'https://DocumentID/java-kanban-bitbucket/u', 'The Power of Gratitude: Transforming Your Life'),
('DOC33', 'E003', 'https://DocumentID/frontend-python-kanban/P', 'Digital Marketing Essentials: Strategies for Success'),
('DOC34', 'E004', 'https://DocumentID/golang-cdn-joomla/0', 'The Art of Delegation: Empowering Your Team'),
('DOC35', 'E005', 'https://DocumentID/library-social-media-optimization/j', 'Effective Problem Solving: Strategies for Innovation'),
('DOC36', 'E006', 'https://DocumentID/content-strategy-mobile-first-content-strategy/U', 'The Joy of Learning: Lifelong Growth and Development'),
('DOC37', 'E007', 'https://DocumentID/a11y-oracle-optimization/2', 'Leadership in Crisis: Navigating Uncertain Times'),
('DOC38', 'E008', 'https://DocumentID/link-building-python-flask/5', 'The Art of Feedback: Building Stronger Teams'),
('DOC39', 'E009', 'https://DocumentID/laravel-mvc-oracle/U', 'Strategic Thinking: Planning for Long-Term Success'),
('DOC40', 'E010', 'https://DocumentID/email-marketing-digitalocean-seo/g', 'The Happiness Project: A Journey to Joy');


-- table 15

insert into EventPolls values ('P001', 'E001', 'What is the capital of Japan?', 'Beijing', 'Tokyo'),
							  ('P002', 'E002', 'What is the largest planet in our solar system?', 'Earth', 'Jupiter'),
                              ('P003', 'E003', 'Which continent is home to the Amazon Rainforest?', 'South America', 'Africa'),
                              ('P004', 'E004', 'What is the chemical symbol for gold?', 'Ag', 'Au'),
                              ('P005', 'E005', 'What is the tallest mountain in the world?', 'Mount Kilimanjaro', 'Mount Everest'),
                              ('P006', 'E006', 'Who wrote "Romeo and Juliet"?', 'William Shakespeare', 'J.K. Rowling'),
                              ('P007', 'E007', 'Which animal is known as the "King of the Jungle"?', 'Tiger', 'Lion'),
                              ('P008', 'E008', 'What is the chemical formula for table salt?', 'NaCl', 'H2O'),
                              ('P009', 'E009', 'What is the largest ocean on Earth?', 'Atlantic Ocean', 'Pacific Ocean'),
                              ('P010', 'E010', 'What is the capital of Australia?', 'Sydney', 'Canberra'),
                              ('P011', 'E001', 'Which planet is known as the "Red Planet"?', 'Venus', 'Mars'),
                              ('P012', 'E005', 'Who painted the Mona Lisa?', 'Vincent van Gogh', 'Leonardo da Vinci'),
                              ('P013', 'E004', 'Which bird is often associated with wisdom in Western culture?', 'Eagle', 'Owl'),
                              ('P014', 'E009', 'Which famous scientist developed the theory of relativity?', 'Isaac Newton', 'Albert Einstein'),
                              ('P015', 'E003', 'Which continent is Antarctica located on?', 'Europe', 'Antarctica'),
                              ('P016', 'E008', 'What is the largest desert in the world?', 'Sahara Desert', 'Gobi Desert'),
                              ('P017', 'E001', 'Who is credited with inventing the telephone?', 'Thomas Edison', 'Alexander Graham Bell'),
                              ('P018', 'E002', 'What is the capital of Brazil?', 'Rio de Janeiro', 'Brasilia'),
                              ('P019', 'E007', 'What is the chemical symbol for carbon dioxide?', 'CO2', 'O2'),
                              ('P020', 'E010', 'Who wrote The Secret History', 'Donna Tart', 'Ava Reid');
                              
-- table 16

insert into EventPollResponses values ('R001', 'P001', 'A001', 'Beijing'),
							          ('R002', 'P002', 'A002', 'Jupiter'),
                                      ('R003', 'P003', 'A003','Africa'),
                                      ('R004', 'P004', 'A004', 'Au'),
                                      ('R005', 'P005', 'A005', 'Mount Everest'),
                                      ('R006', 'P006', 'A006', 'J.K. Rowling'),
                                      ('R007', 'P007', 'A007', 'Lion'),
									  ('R008', 'P008', 'A008', 'H2O'),
                                      ('R009', 'P009', 'A009', 'Pacific Ocean'),
                                      ('R010', 'P010', 'A010', 'Canberra'),
                                      ('R011', 'P011', 'A012', 'Mars'),
									  ('R012', 'P012', 'A005', 'Leonardo da Vinci'),
                                      ('R013', 'P013', 'A014', 'Owl'),
                                      ('R014', 'P014', 'A009', 'Isaac Newton'),
                                      ('R015', 'P015', 'A003', 'Antarctica'),
                                      ('R016', 'P016', 'A082', 'Gobi Desert'),
                                      ('R017', 'P017', 'A061', 'Alexander Graham Bell'),
                                      ('R018', 'P018', 'A092', 'Brasilia'),
                                      ('R019', 'P019', 'A037', 'CO2'),
									  ('R020', 'P020', 'A010', 'Donna Tart');

-- table 17

insert into PaymentTransactions(TransactionID, AttendeeID, Amount,PaymentStatus,PaymentDate) values
('TR101','A001',15000,'Pending','07-02-2024'),
('TR102','A002',20000,'Sent','07-03-2024'),
('TR103','A003',45000,'Failed','07-02-2024'),
('TR104','A004',25000,'Completed','05-02-2024'),
('TR105','A005',65000,'Sent','07-05-2024'),
('TR106','A006',30000,'Sent','04-03-2024'),
('TR107','A007',20000,'Completed','03-02-2024'),
('TR108','A008',40000,'Completed','07-02-2024'),
('TR109','A009',25000,'Pending','07-03-2024'),
('TR110','A010',35000,'Sent','06-03-2024'),
('TR111','A011',45000,'Sent','05-03-2024'),
('TR112','A012',65000,'Pending','08-03-2024'),
('TR113','A013',55000,'Completed','09-02-2024'),
('TR114','A014',55000,'Sent','02-02-2024'),
('TR115','A015',45000,'Completed','07-02-2024'),
('TR116','A016',35000,'Sent','05-02-2024'),
('TR117','A017',35000,'Completed','06-03-2024'),
('TR118','A018',25000,'Pending','07-02-2024'),
('TR119','A019',15000,'Sent','05-02-2024'),
('TR120','A020',35000,'Pending','06-02-2024'),
('TR121','A021',45000,'Sent','03-04-2024'),
('TR122','A022',35000,'Completed','08-02-2024'),
('TR123','A023',40000,'Failed','07-03-2024'),
('TR124','A024',25000,'Sent','09-02-2024'),
('TR125','A025',30000,'Failed','10-02-2024'),
('TR126','A026',20000,'Pending','11-02-2024'),
('TR127','A027',35000,'Sent','07-03-2024'),
('TR128','A028',40000,'Completed','08-02-2024'),
('TR129','A029',30000,'Sent','09-02-2024'),
('TR130','A030',40000,'Sent','08-02-2024');

-- table 18

INSERT INTO EventDiscounts(DiscountID ,EventID ,DiscountCode ,DiscountPercentage ,ValidityPeriod )
values
('ED101','E001','SAVE20',20, 2),
('ED102','E002','TRY30',15,7),
('ED103','E003','MAX50',30,9),
('ED104','E004','REST40',11,6),
('ED105','E005','TREAT80',18,5),
('ED106','E006','HOME55',12,4),
('ED107','E007','ICE18',35,1),
('ED108','E008','FALL20',26,8),
('ED109','E009','SALE16',50,3),
('ED110','E010','FREE22',31,9),
('ED111','E001','ACE14',19,6),
('ED112','E002','RISK56',23,7),
('ED113','E003','FIX18',27,1),
('ED114','E004','MIN35',19,5),
('ED115','E005','CATCH16',36,8),
('ED116','E006','MATCH15',22,4),
('ED117','E007','VOTE13',23,13),
('ED118','E008','MIX11',24,6),
('ED119','E009','WIN99',31,11),
('ED120','E010','TRY30',28,10);

-- table 19
INSERT INTO EventRegistrations (RegistrationID, EventID, AttendeeID, RegistrationDate)
VALUES 
('31', 'E001', 'A001', '2024-03-13'),
('32', 'E002', 'A002', '2024-03-14'),
('33', 'E003', 'A003', '2024-03-15'),
('34', 'E004', 'A004', '2024-03-16'),
('35', 'E005', 'A005', '2024-03-17'),
('36', 'E006', 'A006', '2024-03-18'),
('37', 'E007', 'A007', '2024-03-19'),
('38', 'E008', 'A008', '2024-03-20'),
('39', 'E009', 'A009', '2024-03-21'),
('40', 'E010', 'A010', '2024-03-22'),
('41', 'E001', 'A011', '2024-03-23'),
('42', 'E002', 'A012', '2024-03-24'),
('43', 'E003', 'A013', '2024-03-25'),
('44', 'E004', 'A014', '2024-03-26'),
('45', 'E005', 'A015', '2024-03-27'),
('46', 'E006', 'A016', '2024-03-28'),
('47', 'E007', 'A017', '2024-03-29'),
('48', 'E008', 'A018', '2024-03-30'),
('49', 'E009', 'A019', '2024-03-31'),
('50', 'E010', 'A020', '2024-04-01'),
('51', 'E001', 'A021', '2024-04-02'),
('52', 'E002', 'A022', '2024-04-03'),
('53', 'E003', 'A023', '2024-04-04'),
('54', 'E004', 'A024', '2024-04-05'),
('55', 'E005', 'A025', '2024-04-06'),
('56', 'E006', 'A026', '2024-04-07'),
('57', 'E007', 'A027', '2024-04-08'),
('58', 'E008', 'A028', '2024-04-09'),
('59', 'E009', 'A029', '2024-04-10'),
('60', 'E010', 'A030', '2024-04-11'),
('61', 'E001', 'A031', '2024-04-12'),
('62', 'E002', 'A032', '2024-04-13'),
('63', 'E003', 'A033', '2024-04-14'),
('64', 'E004', 'A034', '2024-04-15'),
('65', 'E005', 'A035', '2024-04-16'),
('66', 'E006', 'A036', '2024-04-17'),
('67', 'E007', 'A037', '2024-04-18'),
('68', 'E008', 'A038', '2024-04-19'),
('69', 'E009', 'A039', '2024-04-20'),
('70', 'E010', 'A040', '2024-04-21'),
('71', 'E001', 'A041', '2024-04-22'),
('72', 'E002', 'A042', '2024-04-23'),
('73', 'E003', 'A043', '2024-04-24'),
('74', 'E004', 'A044', '2024-04-25'),
('75', 'E005', 'A045', '2024-04-26'),
('76', 'E006', 'A046', '2024-04-27'),
('77', 'E007', 'A047', '2024-04-28'),
('78', 'E008', 'A048', '2024-04-29'),
('79', 'E009', 'A049', '2024-04-30'),
('80', 'E010', 'A050', '2024-05-01'),
('81', 'E001', 'A051', '2024-05-02'),
('82', 'E002', 'A052', '2024-05-03'),
('83', 'E003', 'A053', '2024-05-04'),
('84', 'E004', 'A054', '2024-05-05'),
('85', 'E005', 'A055', '2024-05-06'),
('86', 'E006', 'A056', '2024-05-07'),
('87', 'E007', 'A057', '2024-05-08'),
('88', 'E008', 'A058', '2024-05-09'),
('89', 'E009', 'A059', '2024-05-10'),
('90', 'E010', 'A060', '2024-05-11'),
('91', 'E001', 'A061', '2024-05-12'),
('92', 'E002', 'A062', '2024-05-13'),
('93', 'E003', 'A063', '2024-05-14'),
('94', 'E004', 'A064', '2024-05-15'),
('95', 'E005', 'A065', '2024-05-16'),
('96', 'E006', 'A066', '2024-05-17'),
('97', 'E007', 'A067', '2024-05-18'),
('98', 'E008', 'A068', '2024-05-19'),
('99', 'E009', 'A069', '2024-05-20'),
('100', 'E010', 'A070', '2024-05-21');

-- table20


INSERT INTO EventAnalytics (AnalyticsID, EventID, PageViews, ClickThroughRate, AttendeeEngagementMetrics) VALUES
('A1', 'E006', 1500, 0.16, 'High engagement'),
('A2', 'E007', 1800, 0.19, 'Moderate engagement'),
('A3', 'E008', 2000, 0.22, 'Low engagement'),
('A4', 'E009', 2200, 0.25, 'High engagement'),
('A5', 'E010', 2500, 0.28, 'Moderate engagement'),
('A6', 'E001', 2800, 0.31, 'Low engagement'),
('A7', 'E002', 3000, 0.34, 'High engagement'),
('A8', 'E003', 3200, 0.37, 'Moderate engagement'),
('A9', 'E004', 3500, 0.40, 'Low engagement'),
('A10', 'E005', 3800, 0.43, 'High engagement'),
('A11', 'E006', 4000, 0.46, 'Moderate engagement'),
('A12', 'E007', 4200, 0.49, 'Low engagement'),
('A13', 'E008', 4500, 0.52, 'High engagement'),
('A14', 'E009', 4800, 0.55, 'Moderate engagement'),
('A15', 'E010', 5000, 0.58, 'Low engagement'),
('A16', 'E001', 5200, 0.61, 'High engagement'),
('A17', 'E002', 5500, 0.64, 'Moderate engagement'),
('A18', 'E003', 5800, 0.67, 'Low engagement'),
('A19', 'E004', 6000, 0.70, 'High engagement'),
('A20', 'E005', 6200, 0.73, 'Moderate engagement');


# PERFORMING ADDITIONAL QUERIES TO FETCH THE DATA w.r.to SPECIFIC CONDITIONS :
desc attendees;
desc events;
desc organizers;
desc schedules;
desc sessionattendees;
desc speakers;
desc sessions;
desc sponsors;
desc tracks;
desc venues;


# 1. Retrieve all venues:
select * from venues;

# 2. Retrieve all events happening on a specific date:
select EventName 
from events
where EventDate='2023-10-20';

# 3. Retrieve all attendees for a specific event (e.g., EventID = 'E001'):
select FirstName, LastName, Email
from attendees
where EventID='E001';

select * from attendees;

# 4. List all events with their corresponding venue details:
select e.EventName, e.EventDescription, v.VenueName, v.VenueLocation
from events e
join venues v
on e.VenueID=v.VenueID;

# 5. List all attendees with their corresponding event details:
select a.EventID, a.FirstName, a.LastName, e.EventName, e.EventDescription, e.EventDate
from attendees a
join events e
on a.EventID=e.EventID;

create view d as
select a.EventID, a.FirstName, a.LastName, e.EventName, e.EventDescription, e.EventDate
from attendees a
join events e
on a.EventID=e.EventID;

select * from d;

# 6. List all tracks with their corresponding event details:
select e.EventID, e.EventName, e.EventDescription, t.TrackName, t.TrackDescription
from events e
join tracks t
on e.EventID=t.EventID;

# 7.Select events that have more than a certain number of attendees (e.g., more than 2):
select e.EventID, e.EventName
from events e
where (select count(*) from attendees a where a.EventID=e.EventID)>2;

SELECT e.EventID, e.EventName, COUNT(a.AttendeeID) AS AttendeeCount
FROM Events e
JOIN Attendees a ON e.EventID = a.EventID
GROUP BY e.EventID, e.EventName
HAVING COUNT(a.AttendeeID) > 5;

# 8. Select attendees who are attending more than one event:
select a.FirstName, a.LastName, count(a.EventID) as no_of_events
from attendees a
group by AttendeeID
having no_of_events>2;

# 9. Select events that are happening this month:
select * from events where
month(EventDate)=month(current_date()) and year(EventDate)=year(current_date());

# 10. Select attendees who have RSVP'd as "Yes":
select * from attendees;

select FirstName, LastName, RSVPStatus
from attendees
where RSVPStatus='yes';

select count(*) from attendees
where RSVPStatus='no';

SELECT * FROM Attendees WHERE RSVPStatus = 'Yes';

# 11. List all events along with the number of attendees for each event:
select e.EventName, count(a.AttendeeID) as no_of_attendees
from events e
join attendees a
on e.EventID=a.EventID
group by e.EventName;

# 12. Find the total number of events happening at each venue:

select v.VenueID, v.VenueName, count(e.EventName) as Event_Count
from venues v
left join events e
on v.VenueID=e.VenueID
group by v.VenueName, v.VenueID
order by Event_Count desc;

# 14. List the events along with their tracks:
select e.EventID, e.EventName, e.EventDate, t.TrackName
from events e
left join tracks t
on e.EventID=t.EventID
where e.EventName='Holi';

# 15. Retrieve the details of attendees along with the events they are attending, sorted by event date:
select a.EventID, a.FirstName, a.LastName, e.EventName, e.EventDate
from attendees a
join events e
on a.EventID=e.EventID
order by e.EventID;

# 16. Find the average number of attendees per event:

select avg(Count_Of_Attendees) as Avg_Count_Attendees
from(
select e.EventName, count(a.AttendeeID) as Count_Of_Attendees
from events e
join attendees a
on e.EventID=a.EventID
group by e.EventName
)
as Event_Avg;

# 17. List the number of events happening each month:
select month(e.EventDate) as Month, count(e.EventName) as Event_Count
from events e
group by e.EventDate;

select year(e.EventDate) as Year, count(e.EventName) as Event_COunt
from events e
group by e.EventDate;

select quarter(e.EventDate) as Quarter, count(e.EventName) as Event_COunt
from events e
group by e.EventDate;

# 18. Find the most popular event (the one with the most attendees):
select e.EventName, count(a.AttendeeID) as cnt
from events e
join attendees a
on e.EventID=a.EventID
group by e.EventName
order by cnt desc
limit 1;

#19. List all events along with their tracks and venues:
select e.EventName, t.TrackName, v.VenueName
from events e
join tracks t on e.EventID=t.EventID
join venues v on v.VenueID=v.VenueID;

# 20. Find the events with no tracks:
select e.EventName, t.TrackName
from events e
left join tracks t 
on e.EventID=t.EventID
where t.TrackName is null; 

# 21. List all venues with the number of events they have hosted:
select v.VenueID, v.VenueName, count(e.EventID) as no_of_events
from venues v
left join events e
on e.VenueID=v.VenueID
group by v.VenueID, v.VenueName;

# 22. Find attendees who have not RSVP'd to any event:
select * from attendees;

select a.AttendeeID, a.FirstName, a.LastName
from attendees a
where RSVPStatus is null;

# 23 Find the venue with the highest number of events:
select v.VenueID, v.VenueName, count(e.EventID) as no_of_events
from events e
join venues v
on e.VenueID=v.VenueID
group by v.VenueID, v.VenueName
order by no_of_events desc
limit 1;

# 24. window function - Running Total of Attendees per Event
select EventID, FirstName, LastName, COUNT(*) OVER (PARTITION BY EventID ORDER BY AttendeeID) AS RunningTotal
from Attendees
order by
EventID, AttendeeID;

# Rank Events by Number of Attendees
select EventID, COUNT(AttendeeID) AS NumAttendees, RANK() OVER (ORDER BY COUNT(AttendeeID) DESC) AS Rank1
from Attendees
group by 
EventID;

# 25. Stored Procedures - Get event details based on employee ID
delimiter //

create procedure GetEventDetails(in eventID varchar(255))
begin
    select e.EventName, e.EventDate, COUNT(a.AttendeeID) AS NumAttendees
    from Events e
    left join Attendees a 
    ON e.EventID = a.EventID
    where 
    e.EventID = eventID
    group by
	e.EventID, e.EventName, e.EventDate;
end //

delimiter ;

call GetEventDetails('E005');

# Triggers
CREATE TABLE AttendeeLogs (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    AttendeeID INT,
    EventID VARCHAR(255),
    Action VARCHAR(50),
    LogTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from attendees;