import pg from 'pg';
const { Client } = pg;

const client = new Client({
    user: 'user',
    password: 'password',
    host: 'localhost',
    port: 5432,
    database: 'postgres_db',
});

const connect = async () => {
    try {
        await client.connect();
        console.log('Connection has been established successfully.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
}

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
}

run();
