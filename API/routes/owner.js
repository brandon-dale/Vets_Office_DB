// Import the owner controller
const OwnerController = require('../controllers/ownerController');

// Create a new prefixed koa router for the owner routes
const ownerRouter = require('koa-router')({
    prefix: '/owner'
});

// Add all owner routes to the owner router
ownerRouter.get('/:id', OwnerController.getOwnerByID);
ownerRouter.get('/moneyDue/:id', OwnerController.getOutstandingPaymentsByID);
ownerRouter.put('/:id', OwnerController.updateOwnerAddressByID);
ownerRouter.post('/', OwnerController.addOwner);
ownerRouter.delete('/:id/num/:ph_num', OwnerController.deletePhoneNumberByID);

// Eport the owner router
module.exports = ownerRouter;