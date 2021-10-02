let admin = require("firebase-admin");

let serviceAccount = require("./service_key.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://bottomsup-dc9b3.firebaseio.com"
});

const firestore = admin.firestore();
const path = require("path");
const fs = require("fs");
const { timeStamp } = require("console");
const directoryPath = path.join(__dirname, "files");

fs.readdir(directoryPath, function(err, files) {
    if (err) {
        return console.log("Unable to scan directory: " + err);
    }

    files.forEach(function(file) {
        var lastDotIndex = file.lastIndexOf(".");

        var menu = require("./files/" + file);

        menu.forEach(function(obj) {
            firestore
                .collection("/users/kings-cup/kings-cup")
                .add(obj)
                .then(function(docRef) {
                    console.log("Document written");
                })
                .catch(function(error) {
                    console.error("Error adding document: ", error);
                });
        });
    });
});