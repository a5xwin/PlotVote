const express = require('express');
const mongoose = require('mongoose');
const http = require('http');
const socketIo = require('socket.io');
const cors = require('cors');
const gameRoutes = require('./routes/gameRoutes');
const userRoutes = require('./routes/userRoutes');
const gameSockets = require('./sockets/gameSockets');
const { authenticateFirebaseToken } = require('./middleware/authMiddleware');

require('dotenv').config();

// Initialization of the Express application
const app = express();

// Настройка CORS
app.use(cors());

// Middleware for handling JSON
app.use(express.json());

// Connecting to the MongoDB database
mongoose.connect(process.env.MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true
}).then(() => {
    console.log('MongoDB connected');
}).catch(err => {
    console.error('MongoDB connection error:', err);
});

// Setting up the HTTP server and WebSocket
const server = http.createServer(app);
const io = socketIo(server, {
    cors: {
        origin: '*', // Specify the actual domain or use '\*' for testing
        methods: ['GET', 'POST']
    }
});

// Authentication of all WebSocket connections via Firebase tokens
io.use(async (socket, next) => {
    try {
        const token = socket.handshake.headers.authorization;
        console.log(socket.handshake.headers);

        const user = await authenticateFirebaseToken(token); 
        if (!user) throw new Error('Invalid token'); 
        socket.user = user; // Adding the user to the socket
        next();
    } catch (error) {
        next(new Error('Authentication error'));
    }
});

// Starting the WebSocket logic
gameSockets(io);

// Connecting routes
app.use('/api/games', gameRoutes); 
app.use('/api/users', userRoutes);

// Error handling
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send({ error: 'Something went wrong!' });
});

// Starting the server
const PORT = process.env.PORT || 5000;
server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
