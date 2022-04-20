const functions = require("firebase-functions");


const stripe = require('stripe')(functions.config().stripe.testkey);
exports.stripePay = functions.https.onRequest(async (req, res) => {
    const stripeVendorAccount = 'acct_1J6KlfPn2tP4KGXF';
    stripe.paymentMethod.create(
        {
            payment_method: req.query.paym
        }, {
        stripeAccount: stripeVendorAccount
    },
        function (err, rpaymentMethod) {
            if (err != null) {
                console.log(err);
            }
            else {
                stripe.paymentIntents.create(
                    {
                        amoumt: req.query.amoumt,
                        currency: req.query.currency,
                        payment_method: rpaymentMethod.id,
                        confirmation_method: 'automatic',
                        confirm: true,
                        description: req.query.description
                    }, function (err, paymentIntent) {
                        if (err != null) {
                            console.log(err);
                        }
                        else {
                            res.json({
                                paymentIntent: paymentIntent,
                                stripeAccount: stripeVendorAccount
                            });
                        }
                    }
                )
            }
        }
    )
})