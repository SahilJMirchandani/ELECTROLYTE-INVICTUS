// Production route handlers for logging production

const express = require('express');
const router = express.Router();

// Middleware to log production data
router.post('/log', (req, res) => {
    const { productId, quantity, componentsUsed } = req.body;
    // Log the production data
    console.log(`Logging production for Product ID: ${productId}, Quantity: ${quantity}`);

    // Simulate automatic component deduction
    const componentsDeducted = componentsUsed.map(comp => ({ id: comp.id, deducted: true }));
    console.log(`Components deducted: `, componentsDeducted);

    // Trigger generation of procurement if necessary
    const needsProcurement = quantity > 100; // Example condition
    if (needsProcurement) {
        console.log(`Procurement trigger generated for Product ID: ${productId}`);
        // Logic to trigger procurement goes here
    }

    res.status(200).json({ message: 'Production logged successfully.', componentsDeducted });
});

module.exports = router;