create table SCIENCE_ARTICLE (
	id int primary key AUTO_INCREMENT,
    Title varchar(255) not null,
    PublishDate date,
    GithubCode varchar(255),
    link varchar(255),
    LastModified timestamp,
    Price decimal(10,2)
);

create table Author (
	orcid int primary key AUTO_INCREMENT,
    BirthDate date,
    PenName Varchar(255),
    Lname varchar(255),
    Fname varchar(255),
    DomainConflict varchar(255)
);

create table user (
	id int primary key AUTO_INCREMENT,
    Username varchar(255) not null,
    Hashpassword varchar(255)
);

create table cart (
id int primary key AUTO_INCREMENT
);

CREATE TABLE Academic_Event (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    year INT NOT NULL CHECK (year >= 0)
);

create table Category (
CategoryName varchar(255) primary key,
Description varchar(255)
);

create table dataset(
	name varchar(255) primary key,
    Description varchar(255),
    size varchar(255)
);
CREATE TABLE admin (
    id INT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES user(id)
);


create table discount_coupon (
id int primary key AUTO_INCREMENT,
VipTierRequired int ,
TimeStart timestamp,
TimeEnd timestamp,
Dicount float,
DiscountUnit enum("%", "$"),
AdminID int,
CreatedTime timestamp,
FOREIGN KEY (AdminID) REFERENCES admin(id)
);

CREATE TABLE Conference (
    id INT PRIMARY KEY AUTO_INCREMENT,
    area VARCHAR(255) NOT NULL,
    sponsors VARCHAR(255),
    `rank` ENUM('A*','A','B','C','D'),
	FOREIGN KEY (id) REFERENCES academic_event(id)
);

create table journal (
	id int primary key,
    association varchar(255),
    level enum('Q1','Q2','Q3','Q4'),
    FOREIGN KEY (id) REFERENCEs academic_event(id)
);

create table reader(
	id int primary key,
    creditcard varchar(255),
    VipTier enum('0','1','2','3','4','5'),
    CartID int,
    FOREIGN KEY (CartID) REFERENCES cart(id)
);

create table paper (
	id int primary key AUTO_INCREMENT,
	EventID int,
	FOREIGN KEY (id) REFERENCES science_article(id),
	FOREIGN KEY (EventID) REFERENCES academic_event(id)
);

create table technical_report (
	id int primary key,
	`organization` varchar(255),
	FOREIGN KEY (id) REFERENCES science_article(id)
);

CREATE TABLE article_keyword (
    ArticleID INT,
    Keyword VARCHAR(255),
    PRIMARY KEY (ArticleID, Keyword),
    FOREIGN KEY (ArticleID) REFERENCES science_article(id)
);
CREATE TABLE AUTHOR_SOCIAL_ACCOUNT (
    ORCID INT,
    SocialAccount VARCHAR(255),
    PRIMARY KEY (ORCID, SocialAccount),
    FOREIGN KEY (ORCID) REFERENCES author(ORCID)
);

CREATE TABLE THESIS(
    id INT primary key,
    Education_Insitution VARCHAR(255),
    FOREIGN KEY (id) REFERENCES science_article(id)
);

CREATE TABLE COLLECTION(
    ReaderID INT,
    `Name` VARCHAR(255),
    primary key (ReaderID,`Name`),
    FOREIGN KEY (ReaderID) REFERENCES reader(id)
);

CREATE TABLE PAYMENT(
    id INT primary key AUTO_INCREMENT,
    `Time` timestamp,
    ReaderID int,
    FOREIGN KEY (ReaderID) REFERENCES reader(id)
);


CREATE TABLE PAYMENT_ITEM(
    id INT primary key AUTO_INCREMENT,
    ArticleID int,
    PaymentID int,
    FOREIGN KEY (ArticleID) REFERENCES science_article(id),
	FOREIGN KEY (PaymentID) REFERENCES payment(id)
);


CREATE TABLE ARTICLE_CITE_ARTICLE(
    CitingArticleID INT,
    CitedArticleID int,
    PRIMARY KEY (CitingArticleID,CitedArticleID),
    FOREIGN KEY (CitingArticleID) REFERENCES science_article(id),
	FOREIGN KEY (CitedArticleID) REFERENCES science_article(id)
);

CREATE TABLE READER_HAS_DISCOUNT_COUPON(
	ReaderID int,
    CoupinID INT ,
    `use` bool,
    PRIMARY KEY (ReaderID,CoupinID),
    FOREIGN KEY (ReaderID) REFERENCES reader(id),
	FOREIGN KEY (CoupinID) REFERENCES discount_coupon(id)
);

CREATE TABLE PAYMENT_DISCOUNT_COUPON(
    Id INT PRIMARY KEY,
	FOREIGN KEY (Id) REFERENCES discount_coupon(id)
);

CREATE TABLE ARTICLE_DISCOUNT_COUPON(
    Id INT PRIMARY KEY,
	FOREIGN KEY (Id) REFERENCES discount_coupon(id)
);

CREATE TABLE COST_BASE_DISCOUNT_COUPON(
    Id INT PRIMARY KEY,
    CostCondition dec(10,2) check (CostCondition>=0),
	FOREIGN KEY (Id) REFERENCES payment_discount_coupon(id)
);

CREATE TABLE TYPE_ARTICLE_DISCOUNT_COUPON(
    Id INT PRIMARY KEY,
	FOREIGN KEY (Id) REFERENCES payment_discount_coupon(id)
);

