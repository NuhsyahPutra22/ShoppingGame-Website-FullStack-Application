var express = require('express');
var jwt = require('jsonwebtoken');
var config = require('../config');
var app = express();
var bodyParser = require('body-parser');
var cors = require('cors');
app.options('*', cors());
app.use(cors());

var user = require('../model/user.js');
var game = require('../Model/game.js');
var review = require('../Model/review.js');
var category = require('../Model/category.js');
var isLoggedInMiddleware = require("../auth/isLoggedInMiddleware");
var urlencodedParser = bodyParser.urlencoded({ extended: false });
app.use(bodyParser.json());
app.use(urlencodedParser);
app.use(express.static("public"));

// User endpoints

app.get('/users/:id/', function (req, res) {
    var userid = req.params.id;
    //do check that the id used is a number
    if (isNaN(parseInt(userid))) {
        res.status(422).json({ message: `Id ${userid} is not a number!` });
    } else {
        user.getUserid(userid, function (err, result) {
            if (!err) {
                res.status(200).send(result);
            } else {
                res.status(500).send("{'Messsage':'Internal Server Error'}");
            }
        });
    }
});

//find all

app.get('/users/', function (req, res) {
    user.retrieveUser(function (err, result) {
        if (!err) {
            res.status(200);
            res.send(result);
        } else {
            res.status(500).send("{'Messsage':'Internal Server Error'}");
        }
    });
});

//Add user
app.post('/users/', function (req, res) {
    var { username, email, type, profile_pic_url } = req.body;
    user.addUser(username, email, type, profile_pic_url, function (err, result) {
        if (!err) {
            console.log(result);
            res.status(201).json({ "userid": result.insertId });
        } else {
            res.status(500).send("{'Messsage':'Internal Server Error'}");
        }
    });
});


// Add category
app.post('/category', function (req, res) {
    var { catname, description } = req.body;
    category.addCategory(catname, description, function (err, result) {
        if (!err) {
            console.log(result);
            res.status(204).json({ msg: result });
        } else {
            if (err) {
                if (err.code == 'ER_DUP_ENTRY') {
                    res.status(422).send("The category name provided already exists");
                    return;
                }
                res.status(500).send("Internal Server Error");
            }
        }
    });
});


//Update category
app.put('/category/:id', isLoggedInMiddleware, function (req, res) {
    var categoryid = req.params.id;
    //use destructuring to get the variables in req.body
    //it is easier to read
    var { catname, description } = req.body;
    //do check that the id used is a number
    if (isNaN(parseInt(categoryid))) {
        res.status(422).json({ message: `Id ${categoryid} is not a number!` });
    } else {
        category.updatecategory(catname, description, categoryid, function (err, result) {
            if (!err) {
                console.log(result);
                res.status(204).json({ msg: result });
            } else {
                if (err.code == 'ER_DUP_ENTRY') {
                    res.status(422).send("The category name provided already exists");
                    return;
                }
                res.status(500).send("Internal Server Error");
            }
        });
    }
});
// add game
app.post('/game', function (req, res) {
    var { title, description, price, platform, fk_categoryid, year } = req.body;
    game.addgame(title, description, price, platform, fk_categoryid, year, function (err, result) {
        if (!err) {
            console.log(result);
            res.status(201).json(`{"gameid":"${result.insertId}"}`);
        } else {
            res.status(500).send("{'Messsage':'Internal Server Error'}");
        }
    });
});
//get game
app.get('/games/:platform', function (req, res) {
    var platform = req.params.platform;
    game.retrievegame(platform, function (err, result) {
        if (!err) {
            res.send(result);
            res.status(200);
        } else {
            res.status(500).send("{'Messsage':'Internal Server Error'}");
        }
    });
});
//delete game
app.delete('/game/:id', function (req, res) {
    var gameid = req.params.id;
    //do check that the id used is a number
    if (isNaN(parseInt(gameid))) {
        res.status(204).json({ message: `Id ${gameid} is not a number!` });
    } else {
        game.deletegame(gameid, function (err, result) {
            if (!err) {
                res.send(result + ' record deleted');
            } else {
                console.log(err);
                res.status(500).send("Internal Server Error");
            }
        });
    }
});
//update game
app.put('/game/:id', function (req, res) {
    var id = req.params.id;
    //use destructuring to get the variables in req.body
    //it is easier to read
    var { title, description, price, platform, year, fk_categoryid } = req.body;
    //do check that the id used is a number
    game.updategame(title, description, price, platform, year, fk_categoryid, id, function (err, result) {
        if (!err) {
            console.log(result);
            res.status(204).send(`Record ${id} is updated. Rows affected = ${result}`);
        } else {
            res.status(500).send("{'Messsage':'Internal Server Error'}");
        }
    });
});
//ten endpoint question //
app.post('/user/:uid/game/:gid/review/', function (req, res) {
    var { content, rating } = req.body;
    var gid = req.params.gid;
    var uid = req.params.uid;
    review.addreview(content, rating, gid, uid, function (err, result) {
        if (!err) {
            res.type("json");
            res.status(201);
            res.send(`{"reviewid": ${result.insertId}}`);
        } else {
            res.status(500).send("{'Messsage':'Internal Server Error'}");
        }
    });
});

