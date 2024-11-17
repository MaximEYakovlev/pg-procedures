import { client } from "./config.js";

export const disconnect = async () => {
    client.end();
}
