var express = require('express');
var app = express();
// var mysql = require('./dbcon.js');
var handlebars = require('express-handlebars').create({defaultLayout:'main',});
var bodyParser = require('body-parser');

app.set('view engine', 'handlebars');
app.engine('handlebars', handlebars.engine);
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.set('port', process.argv[2]);
//app.set('mysql', mysql);


///////////////////////// UPDATE
app.use('/', express.static('public'));
app.use('/students', require('./students.js'));
///////////////////////// UPDATE


app.use(function(req,res){
    res.status(404);
    res.render('404');
  });
  
app.use(function(err, req, res, next){
  console.error(err.stack);
  res.status(500);
  res.render('500');
});

app.listen(app.get('port'), function(){
  console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});