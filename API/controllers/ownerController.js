// Import the database connection
const db = require('../database/connection');

class OwnerController {
    /**
     * Gets all of the information of an owner, given their id
     * @param {*} ctx a KoaJS context object
     *      cts.params must contain:
     *          id - the owner id
     */
    static getOwnerByID (ctx) {
        return new Promise((resolve, reject) => {
            const query = `SELECT * FROM Owner WHERE id = ?`;
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
     * Returns the outstanding payments for an owner given their id
     * as a parameter.
     * @param {*} ctx the KoaJS context object
     *      ctx.params must contain:
     *          id - the owner id
     */
    static getOutstandingPaymentsByID (ctx) {
        return new Promise((resolve, reject) => {
            // Query to get the sum of outstanding payments for an owner
            // grouped by pet and date
            const query = `
                SELECT
                    \`Owner ID\`,
                    \`Pet ID\`,
                    v.date,
                    SUM(cost) AS \`Total Cost\`
                FROM vw_OwnersOutstandingPayments voop JOIN Visit v 
                  ON voop.\`Pet ID\` = v.pet_id
                JOIN Visit_Service vs ON v.pet_id = vs.pet_id AND v.\`date\` = vs.\`date\`
                JOIN Service s ON vs.service = s.name 
                WHERE \`Owner ID\` = ? AND v.paid = FALSE
                GROUP BY v.date,  \`Pet ID\`
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
     * Updates an owners address given their id as a parameter
     * @param {*} ctx  the KoaJS context object
     *      ctx.params must contain:
     *          id - the id of the owner to update
     *      ctx.request.body must contain a JSON object with:
     *          street, city, state, and zip
     */
    static updateOwnerAddressByID (ctx) {
        return new Promise((resolve, reject) => {
            const address = ctx.request.body;
            const query = `
                UPDATE Owner
                SET 
                    street = ?,
                    city = ?,
                    state = ?,
                    zip = ?
                WHERE id = ?
            `;
            
            db.query({
                sql: query,
                values: [address.street, address.city, address.state, address.zip, ctx.params.id]
            }, (err, res) => {
                if (err) {
                    reject(err);
                }
                ctx.status = 200;
                resolve();
            });
        });
    }

    /**
     * Adds a new owner to the database (ID is auto generated)
     * @param {*} ctx A KoaJS context object
     *      ctx.request.body must contain a JSON object with:
     *          dob, f_name, l_name, street, city, state, and zip
     */
    static addOwner (ctx) {
        return new Promise((resolve, reject) => {
            // Save the owner object from the context request and write the query
            const owner = ctx.request.body;
            const query = `
                INSERT INTO Owner (dob, f_name, l_name, street, city, state, zip)
                VALUES (?, ?, ?, ?, ?, ?, ?);
            `;

            // Query the DB to insert the new owner
            db.query({
                sql: query,
                values: [owner.dob, owner.f_name, owner.l_name, owner.street, owner.city, 
                         owner.state, owner.zip]
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
     * Deletes an owners phone number given their id
     * @param {*} ctx  a KoaJS context object
     *      ctx.params must contain:
     *          id - the owner's id
     *          ph_num - the owner's phone number to delete
     */
    static deletePhoneNumberByID (ctx) {
        return new Promise((resolve, reject) => {
            // Query deletes any tuple where id and phone numbers match
            // Input phone numbers are transformed like: "1231231234" -> "123-123-1234" 
            // before comparisons
            const query = `
                DELETE FROM Owner_PhoneNumber 
                WHERE owner_id = ? AND ph_number = (
                    SELECT CONCAT_WS('-',
                        SUBSTR(n, 1, 3),
                        SUBSTR(n, 4, 3),
                        SUBSTR(n, 7, 7)
                        )
                    FROM (SELECT ? as n) as t
                )
            `;

            // Run the above query
            db.query({
                sql: query,
                values: [ctx.params.id, ctx.params.ph_num]
            }, (err, res) => {
                if (err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            })
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
module.exports = OwnerController;