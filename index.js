const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('postgres_db', 'user', 'password', {
    host: 'localhost',
    dialect: 'postgres'
});

const connect = async () => {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
}

const createTable = async () => {
    await sequelize.query(`
        CREATE TABLE IF NOT EXISTS tbl (id SERIAL NOT NULL PRIMARY KEY, name VARCHAR(10)); 
    `);
}

const createProcedure = async () => {
    await sequelize.query(`
        CREATE OR REPLACE PROCEDURE insert_data(a VARCHAR(10))
        LANGUAGE SQL
        BEGIN ATOMIC
          INSERT INTO tbl (name) VALUES (a);
        END;
    `);
}

const call = async () => {
    await sequelize.query(`
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
