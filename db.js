import pg from 'pg';
const { Client } = pg;

export const client = new Client({
    user: 'user',
    password: 'password',
    host: 'localhost',
    port: 5432,
    database: 'postgres_db',
});