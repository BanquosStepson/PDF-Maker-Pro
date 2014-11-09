class CanvasPdfDocument
    constructor: (@canvas_elem=null,
                  @title=''
                  @filename = ''
                  @datecreated = ''
                  @lastmod = ''
                  @pg_dimensions = {}
                  @pages = []
                  @settings = {}) ->
        @pages = [new CanvasPage()]
        @pg_dimensions =
            x: 500
            y: 750
            # 8.5x11 paper
            # x: 1224
            # y: 1584
        @canvas_mgr = new CanvasManager(@canvas_elem, @pg_dimensions)
        @renderPages()

    updateTitle: (title) ->
        undefined
    updateFilename: (filename) ->
        undefined
    updateLastMod: (lastMod) ->
        undefined
    addPage: (page) ->
        undefined
    updateSettings: (settings) ->
        undefined
    getSettings: ->
        undefined
    saveDoc: ->
        undefined
    generateJSON: ->
        undefined
    loadJSON: (json_str) ->
        undefined
    renderPages: ->
        undefined