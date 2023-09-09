// Import the database connection
const db = require('../database/connection');

class EmployeeController {
    /**
     * Get all of the information for an  employee given their id
     * @param {*} ctx a KoaJS context object
     *      ctx.params must contains:
     *          id - the employee id
     */
    static getEmployeeByID (ctx) {
        return new Promise((resolve, reject) => {
            const query = `SELECT * FROM Employee WHERE id = ?`;

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
     * Updates the salary of an employee given their id
     * @param {*} ctx A KoaJS context object
     *      ctx.params must include:
     *          id - An employee id
     *      ctx.request.body must include:
     *          A JSON object with the key "amt"
     */
    static updateSalaryByID (ctx) {
        return new Promise((resolve, reject) => {
            const newAmount = ctx.request.body;
            const query = `CALL sp_ApplySalaryChange(?, ?)`;

            db.query({
                sql: query,
                values: [ctx.params.id, newAmount.amt]
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
     * Adds a new employee to the database (ID is auto-generated)
     * @param {*} ctx 
     *      ctx.request.body must contain a JSON object with:
     *          ssn, dob, f_name, l_name, start_date, salary, position
     */
    static addEmployee (ctx) {
        return new Promise((resolve, reject) => {
            const employee = ctx.request.body;
            const query = `
                INSERT INTO Employee (ssn, dob, f_name, l_name, start_date, salary, position)
                VALUES (?, ?, ?, ?, ?, ?, ?);
            `;

            db.query({
                sql: query,
                values: [employee.ssn, employee.dob, employee.f_name, employee.l_name, employee.start_date,
                         employee.salary, employee.position]
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
     * Deletes an employee from the database given thier ID
     * @param {*} ctx A KoaJS context object
     *      ctx.params must contain:
     *          id - the id of the employee to delete
     */
    static deleteEmployeeByID (ctx) {
        return new Promise((resolve, reject) => {
            const query = `
                DELETE FROM Employee
                WHERE id = ?
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
     * Close the database connection
     */
     static close () {
        db.end();
    }
}

// Export the pet controller class
module.exports = EmployeeController;