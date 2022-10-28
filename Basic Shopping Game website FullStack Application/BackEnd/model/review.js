//name: Muhammad Nuhsyah Putra Bin Ramlee
//adminNumber:2045302
//class:DIT/FT/1B02
const db=require('./databaseConfig');
var review={ 
    addreview: function (content, rating, gid, uid, callback) { 
        var conn = db.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err,null);
            } else {
                console.log("Connected!");
                var sql = 'Insert into reviews(content, rating, fk_gameid, fk_userid) values(?,?,?,?)';
                conn.query(sql, [content,rating,gid,uid], function (err, result) { 
                    if (err) {
                        console.log(err);
                        return callback(err,null);
                    }
                      conn.end();
                            if (err) {
                                console.log(err);
                                return callback(err,null);
                            } else {
                                console.log(result); 
                                return callback(null,result);
                            }
                        });
                    }
                });
            },
            getreview:function  (id,callback) {
                var Conn = db.getConnection();
                Conn.connect(function (err) {
                    if (err) {//database connection gt issue!
                        console.log(err);
                        callback(err, null);
                    } else {
                        var sql = `Select g.gameid, r.content, r.rating, u.username, r.created_at
                        from game g, user u, reviews r WHERE fk_gameid=gameid AND fk_userid=userid and fk_gameid=?`
                        Conn.query(sql, [id], function (err, result) {
                            Conn.end();
                            if (err) {
                                console.log(err);
                                return callback(err,null);
                            } else {
                                return callback(null, result);
                            }
                        });
                    }
                });
    },
    getrating:function (fk_gameid, callback) {
        var conn = db.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            }
            else {
                var sql = `SELECT AVG(rating) as rating from reviews where fk_gameid=?`;
    
                conn.query(sql, [fk_gameid], function (err, result) {
                    conn.end();
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        console.log(result);
                        return callback(null, result);
                    }
                });
            }
        });
    }
}










module.exports=review;