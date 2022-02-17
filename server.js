const express = require('express');
var bodyParser = require('body-parser');
const app = express();
var path = require('path');
var bunyan = require('bunyan');
var fs = require('fs');
var yamlconfig = require('yaml-config');

//MiddleWare
// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json());

var settings = yamlconfig.readConfig(path.join(__dirname, 'config.yaml'));


function createLoggerr(yamlconfig){
  var pkg = require(path.join(__dirname, 'package')),
      appName = pkg.name,
      appVersion = pkg.version,
      logDir = yamlconfig.dir || path.join(__dirname, 'logs'),
      logFile = path.join(logDir, appName + '-log.json'),
      logErrorFile = path.join(logDir, appName + '-errors.json'),
      logLevel = yamlconfig.level || 'debug'

  if(! fs.existsSync(logDir)) fs.mkdirSync(logDir);

  var log = bunyan.createLogger({
      name: appName,
          streams: [
              {
                  stream: process.stdout,
                  level: 'warn'
              },
              {
                  path: logFile,
                  level: logLevel,
                  type: 'rotating-file'
              },
              {
                  path: logErrorFile,
                  level: 'error'
              }
          ],
          serializers: bunyan.stdSerializers
  });


  log.info('Starting ' + appName + ', version ' + appVersion);
  log.info('Environment set to ' + process.env.NODE_ENV);
  log.debug('Logging setup completed');
}


createLoggerr(settings.logs);


function genratelog(){
  try{
    app.get('/v1/log', (req, res) => {
      console.log("API is hitting");
      res.send("API is working").status(200);
      res.end();
    })
  }catch(error){
    
  }
}
genratelog();

function hello(){
  try{
    app.get('/v1/hello', (req, res) => {
      console.log("Hello");
      res.send("hello").status(200);
      res.end();
    })
  }catch(error){
    
  }
}
hello();


let port = 5000;


// app listening
app.listen(port, () => {
  console.log(`Server is listening on Port ${port}!`)
});
