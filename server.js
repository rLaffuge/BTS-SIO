var express = require('express'),
bodyParser  = require('body-parser'),
connection  = require('express-myconnection'),
mysql       = require('mysql'),
colors      = require('colors'),
favicon     = require('serve-favicon'),
port        = process.env.PORT || 80,
morgan      = require('morgan'), //use to see requests
app = express();


// APP CONFIGURATION
//==============================================================================
// use body-parser pour les POST requests
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
// create application/json parser
var jsonParser = bodyParser.json();

// MySQL connection

app.use(
  connection(mysql,{
    host     : 'localhost',
    user     : 'root',
    password : '',
    debug    : false // true -> debug logger
  },'request')
);

var DBLocation = 'location';

////Permet l'affichage d'info dans la console lors des requetes
app.use(morgan('dev'));

app.use(express.static(__dirname + "/public"));
app.use(favicon(__dirname + '/public/images/favicon.ico'));

// ROUTES
//==============================================================================
// ACCUEIL
app.get('/', function(req, res){
  res.sendFile(__dirname + '/public/Portfolio/index.html');
});

//RESTful API routes
var router = express.Router();

app.use('/AutoLoc', router);

router.get('/', function(req, res){
  res.sendFile(__dirname + '/public/AutoLoc/AutoLoc.html');
});

//404 not found
app.use(function(req, res, next){
  res.status(404).sendFile(__dirname + '/public/404/notFound.html');
});

// | GET | show data in DB |
//------------------------------------------------------------------------------
router.route('/:table').get(function(req,res){

  req.getConnection(function(err,conn){

    if (err) return console.log('Connection fail: ' + err);
    var getQuery = 'SELECT * FROM '+ DBLocation + "." + req.params.table;
    var query = conn.query(getQuery, function(err,rows){
        if(err) return console.log(err);
        console.log('Query send: '+ getQuery .green);
        res.json(rows);
    });

  });

});

// | POST | post data to DB |
//------------------------------------------------------------------------------
router.route('/:table').post(jsonParser, function(req, res){
  req.getConnection(function(err, conn){

    if (err) return console.log('Connection fail: ' + err);
    console.log(req.body);      // JSON req

    //construction de la query
    var postQuery = "INSERT INTO " + DBLocation + "." + req.params.table + " VALUES (";
    var first = true;
    var id = '';
    for(var key in req.body){
      if (first) {
        postQuery += "'" + req.body[key] + "'";
        first = false;
        id = key;

      } else {
        postQuery += ", '" + req.body[key] + "'";
      }
    }
    postQuery += ")";

    console.log('Query send: ' + postQuery .green);

    var query = conn.query(postQuery, function(err, infos){

      if(err){
        console.log(err);
        res.json(infos);
      }else {
        var getQuery = 'SELECT * FROM ' + DBLocation + "." + req.params.table + ' WHERE ' + id +'=' + infos.insertId;
        var query = conn.query(getQuery, function(err, rows){
          if(err){
            console.log(err);
          }
          console.log('Query send: ' + getQuery .green);
          console.log(rows[0]);
          res.json(rows[0]);
        });

      }

    });

  });

});


// | PUT | update data to DB |
//------------------------------------------------------------------------------
router.route('/:table/:idUpdate').put(function(req, res){

  req.getConnection(function(err, conn){

    if (err) return console.log('Connection fail: ' + err .red);
    console.log(req.body);      // JSON req

    //construction de la query
    var putQuery = "UPDATE " + DBLocation + "." + req.params.table + " SET ";
    var first = true;
    for(var key in req.body){
      if (first) {
        putQuery += key + "='" + req.body[key] + "'";
        first = false;
      } else {
        putQuery += ", " + key + "='" + req.body[key] + "'";
      }
    }
    //ajout de la condition
    putQuery += " WHERE idvehicule=" + req.params.idUpdate;

    console.log('Query send: ' + putQuery .green);

    var query = conn.query(putQuery, function(err, infos){

      if(err){
        console.log(err);
        res.send(err);
      }
      res.json(infos);
    });

  });

});

// | DELETE | delete data to DB |
//------------------------------------------------------------------------------
router.route('/:table/:idDelete').delete(function(req, res){

  req.getConnection(function(err,conn){

    if (err) return console.log('Connection fail: ' + err .red);
    var idName;
    var idNameQuery = "SELECT column_name FROM information_schema.key_column_usage WHERE table_schema = " + "'" + DBLocation + "'" + " AND table_name = " + "'" + req.params.table + "'" + " AND constraint_name = 'primary'";
    var getIdName = conn.query(idNameQuery , function(err, rows){
      if(err){
        console.log(err);
        res.send(err);
      }
      idName = rows[0].column_name;
      var delQuery = "DELETE FROM " + DBLocation + "." + req.params.table + " WHERE " + idName + "=" + req.params.idDelete;
      var query = conn.query(delQuery, function(err, infos){

        if(err){
          console.log(err);
          res.send(err);
        }
        console.log('Query send: ' + delQuery .green);
        res.json(infos);
      });
    });

  });

});

//START THE SERVER
//============================================================
app.listen(port);
console.log('Le port du site est: ' + port);
