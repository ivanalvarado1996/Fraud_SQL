CREATE TABLE card_holder (
	id serial,
	name character varying (50) NOT NULL, 
	PRIMARY KEY (id)
);

CREATE TABLE credit_card (
	card VARCHAR (20) NOT NULL, 
	cardholder_id serial NOT NULL,
	PRIMARY KEY (card),
	FOREIGN KEY (cardholder_id) REFERENCES card_holder (id)
);

CREATE TABLE merchant_category (
	id serial NOT NULL,
	name VARCHAR (75) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE merchant (
	id serial NOT NULL, 
	name VARCHAR (100) NOT NULL,
	id_merchant_category int NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (id_merchant_category) REFERENCES merchant_category (id)
);

CREATE TABLE transaction (
	id int NOT NULL, 
	date TIMESTAMP NOT NULL,
	amount float NOT NULL,
	card VARCHAR(20) NOT NULL,
	id_merchant int NOT NULL,
	FOREIGN KEY (card) REFERENCES credit_card (card),
	FOREIGN KEY (id_merchant) REFERENCES merchant (id)
);

SELECT * 
FROM transaction
WHERE transaction.amount <= 2
ORDER BY id_merchant DESC
;

SELECT id, amount, date, card, id_merchant, extract(hour from date) as time
FROM transaction
WHERE transaction.amount <= 2
ORDER BY time DESC
;

SELECT card,
COUNT(amount) AS "Total Transactions <= $2.00"
FROM transaction
WHERE transaction.amount <=2
GROUP BY transaction.card
ORDER BY "Total Transactions <= $2.00" DESC
;

