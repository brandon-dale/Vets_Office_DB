// Import the database connection
const db = require('../database/connection');

class PetController {
    /**
     * Gets the information of a pet, given their ID
     * @param {*} ctx A KoaJS context object
     *      ctx.params must contain:
     *          id - A pet's id
     */
    static getPetByID (ctx) {
        return new Promise((resolve, reject) => {
            const query = `SELECT * FROM Pet WHERE id = ?`;

            db.query({
                sql: query,
                values: [ctx.params.id]
            }, (err, res) => {
                if (err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            });
        });
    }

    /**
     * Returns a list of all owners, with their information
     * for a single pet, given their ID
     * @param {*} ctx A KoaJS context object
     *      ctx.params must contain:
     *          id - the pet id to find the owners of
     */
    static getOwnersByID (ctx) {
        return new Promise((resolve, reject) => {
            const query = `
                SELECT *
                FROM Pet_Owner po JOIN Owner o
                  ON po.owner_id = o.id
                WHERE po.pet_id = ?;
            `;

            db.query({
                sql: query,
                values: [ctx.params.id]
            }, (err, res) => {
                if (err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            });
        });
    }

    /**
     * Makes the specified owner an owner (but not necessarily the only one)
     * of the specified pet
     * @param {*} ctx A KoaJS context object
     *      ctx.params must contain:
     *          petID - A pet id
     *          ownerID - A owner id
     */
    static addPetOwner (ctx) {
        return new Promise((resolve, reject) => {
            const query = `
                INSERT INTO Pet_Owner (owner_id, pet_id)
                VALUES (?, ?)
            `;

            db.query({
                sql: query,
                values: [ctx.params.ownerID, ctx.params.petID]
            }, (err, res) => {
                if (err) {
                    reject(err);
                }
                ctx.status = 201;
                resolve();
            });
        });
    }

    /**
     * Close the database connection
     */
     static close () {
        db.end();
    }
}

// Export the pet controller class
module.exports = PetController;