CREATE TABLE ARTICLE_SUBCATEGORY_DISCOUNT_COUPON(
    Id INT PRIMARY KEY,
	FOREIGN KEY (Id) REFERENCES type_article_discount_coupon(id)
);

CREATE TABLE PAPER_ACADEMIC_DISCOUNT_COUPON(
    Id INT PRIMARY KEY,
	FOREIGN KEY (Id) REFERENCES type_article_discount_coupon(id)
);


CREATE TABLE DISCOUNT_ON_PAYMENT(
    PaymentCounponID INT PRIMARY KEY,
    PaymentID int,
	FOREIGN KEY (PaymentCounponID) REFERENCES payment_discount_coupon(id),
	FOREIGN KEY (PaymentID) REFERENCES payment(id)
);

CREATE TABLE DISCOUNT_ON_PAYMENT_ITEM(
    ArticleCouponID INT PRIMARY KEY,
    PaymentItemID int,
	FOREIGN KEY (ArticleCouponID) REFERENCES article_discount_coupon(id),
	FOREIGN KEY (PaymentItemID) REFERENCES payment_item(id)
);

CREATE TABLE AUTHOR_WRITE_ARTICLE(
    ArticleID INT ,
    ORCID int,
    PRIMARY KEY (ArticleID,ORCID),
	FOREIGN KEY (ArticleID) REFERENCES science_article(id),
	FOREIGN KEY (ORCID) REFERENCES author(ORCID)
);

CREATE TABLE ARTICLE_BENCHMARK_DATASET(
    ArticleID INT ,
    DatasetName varchar(255),
    result varchar(255),
    PRIMARY KEY (ArticleID,DatasetName),
	FOREIGN KEY (ArticleID) REFERENCES science_article(id),
	FOREIGN KEY (DatasetName) REFERENCES dataset(`name`)
);

CREATE TABLE DISCOUNT_ON_ACADEMIC_EVENT(
    EventCouponID INT ,
    EventID int,
    PRIMARY KEY (EventCouponID,EventID),
	FOREIGN KEY (EventCouponID) REFERENCES paper_academic_discount_coupon(id),
	FOREIGN KEY (EventID) REFERENCES academic_event(id)
);

CREATE TABLE VALID_ARTICLE_COUPON(
    ArticleCouponID INT ,
    ArticleID int,
    PRIMARY KEY (ArticleCouponID,ArticleID),
	FOREIGN KEY (ArticleCouponID) REFERENCES article_discount_coupon(id),
	FOREIGN KEY (ArticleID) REFERENCES science_article(id)
);

CREATE TABLE SUBCATEGORY(
    CategoryName varchar(255) ,
    SubcategoryName varchar(255),
    `Description` varchar(255),
    PRIMARY KEY (CategoryName,SubcategoryName),
	FOREIGN KEY (CategoryName) REFERENCES category(CategoryName)
);

CREATE TABLE SUBCATEGORY_KEYWORD (
    CategoryName VARCHAR(255),
    SubcategoryName VARCHAR(255),
    Keyword VARCHAR(255),
    PRIMARY KEY (CategoryName, SubcategoryName, Keyword),
    FOREIGN KEY (CategoryName, SubcategoryName) REFERENCES subcategory(CategoryName, SubcategoryName)
);

CREATE TABLE ARTICLE_CATEGORIZE_SUBCATEGORY(
    ArticleID int,
    CategoryName VARCHAR(255),
    SubcategoryName VARCHAR(255),
    PRIMARY KEY (ArticleID,CategoryName, SubcategoryName),
    FOREIGN KEY (ArticleID) REFERENCES science_article(id),
    FOREIGN KEY (CategoryName, SubcategoryName) REFERENCES subcategory(CategoryName, SubcategoryName)
);

CREATE TABLE DATASET_FOR_SUBCATEGORY(
    DatasetName VARCHAR(255),
    CategoryName VARCHAR(255),
    SubcategoryName VARCHAR(255),
    PRIMARY KEY (DatasetName,CategoryName, SubcategoryName),
    FOREIGN KEY (DatasetName) REFERENCES dataset(`name`),
    FOREIGN KEY (CategoryName, SubcategoryName) REFERENCES subcategory(CategoryName, SubcategoryName)
);

CREATE TABLE DISCOUNT_ON_SUBCATEGORY(
    SubcategoryCouponID int,
    CategoryName VARCHAR(255),
    SubcategoryName VARCHAR(255),
    PRIMARY KEY (SubcategoryCouponID,CategoryName, SubcategoryName),
    FOREIGN KEY (SubcategoryCouponID) REFERENCES article_subcategory_discount_coupon(id),
    FOREIGN KEY (CategoryName, SubcategoryName) REFERENCES subcategory(CategoryName, SubcategoryName)
);


CREATE TABLE CART_HAS_ARTICLE(
    CartID int,
    ArticleID int,
    PRIMARY KEY (CartID,ArticleID),
    FOREIGN KEY (CartID) REFERENCES cart(id),
    FOREIGN KEY (ArticleID) REFERENCES science_article(id)
);
CREATE TABLE COLLECTION_CONTAIN_ARTICLE(
    ReaderID int,
    `Name` varchar(255),
    ArticleID int,
    PRIMARY KEY (ReaderID,`Name`,ArticleID),
    FOREIGN KEY (ReaderID,`Name`) REFERENCES collection(ReaderID,`Name`),
    FOREIGN KEY (ArticleID) REFERENCES science_article(id)
);