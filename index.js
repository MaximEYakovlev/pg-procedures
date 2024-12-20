import * as db from './db/index.js';

// const createTable = async () => {
//     await db.client.query(`
//         CREATE TABLE IF NOT EXISTS tbl (id SERIAL NOT NULL PRIMARY KEY, name VARCHAR(10)); 
//     `);
// }

// const createProcedure = async () => {
//     await db.client.query(`
//         CREATE OR REPLACE PROCEDURE insert_data(a VARCHAR(10))
//         LANGUAGE SQL
//         BEGIN ATOMIC
//           INSERT INTO tbl (name) VALUES (a);
//         END;
//     `);
// }

const createProcedure = async () => {
    await db.client.query(`
        CREATE OR REPLACE PROCEDURE update(factor NUMERIC)
        LANGUAGE plpgsql
        AS $$
        BEGIN
        UPDATE Bookings
        SET total_amount = total_amount * factor;
        END;
        $$;
    `);
}

const alterProcedure = async () => {
    await db.client.query(`
        ALTER PROCEDURE update RENAME TO recalculate_total_amount;
    `);
}

const dropProcedure = async () => {
    await db.client.query(`
        DROP PROCEDURE IF EXISTS recalculate_total_amount;
    `);
}

// const call = async () => {
//     await db.client.query(`
//         CALL insert_data('Foo');
//     `);
// }

const call = async () => {
    await db.client.query(`
        CALL recalculate_total_amount(1.1);
    `);
}

const run = async () => {
    await db.connect();
    // await createTable();
    await createProcedure();
    await alterProcedure();
    await call();
    await dropProcedure();
    await db.disconnect();
}

run();
