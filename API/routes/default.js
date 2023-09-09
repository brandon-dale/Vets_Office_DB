const ownerRouter = require('./owner');
const employeeRouter = require('./employee');
const petRouter = require('./pet');

// Create the default router
const router = require('koa-router')({
    prefix: '/api/v1'
});

// Create a default route path welcome page
router.get('/', (ctx) => {
    ctx.body = "Welcome to the Vet's Office API!";
})

// Add all of the route paths for the imported routers
router.use(
    ownerRouter.routes(),
    employeeRouter.routes(),
    petRouter.routes()
);

// Export a function that injects all routes of the default router into a koa object
module.exports = (api) => {
    api.use(router.routes());
};