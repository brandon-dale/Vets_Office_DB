// Import the employee controller
const EmployeeController = require('../controllers/employeeController');

// Create a new prefixed router
const employeeRouter = require('koa-router')({
    prefix: '/employee'
});

// Add all employee routes to the employee router
employeeRouter.get('/:id', EmployeeController.getEmployeeByID);
employeeRouter.put('/:id', EmployeeController.updateSalaryByID);
employeeRouter.post('/', EmployeeController.addEmployee);
employeeRouter.delete('/:id', EmployeeController.deleteEmployeeByID);

// Export the router
module.exports = employeeRouter;