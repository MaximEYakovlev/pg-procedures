import { client } from "./config.js";

export const connect = async () => {
    try {
        await client.connect();
        console.log('Connection has been established successfully.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
}