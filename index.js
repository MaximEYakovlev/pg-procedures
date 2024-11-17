import { client } from "./db/config.js";
import { connect } from "./db/connect.js";
import { disconnect } from "./db/disconnect.js";

const createTable = async () => {
    await client.query(`
        CREATE TABLE IF NOT EXISTS tbl (id SERIAL NOT NULL PRIMARY KEY, name VARCHAR(10)); 
    `);
}

const createProcedure = async () => {
    await client.query(`
        CREATE OR REPLACE PROCEDURE insert_data(a VARCHAR(10))
        LANGUAGE SQL
        BEGIN ATOMIC
          INSERT INTO tbl (name) VALUES (a);
        END;
    `);
}

const call = async () => {
    await client.query(`
        CALL insert_data('Foo');
    `);
}

const run = async () => {
    await connect();
    await createTable();
    await createProcedure();
    await call();
    await disconnect();
}

run();
