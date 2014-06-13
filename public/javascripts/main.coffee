requirejs.config
    paths: 
        "jquery":     "../vendor/jquery/dist/jquery.min"
        "underscore": "../vendor/underscore/underscore"
        "backbone":   "../vendor/backbone/backbone"
        
require ["jquery", "underscore", "backbone"], ($, _, Backbone) ->
    console.log "Running..."