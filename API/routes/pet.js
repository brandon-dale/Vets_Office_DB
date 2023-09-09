// Import the pet controller
const PetController = require('../controllers/petController');

// Create a new prefixed koa router for pet routes
const petRouter = require('koa-router')({
    prefix: '/pet'
});

// Add all pet route paths to the pet router
petRouter.get('/:id', PetController.getPetByID);
petRouter.get('/owners/:id', PetController.getOwnersByID);
petRouter.post('/:petID/owner/:ownerID', PetController.addPetOwner);

// Export the pet router
module.exports = petRouter;