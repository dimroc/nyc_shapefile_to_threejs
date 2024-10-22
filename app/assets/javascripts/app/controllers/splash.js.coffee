$ = jQuery.sub()
World = App.World
Block = App.Block

class App.Controller.Splash extends Spine.Controller
  className: 'splash'

  constructor: ->
    super
    World.bind 'refresh change', @render
    World.fetch()

  render: =>
    world = World.first()

    if !Env.isChrome23
      @html @view('splash/browserError')(regionNames: world.region_names)
    else
      @html @view('splash/index')(regionNames: world.region_names)
      world.fetchRegions(@_loadCallback)

  activate: ->
    @el.fadeIn(=> @el.addClass("active"))
    @

  deactivate: ->
    @el.empty()

  _loadCallback: =>
    @navigate '/boroughs' if location.pathname == "/"
