CREATE TABLE brewery
(
    `id`                 VARCHAR(36)  NOT NULL,
    `version`            BIGINT       NULL,
    `created_date`       datetime(6)  NULL,
    `last_modified_date` datetime(6)  NULL,
    `brewery_name`       VARCHAR(255) NULL,
    CONSTRAINT `pk_brewery` PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE `customer`
(
    `id`                 varchar(36) NOT NULL,
    `created_date`       datetime(6)  DEFAULT NULL,
    `last_modified_date` datetime(6)  DEFAULT NULL,
    `version`            bigint       DEFAULT NULL,
    `api_key`            varchar(36)  DEFAULT NULL,
    `customer_name`      varchar(255) DEFAULT NULL,
    CONSTRAINT `pk_customer` PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE `beer`
(
    `id`                 varchar(36) NOT NULL,
    `beer_name`          varchar(255)   DEFAULT NULL,
    `beer_style`         varchar(255)   DEFAULT NULL,
    `created_date`       datetime(6)    DEFAULT NULL,
    `last_modified_date` datetime(6)    DEFAULT NULL,
    `min_on_hand`        int            DEFAULT NULL,
    `price`              decimal(19, 2) DEFAULT NULL,
    `quantity_to_brew`   int            DEFAULT NULL,
    `upc`                varchar(255)   DEFAULT NULL,
    `version`            bigint         DEFAULT NULL,
    CONSTRAINT PRIMARY KEY (`id`),
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

ALTER TABLE `beer`
    ADD CONSTRAINT `uc_beer_upc` UNIQUE (`upc`);


CREATE TABLE beer_inventory
(
    `id`                 VARCHAR(36) NOT NULL,
    `version`            BIGINT      NULL,
    `created_date`       datetime(6) NULL,
    `last_modified_date` datetime(6) NULL,
    `beer_id`            char(36)    NULL,
    `quantity_on_hand`   INT         NULL,
    CONSTRAINT `pk_beerinventory` PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

ALTER TABLE beer_inventory
    ADD CONSTRAINT FK_BEERINVENTORY_ON_BEER FOREIGN KEY (`beer_id`) REFERENCES beer (`id`);


CREATE TABLE beer_order
(
    `id`                        VARCHAR(36)  NOT NULL,
    `version`                   BIGINT       NULL,
    `created_date`              datetime(6)  NULL,
    `last_modified_date`        datetime(6)  NULL,
    `customer_ref`              VARCHAR(255) NULL,
    `customer_id`               char(36)     NULL,
    `order_status`              INT          NULL,
    `order_status_callback_url` VARCHAR(255) NULL,
    CONSTRAINT `pk_beerorder` PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

ALTER TABLE beer_order
    ADD CONSTRAINT `FK_BEERORDER_ON_CUSTOMER` FOREIGN KEY (`customer_id`) REFERENCES customer (`id`);

CREATE TABLE beer_order_line
(
    `id`                 VARCHAR(36) NOT NULL,
    `version`            BIGINT      NULL,
    `created_date`       datetime(6) NULL,
    `last_modified_date` datetime(6) NULL,
    `beer_order_id`      char(36)    NULL,
    `beer_id`            char(36)    NULL,
    `order_quantity`     INT         NULL,
    `quantity_allocated` INT         NULL,
    CONSTRAINT `pk_beerorderline` PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

ALTER TABLE beer_order_line
    ADD CONSTRAINT `FK_BEERORDERLINE_ON_BEER` FOREIGN KEY (`beer_id`) REFERENCES beer (`id`);

ALTER TABLE beer_order_line
    ADD CONSTRAINT `FK_BEERORDERLINE_ON_BEERORDER` FOREIGN KEY (`beer_order_id`) REFERENCES beer_order (`id`);