//eleven endpoint question//
app.get('/game/:id/review', function (req, res) {
    var id = req.params.id;
    review.getreview(id, function (err, result) {
        if (!err) {
            res.send(result);
            res.status(200);
        } else {
            res.status(500).send("{'Messsage':'Internal Server Error'}");
        }
    });
});


app.post('/user/login', function (req, res) {
    var email = req.body.email;
    var password = req.body.password;

    user.loginUser(email, password, function (err, token, result) {
        if (!err) {
            res.statusCode = 200;
            res.setHeader('Content-Type', 'application/json');
            delete result[0]['password'];//clear the password in json data, do not send back to client
            console.log(result);
            res.json({ success: true, UserData: JSON.stringify(result), token: token, status: 'You are successfully logged in!' });
            res.send();
        } else {
            res.status(500);
            res.send(err.statusCode);
        }
    });
});


app.put('/user/update', isLoggedInMiddleware, function (req, res) {
    // var username = req.body.username;
    // var email = req.body.email;
    // var role = req.body.role;
    const {
        username,
        email,
        type
    } = req.body;
    const userid = req.userid;


    user.updateUser(username, email, type, userid, function (err, err, result) {
        if (!err) {
            console.log("Update successful");
            res.statusCode = 200;
            res.setHeader('Content-Type', 'application/json');
            res.json({
                success: true,
                result: result,
                status: 'Record updated successfully!'
            });
        } else {
            console.log(err)
            res.status(500);
            res.send(err.statuscode);
        }
    })
});



app.post('/user/logout', function (req, res) {
    console.log("..logging out.");
    //res.clearCookie('session-id'); //clears the cookie in the response
    //res.setHeader('Content-Type', 'application/json');
    res.json({
        success: true,
        status: 'Log out successful!'
    });

});
//get game

app.get("/game", (req, res) => {
    game.findAll((error, posts) => {
        if (error) {
            console.log(error);
            res.status(500).send();
            return;
        }
        res.status(200).send(posts);
    });
});
//single game

app.get("/game/:id", (req, res) => {
    var id = req.params.id;
    game.Review(id, (error, posts) => {
        if (error) {
            console.log(error);
            res.status(500).send();
            return;
        }
        res.status(200).send(posts);
    });
});


app.get("/games/:name/name", (req, res) => {
    var name = req.params.name;
    game.SearchGame(name, (error, posts) => {
        if (error) {
            console.log(error);
            res.status(500).send();
            return;
        }
        res.status(200).send(posts);
    });
});

app.get("/games/:price/price", (req, res) => {
    var price = req.params.price;
    game.SearchFee(price, (error, posts) => {
        if (error) {
            console.log(error);
            res.status(500).send();
            return;
        }
        res.status(200).send(posts);
    });
});


app.get('/user', function (req, res) {
    user.getUsers(function (err, result) {
        if (!err) {
            res.send(result);
        } else {
            res.status(500).send(null);
        }
    });
});

app.post("/reviews", (req, res) => {
    // console.log(req.body);
    game.insert(req.body, (error, results) => {
        if (error) {
            res.status(500).send(error);
        } else {
            res.status(200).send(results);
        }
    });
});
app.get('/rating/:fk_gameid', function (req, res) {
    var fk_gameid = req.params.fk_gameid
    review.getrating(fk_gameid, function (err, result) {
        if (!err) {
            res.type("json");
            res.status(200);
            res.send(result);
        } else {
            res.status(500);
            res.send("Internal Server Error");
        }
    });
});

module.exports = app;




