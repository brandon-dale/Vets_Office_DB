// Import necessary files
const defaultRouter = require('./routes/default');
const koa = require('koa');
const koajson = require('koa-json');
const koabodyparser = require('koa-bodyparser');

// Create a new Koa instance
const api = new koa();

// Inject middleware for JSON parsing and pretty-printing
api.use(koajson());
api.use(koabodyparser());

// Apply a try-catch block to the call to the default router
api.use(async (ctx, next) => {
    try {
        await next();
    } catch (e) {
        console.error(e);
    }
});

// Inject all of the routes into koa
defaultRouter(api);

// Start listening on port 8043
api.listen(8043);