const admin = require('firebase-admin');
const serviceAccount = require('../firebase/plotvote-ash-firebase-adminsdk-fbsvc-ab9c5ec554.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

module.exports = admin;