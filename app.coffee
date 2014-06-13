#Module dependencies
express  = require "express"
stylus   = require "stylus"
nib      = require "nib"
route    = require "./routes"

#Express yourself!
app = express()

#Setup: Begin
compile = (str, path) ->
    stylus(str).set("filename", path).use(nib())
        
app.set "views", __dirname + "/views"
app.set "view engine", "jade"
app.use express.logger "dev"
app.use stylus.middleware
    src:     __dirname + "/public"
    compile: compile

app.use express.static __dirname + "/public"
app.use express.bodyParser()
#Setup: End

#Routes
app.get  "/", route.index
app.get  "/partials/:name", route.partials

# Handle 404
app.use (req, res, next) ->
  res.status 404

  # respond with html page
  if req.accepts("html")
    res.render "partials/404", { url: req.url, title: "Oh no!" }
    return

  # respond with json
  if req.accepts "json"
    res.send { error: "Not found" }
    return

  # default to plain-text. send()
  res.type("txt").send "Not found"

#Launch
app.listen 8123
console.log "Node @ http:#localhost:8123...\n"