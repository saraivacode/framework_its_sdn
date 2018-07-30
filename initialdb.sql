 -- mysql -u root -pwifi -vvv < mininet-wifi/scripts/initialdb.sql 
DROP DATABASE framework;
CREATE DATABASE framework;
USE framework;
CREATE TABLE appkpi (id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, class CHARACTER(1), application VARCHAR(20), e2e_latency FLOAT(7), reliability FLOAT(7), data_rate FLOAT(7), protocol VARCHAR(5), port INT(11));
CREATE TABLE infrastructure (ip VARCHAR (40) NOT NULL PRIMARY KEY, app INT(11));
ALTER TABLE infrastructure ADD CONSTRAINT app FOREIGN KEY (app) REFERENCES appkpi (id);
CREATE TABLE rsu (dpid INT (11) NOT NULL PRIMARY KEY, Region INT(11), limite FLOAT, iface_updtip VARCHAR (10));
CREATE TABLE vehicle (mac VARCHAR(20) NOT NULL, app_id INT(11), region INT(11));
ALTER TABLE vehicle ADD CONSTRAINT fk_app FOREIGN KEY (app_id) REFERENCES appkpi (id);
CREATE TABLE redirect (mac VARCHAR(20) NOT NULL, rsu_o VARCHAR (10), rsu_dest VARCHAR (10), bw_value INT(11));

INSERT INTO `appkpi` (`id`, `application`, `class`, `e2e_latency`, `reliability`, `data_rate`, `protocol`, `port`) VALUES (NULL, "CCAS", "A", 50, 0.00001, 0, "UDP", 5002);
INSERT INTO `appkpi` (`id`, `application`, `class`, `e2e_latency`, `reliability`, `data_rate`, `protocol`, `port`) VALUES (NULL, "INS", "B", 3000, 0.001, 1000000, "UDP", 5003);
INSERT INTO `appkpi` (`id`, `application`, `class`, `e2e_latency`, `reliability`, `data_rate`, `protocol`, `port`) VALUES (NULL, "4KLV", "C", NULL, NULL, 3000000, "UDP", 5004);

INSERT INTO `infrastructure` (`ip`, `app`) VALUES ("200.0.10.2", 1);
INSERT INTO `infrastructure` (`ip`, `app`) VALUES ("200.0.10.3", 2);
INSERT INTO `infrastructure` (`ip`, `app`) VALUES ("200.0.10.4", 3);

INSERT INTO `rsu` (`dpid`, `region`, `limite`, `iface_updtip`) VALUES (6, 1, 10, "rsu1-eth2");
INSERT INTO `rsu` (`dpid`, `region`, `limite`, `iface_updtip`) VALUES (7, 1, 10, "rsu2-eth2");

INSERT INTO `vehicle` (`mac`, `app_id`, `region`) VALUES ("00:00:00:00:00:01", 1, 1);
INSERT INTO `vehicle` (`mac`, `app_id`, `region`) VALUES ("00:00:00:00:00:02", 1, 1);
INSERT INTO `vehicle` (`mac`, `app_id`, `region`) VALUES ("00:00:00:00:00:03", 1, 1);
INSERT INTO `vehicle` (`mac`, `app_id`, `region`) VALUES ("00:00:00:00:00:01", 2, 1);
INSERT INTO `vehicle` (`mac`, `app_id`, `region`) VALUES ("00:00:00:00:00:02", 2, 1);
INSERT INTO `vehicle` (`mac`, `app_id`, `region`) VALUES ("00:00:00:00:00:03", 2, 1);
INSERT INTO `vehicle` (`mac`, `app_id`, `region`) VALUES ("00:00:00:00:00:01", 3, 1);
INSERT INTO `vehicle` (`mac`, `app_id`, `region`) VALUES ("00:00:00:00:00:02", 3, 1);
INSERT INTO `vehicle` (`mac`, `app_id`, `region`) VALUES ("00:00:00:00:00:03", 3, 1);